#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "malloc.h"
#include "string.h"
#include "sys/stat.h"
#include "fcntl.h"


#ifdef _WIN32
    #include "windows.h"
#endif


#ifdef VERBOSE
    #define VERBOSE_INFO(...) printf(__VA_ARGS__)
#else
    #define VERBOSE_INFO(...)
#endif


#define NOT_DEFINE_INTEGER_TYPES
#include "../utils/assembler.h"
#include "../utils/specs.h"
#include "spu.h"


void send_port(struct spu *s, int32_t port, BYTE *data, size_t count)
{
    for (size_t i = 0; i < s->port_mappings_len; ++i)
    {
        if (s->port_mappings[i].port == port)
        {
            if (s->port_mappings[i].send != NULL)
            {
                s->port_mappings[i].send(s->port_mappings + i, data, count);
            }
        }
    }
}


void read_port(struct spu *s, int32_t port, BYTE *data, size_t count)
{
    for (size_t i = 0; i < s->port_mappings_len; ++i)
    {
        if (s->port_mappings[i].port == port)
        {
            if (s->port_mappings[i].read != NULL)
            {
                s->port_mappings[i].read(s->port_mappings + i, data, count);
            }
        }
    } 
}


void dump(BYTE *s, size_t from, size_t to)
{
    size_t i = from;
    printf("         _ %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X _\n", 
            0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15); // TODO: WHY?
    while (i <= to)
    {
        printf("%08x : ", (int)i);
        for (int x = 0; x < 16; ++x)
        {
            printf("%02x ", s[i]);
            i++;
        }
        printf("\n");
    }
}


void large_integer_inc(BYTE *s, size_t size)
{
    int carry = 1;
    for (size_t i = 0; i < size && carry != 0; ++i)
    {
        int res = s[i] + carry;
        s[i] = res; // TODO: make truncation explicit
        carry = res >> 8; // TODO: sizeof(char) * CHAR_BIT
    }
}


void large_integer_dec(BYTE *s, size_t size)
{
    int carry = -1;
    for (size_t i = 0; i < size && carry != 0; ++i)
    {
        int res = s[i] + carry;
        carry = (s[i] == 0 ? -1 : 0);
        s[i] = res;
    }
}


void large_integer_add(BYTE *s, BYTE *a, size_t size)
{
    int carry = 0;
    for (size_t i = 0; i < size; ++i)
    {
        int res = s[i] + a[i] + carry;
        s[i] = res;
        carry = res / 256; // TODO: 256?
    }
}


void large_integer_sub(BYTE *s, BYTE *a, size_t size)
{
    int carry = 0;
    for (size_t i = 0; i < size; ++i)
    {
        int res = (int)s[i] - (int)a[i] + carry;
        if (res < 0)
        {
            res += 256;
            carry = -1;
        }
        else
        {
            carry = 0;
        }
        s[i] = res;
    }
}


// TODO: uint64_t as base?

void large_integer_mul(BYTE *s, BYTE *a, size_t size)
{
    if (size == 8)
    {
        *(int64_t *)s = (*(int64_t *)s) * (*(int64_t *)a);
        return;
    }
    if (size == 4)
    {
        *(int32_t *)s = (*(int32_t *)s) * (*(int32_t *)a);
        return;
    }
    if (size == 2)
    {
        *(int16_t *)s = (*(int16_t *)s) * (*(int16_t *)a);
        return;
    }
    if (size == 1)
    {
        *(int8_t *)s = (*(int8_t *)s) * (*(int8_t *)a);
        return;
    }
    
    BYTE *tmp = calloc(1, size);
    memcpy(tmp, s, size);
    memset(s, 0, size);

    for (size_t k = 0; k < size; ++k)
    {
        int carry = 0;
        int mul = tmp[k];
        for (size_t i = 0; i < size - k; ++i)
        {
            int res = s[i + k] + a[i] * mul + carry;
            s[i + k] = res;
            carry = res / 256;
        }
    }
    
    free(tmp);
}


void large_integer_div(BYTE *s, BYTE *a, size_t size)
{
    if (size == 8)
    {
        *(int64_t *)s = (*(int64_t *)s) / (*(int64_t *)a);
        return;
    }
    if (size == 4)
    {
        *(int32_t *)s = (*(int32_t *)s) / (*(int32_t *)a);
        return;
    }
    if (size == 2)
    {
        *(int16_t *)s = (*(int16_t *)s) / (*(int16_t *)a);
        return;
    }
    if (size == 1)
    {
        *(int8_t *)s = (*(int8_t *)s) / (*(int8_t *)a);
        return;
    }
    fprintf(stderr, "-----: not implemented: integer division\n");
    abort();
}

int32_t large_integer_less(BYTE *a, BYTE *b, size_t size)
{
    for (size_t x = size - 1; x < size; --x)
    {
        if (a[x] != b[x])
        {
            return (a[x] < b[x] ? -1 : 0);
        }
    }
    return 0;
}


#define GET_ARG(s, ip, id) (*((int32_t *)((s)->mem + ip + 1 + 4 * (id))))
#define INT_FROM(s, pos) (*((int32_t *)((s)->mem + (pos))))



// instructions.inc
// INSTRUCTION(MOV, 2, DO(OUT = IN))
// ...

// #define INSTRUCTION(name, count, block) else if (strcmp(command_name, #name) == 0)...
// #include "instruction.inc"

// TODO: don't, just don't
// X-macro
#define READ_DST_SRC_COUNT \
    int32_t dst = GET_ARG(s, ip, 0) + ip; \
    int32_t src = GET_ARG(s, ip, 1) + ip; \
    int32_t cnt = GET_ARG(s, ip, 2) + ip; \
    \
    if ((opcode & ARG_PTR_OPCODE_MASK) == ARG_PTR_ON_PTR) \
    { \
        VERBOSE_INFO("dest = *%08x=%08x src = *%08x=%08x cnt = *%08x=%08x\n", dst, INT_FROM(s, dst), src, INT_FROM(s, src), cnt, INT_FROM(s, cnt)); \
        dst = INT_FROM(s, dst); \
        src = INT_FROM(s, src); \
        cnt = INT_FROM(s, cnt); \
    }

#define READ_DST_A_B_COUNT \
    int32_t dst = GET_ARG(s, ip, 0) + ip; \
    int32_t a   = GET_ARG(s, ip, 1) + ip; \
    int32_t b   = GET_ARG(s, ip, 2) + ip; \
    int32_t cnt = GET_ARG(s, ip, 3) + ip; \
    \
    if ((opcode & ARG_PTR_OPCODE_MASK) == ARG_PTR_ON_PTR) \
    { \
        VERBOSE_INFO("dest = *%08x=%08x a = *%08x=%08x b = *%08x=%08x cnt = *%08x=%08x\n", dst, INT_FROM(s, dst), a, INT_FROM(s, a), b, INT_FROM(s, b), cnt, INT_FROM(s, cnt)); \
        dst = INT_FROM(s, dst); \
        a   = INT_FROM(s, a); \
        b   = INT_FROM(s, b); \
        cnt = INT_FROM(s, cnt); \
    }


void run(struct spu *s)
{
    while (1)
    {
        #ifdef DUMP_MEM
            dump(s->mem, 0x3FF0, 0x4200);
        #endif
        /* load instruction */
        uint32_t ip = ((uint32_t *)s->mem)[0];
        VERBOSE_INFO("IP = %08x\n", ip);

        if (ip > s->mem_size)
        {
            fprintf(stderr, "Error: ip is outside of memory bounds.\n");
            break;
        }
        
        ssize_t cmd_size = decode_instruction_length(s->mem + ip);
        
        INT_FROM(s, 0) = ip + cmd_size;
        
        /* run instruction */
        BYTE opcode = s->mem[ip];
        switch (opcode & (~ARG_PTR_OPCODE_MASK))
        {
            case O_NOP:
            {
                /* step to next command */
                VERBOSE_INFO("NOP\n");
                break;
            }
            case O_INT:
            {
                int32_t type = GET_ARG(s, ip, 0);
                int32_t ptr  = GET_ARG(s, ip, 1) + ip;

                (void)type;
                (void)ptr;

                VERBOSE_INFO("Error: int command for now is unsopported [%d, %x].\n", type, ptr);
                break;
            }
            case O_MOV_CONST:
            {
                uint32_t value = GET_ARG(s, ip, 0);
                int32_t ptr    = GET_ARG(s, ip, 1) + ip;

                if ((opcode & ARG_PTR_OPCODE_MASK) == ARG_PTR_ON_PTR)
                {
                    VERBOSE_INFO("ptr = *%08x=%08x\n", ptr, INT_FROM(s, ptr));
                    ptr = INT_FROM(s, ptr);
                }

                VERBOSE_INFO("MOV_CONST set to %08x from %08x\n", ptr, value);
                INT_FROM(s, ptr) = value;
                break;
            }
            case O_LEA:
            {
                int32_t dst = GET_ARG(s, ip, 0) + ip;
                int32_t ptr = GET_ARG(s, ip, 1) + ip;

                if ((opcode & ARG_PTR_OPCODE_MASK) == ARG_PTR_ON_PTR)
                {
                    VERBOSE_INFO("dest = *%08x=%08x\n", dst, INT_FROM(s, dst));
                    dst = INT_FROM(s, dst);
                }

                VERBOSE_INFO("LEA set to %08x = %08x\n", dst, ptr);
                INT_FROM(s, dst) = ptr;
                break;
            }
            case O_MOV:
            {
                READ_DST_SRC_COUNT
                
                VERBOSE_INFO("MOV: set to %08x from %08x of length *%08x=%08x\n", dst, src, cnt, INT_FROM(s, cnt));
                memmove(s->mem + dst, s->mem + src, INT_FROM(s, cnt));
                break;
            }
            case O_INV:
            {
                READ_DST_SRC_COUNT

                VERBOSE_INFO("INV: set to %08x from %08x of length *%08x=%08x\n", dst, src, cnt, INT_FROM(s, cnt));
                cnt = INT_FROM(s, cnt);
                
                for (ssize_t i = 0; i < cnt; ++i)
                {
                    s->mem[dst + i] = ~s->mem[src + i];
                }
                break;
            }
            case O_NEG:
            {
                READ_DST_SRC_COUNT  

                VERBOSE_INFO("NEG: set to %08x from %08x of length *%08x=%08x\n", dst, src, cnt, INT_FROM(s, cnt));
                cnt = INT_FROM(s, cnt);

                for (ssize_t i = 0; i < cnt; ++i)
                {
                    s->mem[dst + i] = ~s->mem[src + i];
                }
                large_integer_inc(s->mem + dst, cnt);
                break;
            }
            case O_INC:
            {
                READ_DST_SRC_COUNT  

                VERBOSE_INFO("INC: set to %08x from %08x of length *%08x=%08x\n", dst, src, cnt, INT_FROM(s, cnt));
                cnt = INT_FROM(s, cnt);

                if (dst != src)
                {
                    memcpy(s->mem + dst, s->mem + src, cnt);
                }
                large_integer_inc(s->mem + dst, cnt);
                break;
            }
            case O_DEC:
            {
                READ_DST_SRC_COUNT  

                VERBOSE_INFO("DEC: set to %08x from %08x of length *%08x=%08x\n", dst, src, cnt, INT_FROM(s, cnt));
                cnt = INT_FROM(s, cnt);

                if (dst != src)
                {
                    memcpy(s->mem + dst, s->mem + src, cnt);
                }
                large_integer_dec(s->mem + dst, cnt);
                break;
            }
            case O_ALL:
            {
                READ_DST_SRC_COUNT  

                VERBOSE_INFO("ALL: set to %08x from %08x of length *%08x=%08x\n", dst, src, cnt, INT_FROM(s, cnt));
                cnt = INT_FROM(s, cnt);

                BYTE total = 0xFF;
                for (ssize_t i = 0; i < cnt; ++i)
                {
                    total &= s->mem[src + i];
                }
                INT_FROM(s, dst) = (total == 0xFF ? 0xFFFFFFFF : 0);
                break;
            }
            case O_ANY:
            {
                READ_DST_SRC_COUNT  

                VERBOSE_INFO("ANY: set to %08x from %08x of length *%08x=%08x\n", dst, src, cnt, INT_FROM(s, cnt));
                cnt = INT_FROM(s, cnt);

                BYTE total = 0;
                for (ssize_t i = 0; i < cnt; ++i)
                {
                    total |= s->mem[src + i];
                }
                INT_FROM(s, dst) = (total == 0 ? 0 : 0xFFFFFFFF);
                break;
            }
            case O_CLEA:
            {            
                int32_t flg = GET_ARG(s, ip, 0) + ip;
                int32_t dst = GET_ARG(s, ip, 1) + ip;
                int32_t ptr = GET_ARG(s, ip, 2) + ip;

                if ((opcode & ARG_PTR_OPCODE_MASK) == ARG_PTR_ON_PTR)
                {
                    VERBOSE_INFO("dest = *%08x=%08x  flag = *%08x=%08x\n", dst, INT_FROM(s, dst), flg, INT_FROM(s, flg));
                    flg = INT_FROM(s, flg);
                    dst = INT_FROM(s, dst);
                }

                VERBOSE_INFO("CLEA set to %08x = %08x IF FLAG from %08x=%08x\n", dst, ptr, flg, INT_FROM(s, flg));
                if (INT_FROM(s, flg) != 0)
                {
                    INT_FROM(s, dst) = ptr;
                }
                break;
            }
            case O_IN:
            {            
                int32_t port  = GET_ARG(s, ip, 0);
                int32_t ptr   = GET_ARG(s, ip, 1) + ip;
                int32_t count = GET_ARG(s, ip, 2) + ip;

                if ((opcode & ARG_PTR_OPCODE_MASK) == ARG_PTR_ON_PTR)
                {
                    VERBOSE_INFO("ptr = *%08x=%08x  count = *%08x=%08x\n", ptr, INT_FROM(s, ptr), count, INT_FROM(s, count));
                    ptr = INT_FROM(s, ptr);
                    count = INT_FROM(s, count);
                }

                VERBOSE_INFO("IN read from port %08x data to %08x of count *%08x=%08x\n", port, ptr, count, INT_FROM(s, count));
                read_port(s, port, s->mem + ptr, INT_FROM(s, count));
                break;
            }
            case O_OUT:
            {            
                int32_t port  = GET_ARG(s, ip, 0);
                int32_t ptr   = GET_ARG(s, ip, 1) + ip;
                int32_t count = GET_ARG(s, ip, 2) + ip;

                if ((opcode & ARG_PTR_OPCODE_MASK) == ARG_PTR_ON_PTR)
                {
                    VERBOSE_INFO("ptr = *%08x=%08x  count = *%08x=%08x\n", ptr, INT_FROM(s, ptr), count, INT_FROM(s, count));
                    ptr = INT_FROM(s, ptr);
                    count = INT_FROM(s, count);
                }

                VERBOSE_INFO("OUT send to port %08x data from %08x of count *%08x=%08x\n", port, ptr, count, INT_FROM(s, count));
                send_port(s, port, s->mem + ptr, INT_FROM(s, count));
                break;
            }
            case O_EQ:
            {
                READ_DST_A_B_COUNT  

                VERBOSE_INFO("EQ: set to %08x from %08x and %08x of length *%08x=%08x\n", dst, a, b, cnt, INT_FROM(s, cnt));
                cnt = INT_FROM(s, cnt);

                for (ssize_t i = 0; i < cnt; ++i)
                {
                    s->mem[dst + i] = ~(s->mem[a + i] ^ s->mem[b + i]);
                }
                break;
            }
            case O_OR:
            {
                READ_DST_A_B_COUNT  

                VERBOSE_INFO("OR: set to %08x from %08x and %08x of length *%08x=%08x\n", dst, a, b, cnt, INT_FROM(s, cnt));
                cnt = INT_FROM(s, cnt);

                for (ssize_t i = 0; i < cnt; ++i)
                {
                    s->mem[dst + i] = s->mem[a + i] | s->mem[b + i];
                }
                break;
            }
            case O_AND:
            {
                READ_DST_A_B_COUNT  

                VERBOSE_INFO("AND: set to %08x from %08x and %08x of length *%08x=%08x\n", dst, a, b, cnt, INT_FROM(s, cnt));
                cnt = INT_FROM(s, cnt);

                for (ssize_t i = 0; i < cnt; ++i)
                {
                    s->mem[dst + i] = s->mem[a + i] & s->mem[b + i];
                }
                break;
            }
            case O_XOR:
            {
                READ_DST_A_B_COUNT  

                VERBOSE_INFO("XOR: set to %08x from %08x and %08x of length *%08x=%08x\n", dst, a, b, cnt, INT_FROM(s, cnt));
                cnt = INT_FROM(s, cnt);

                for (ssize_t i = 0; i < cnt; ++i)
                {
                    s->mem[dst + i] = s->mem[a + i] ^ s->mem[b + i];
                }
                break;
            }
            case O_CMOV:
            {
                READ_DST_A_B_COUNT

                VERBOSE_INFO("CMOV: set to %08x from %08x of length *%08x=%08x ONLY IF %08x=%08x != 0\n", a, b, cnt, INT_FROM(s, cnt), dst, INT_FROM(s, dst));
                cnt = INT_FROM(s, cnt);
                dst = INT_FROM(s, dst);

                if (dst != 0)
                {
                    memmove(s->mem + a, s->mem + b, cnt);
                }
                break;
            }
            case O_LT:
            {
                READ_DST_A_B_COUNT

                VERBOSE_INFO("LT: set to %08x from %08x and %08x of length *%08x=%08x\n", dst, a, b, cnt, INT_FROM(s, cnt));
                cnt = INT_FROM(s, cnt);

                INT_FROM(s, dst) = large_integer_less(s->mem + a, s->mem + b, cnt);
                break;
            }
            case O_ADD:
            {
                READ_DST_A_B_COUNT

                VERBOSE_INFO("ADD: set to %08x from %08x and %08x of length *%08x=%08x\n", dst, a, b, cnt, INT_FROM(s, cnt));
                cnt = INT_FROM(s, cnt);

                if (dst != a)
                {
                    memcpy(s->mem + dst, s->mem + a, cnt);
                }
                large_integer_add(s->mem + dst, s->mem + b, cnt);
                break;
            }
            case O_SUB:
            {
                READ_DST_A_B_COUNT

                VERBOSE_INFO("SUB: set to %08x from %08x and %08x of length *%08x=%08x\n", dst, a, b, cnt, INT_FROM(s, cnt));
                cnt = INT_FROM(s, cnt);

                if (dst != a)
                {
                    memcpy(s->mem + dst, s->mem + a, cnt);
                }
                large_integer_sub(s->mem + dst, s->mem + b, cnt);
                break;
            }
            case O_MUL:
            {
                READ_DST_A_B_COUNT

                VERBOSE_INFO("MUL: set to %08x from %08x and %08x of length *%08x=%08x\n", dst, a, b, cnt, INT_FROM(s, cnt));
                cnt = INT_FROM(s, cnt);

                if (dst != a)
                {
                    memcpy(s->mem + dst, s->mem + a, cnt);
                }
                large_integer_mul(s->mem + dst, s->mem + b, cnt);
                break;
            }
            case O_DIV:
            {
                READ_DST_A_B_COUNT

                VERBOSE_INFO("DIV: set to %08x from %08x and %08x of length *%08x=%08x\n", dst, a, b, cnt, INT_FROM(s, cnt));
                cnt = INT_FROM(s, cnt);

                if (dst != a)
                {
                    memcpy(s->mem + dst, s->mem + a, cnt);
                }
                large_integer_div(s->mem + dst, s->mem + b, cnt);
                break;
            }
            default:
            {
                fprintf(stderr, "Error: unkown opcode: 0x%02x [from 0x%02x] at %08x\n", (opcode & (~ARG_PTR_OPCODE_MASK)), opcode, ip);
                return;
            }
        }
    }
}


int main(int argc, char **argv)
{
    struct spu s = {};
    size_t entry_ptr = 0;

    for (int i = 1; i < argc; ++i)
    {
        if (strcmp(argv[i], "-map") == 0)
        {
            if (i + 1 < argc)
            {
                if (load_spu_port_mapping(&s, argv[i + 1]) != 0)
                {
                    fprintf(stderr, "load_spu_port_mapping error\n");
                    return 1;
                }

                printf("x...\n");

                i += 1; /* skip N parameters of -map flag */
                continue;
            }
            else
            {
                fprintf(stderr, "Error: -map flag wasn't followed by mapping string\n");
                return 1;
            }
        }
        else if (strcmp(argv[i], "-mem") == 0)
        {
            if (s.mem != NULL)
            {
                fprintf(stderr, "Error: -mem must be specified before any action which loads memory (for example -image flag) or there is two -mem flags\n");
                return 1;
            }
            if (i + 1 < argc)
            {
                char *end = NULL;
                size_t size = strtoull(argv[i + 1], &end, 0);
                if (*end != '\0')
                {
                    fprintf(stderr, "Error: memory must be unsigned integer - memory size in bytes.");
                    return 1;
                }
                s.mem_size = size;

                i += 1; /* skip N parameters of -mem flag */
                continue;
            }
            else
            {
                fprintf(stderr, "Error: -mem flag wasn't followed by memory size in bytes\n");
                return 1;
            }
        }
        else if (strcmp(argv[i], "-image") == 0)
        {
            if (i + 2 >= argc)
            {
                fprintf(stderr, "Error: -image flag wasn't followed by image offset in bytes, and by path to file\n");
                return 1;
            }
            if (s.mem == NULL)
            {
                if (s.mem_size == 0)
                {
                    printf("Using default memory size: 64MB\n");
                    s.mem_size = 64 * 1024 * 1024;
                }
                #ifdef _WIN32
                    // size_t min_size = GetLargePageMinimum();
                    // s.mem_size /= min_size;
                    // s.mem_size *= min_size;
                    // s.mem_size += min_size;
                    // printf("%zu\n", s.mem_size);
                    s.mem = VirtualAlloc(NULL, s.mem_size, MEM_COMMIT, PAGE_READWRITE); // MEM_LARGE_PAGES
                    if (s.mem == NULL)
                    {
                        printf("Memory allocation denied: %ld\n", GetLastError());
                        return 1;
                    }
                #else
                    s.mem = malloc(s.mem_size);
                    if (s.mem == NULL)
                    {
                        printf("Memory allocation denied\n");
                        return 1;
                    }
                #endif
                memset(s.mem, 0, s.mem_size);
            }
            /* load image into given address */
            char *end = NULL;
            size_t load_address = strtoull(argv[i + 1], &end, 0);
            if (*end != '\0')
            {
                fprintf(stderr, "Error: image offset must be unsigned integer.");
                return 1;
            }
            char *image_filename = argv[i + 2];
            {
                struct stat file_stat;
                FILE *f = fopen(image_filename, "rb");
                if (fstat(fileno(f), &file_stat) != 0)
                {
                    fprintf(stderr, "cannot open/find image %s\n", image_filename);
                    return 1;
                }
                ssize_t len = fread(s.mem + load_address, 1, file_stat.st_size, f);
                printf("image loaded by offset %zu, read %zu bytes\n", load_address, len);
                fclose(f);
            }

            i += 2; /* skip N parameters of -image flag */
            continue;
        }
        else if (strcmp(argv[i], "-entry") == 0)
        {
            if (entry_ptr != 0)
            {
                fprintf(stderr, "Error: -entry was passed twice; previous value: %zu\n", entry_ptr);
                return 1;
            }
            if (i + 1 < argc)
            {
                char *end = NULL;
                size_t size = strtoull(argv[i + 1], &end, 0);
                if (*end != '\0')
                {
                    fprintf(stderr, "Error: entry offset must be unsigned integer - entry offset in bytes.");
                    return 1;
                }
                if (size == 0)
                {
                    fprintf(stderr, "Error: entry offset must be non zero [zero is IP, so it is some wrong usage].");
                    return 1;
                }
                entry_ptr = size;

                i += 1; /* skip N parameters of -entry flag */
                continue;
            }
            else
            {
                fprintf(stderr, "Error: -entry flag wasn't followed by entry offset size in bytes\n");
                return 1;
            }
        }
        else
        {
            printf("Unknown flag: %s\n", argv[i]);
            return 1;
        }
    }
    
    if (s.mem == NULL)
    {
        fprintf(stderr, "Error: no images provided.\n");
        return 1;
    }

    /* set instruction pointer */
    if (entry_ptr == 0)
    {
        ((uint32_t *)s.mem)[0] = 0x4000;
        printf("Using default entry pointer: %u\n", ((uint32_t *)s.mem)[0]);
    }
    else
    {
        if (entry_ptr >= s.mem_size)
        {
            fprintf(stderr, "Error: entry offset is outsize of SPU memory. [%zu > %zu]\n", entry_ptr, s.mem_size);
            return 1;
        }
        ((uint32_t *)s.mem)[0] = entry_ptr;
    }

    printf("Running...\n");

    run(&s);
    
    #ifdef DUMP_MEM
        dump(s.mem, 0x3FF0, 0x4100);
    #endif
}

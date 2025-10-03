#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "malloc.h"
#include "string.h"
#include "sys/stat.h"
#include "fcntl.h"


#ifdef _WIN32
    #include "windows.h"
#endif


#define NOT_DEFINE_INTEGER_TYPES
#include "../utils/assembler.h"
#include "../utils/specs.h"




void dump(BYTE *s, size_t from, size_t to)
{
    size_t i = from;
    printf("         _ %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X _\n", 
            0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);
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
        s[i] = res;
        carry = res >> 8;
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
        carry = res / 256;
    }
}


void large_integer_sub(BYTE *s, BYTE *a, size_t size)
{
    int carry = 0;
    for (size_t i = 0; i < size; ++i)
    {
        int res = s[i] - a[i] + carry;
        s[i] = res;
        carry = res / 256;
    }
}


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


#define GET_ARG(s, ip, id) (*((int32_t *)((s)->mem + ip + 1 + 4 * (id))))
#define INT_FROM(s, pos) (*((int32_t *)((s)->mem + (pos))))


#define READ_DST_SRC_COUNT \
    int32_t dst = GET_ARG(s, ip, 0) + ip; \
    int32_t src = GET_ARG(s, ip, 1) + ip; \
    int32_t cnt = GET_ARG(s, ip, 2) + ip; \
    \
    if ((opcode & ARG_PTR_OPCODE_MASK) == ARG_PTR_ON_PTR) \
    { \
        printf("dest = *%08x=%08x src = *%08x=%08x cnt = *%08x=%08x\n", dst, INT_FROM(s, dst), src, INT_FROM(s, src), cnt, INT_FROM(s, cnt)); \
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
        printf("dest = *%08x=%08x a = *%08x=%08x b = *%08x=%08x cnt = *%08x=%08x\n", dst, INT_FROM(s, dst), a, INT_FROM(s, a), b, INT_FROM(s, b), cnt, INT_FROM(s, cnt)); \
        dst = INT_FROM(s, dst); \
        a   = INT_FROM(s, a); \
        b   = INT_FROM(s, b); \
        cnt = INT_FROM(s, cnt); \
    }


void run(struct spu *s)
{
    while (1)
    {
        dump(s->mem, 0x3FF0, 0x4100);
        /* load instruction */
        uint32_t ip = ((uint32_t *)s->mem)[0];
        printf("IP = %08x\n", ip);
        
        ssize_t cmd_size = decode_instruction_length(s->mem + ip);
        
        INT_FROM(s, 0) = ip + cmd_size;
        
        /* run instruction */
        BYTE opcode = s->mem[ip];
        switch (opcode & (~ARG_PTR_OPCODE_MASK))
        {
            case O_NOP:
            {
                /* step to next command */
                printf("NOP\n");
                break;
            }
            case O_INT:
            {
                int32_t type = GET_ARG(s, ip, 0);
                int32_t ptr  = GET_ARG(s, ip, 1) + ip;
                fprintf(stderr, "Error: int command for now is unsopported [%d, %x].\n", type, ptr);
                break;
            }
            case O_MOV_CONST:
            {
                uint32_t value = GET_ARG(s, ip, 0);
                int32_t ptr    = GET_ARG(s, ip, 1) + ip;

                if ((opcode & ARG_PTR_OPCODE_MASK) == ARG_PTR_ON_PTR)
                {
                    printf("ptr = *%08x=%08x\n", ptr, INT_FROM(s, ptr));
                    ptr = INT_FROM(s, ptr);
                }

                printf("MOV_CONST set to %08x from %08x\n", ptr, value);
                INT_FROM(s, ptr) = value;
                break;
            }
            case O_LEA:
            {
                int32_t dst = GET_ARG(s, ip, 0) + ip;
                int32_t ptr = GET_ARG(s, ip, 1) + ip;

                if ((opcode & ARG_PTR_OPCODE_MASK) == ARG_PTR_ON_PTR)
                {
                    printf("dest = *%08x=%08x\n", dst, INT_FROM(s, dst));
                    dst = INT_FROM(s, dst);
                }

                printf("LEA set to %08x = %08x\n", dst, ptr);
                INT_FROM(s, dst) = ptr;
                break;
            }
            case O_MOV:
            {
                READ_DST_SRC_COUNT
                
                printf("MOV: set to %08x from %08x of length *%08x=%08x\n", dst, src, cnt, INT_FROM(s, cnt));
                memmove(s->mem + dst, s->mem + src, INT_FROM(s, cnt));
                break;
            }
            case O_INV:
            {
                READ_DST_SRC_COUNT

                printf("INV: set to %08x from %08x of length *%08x=%08x\n", dst, src, cnt, INT_FROM(s, cnt));
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

                printf("NEG: set to %08x from %08x of length *%08x=%08x\n", dst, src, cnt, INT_FROM(s, cnt));
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

                printf("INC: set to %08x from %08x of length *%08x=%08x\n", dst, src, cnt, INT_FROM(s, cnt));
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

                printf("DEC: set to %08x from %08x of length *%08x=%08x\n", dst, src, cnt, INT_FROM(s, cnt));
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

                printf("ALL: set to %08x from %08x of length *%08x=%08x\n", dst, src, cnt, INT_FROM(s, cnt));
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

                printf("ANY: set to %08x from %08x of length *%08x=%08x\n", dst, src, cnt, INT_FROM(s, cnt));
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
                    printf("dest = *%08x=%08x  flag = *%08x=%08x\n", dst, INT_FROM(s, dst), flg, INT_FROM(s, flg));
                    flg = INT_FROM(s, flg);
                    dst = INT_FROM(s, dst);
                }

                printf("CLEA set to %08x = %08x IF FLAG from %08x=%08x\n", dst, ptr, flg, INT_FROM(s, flg));
                if (INT_FROM(s, flg) != 0)
                {
                    INT_FROM(s, dst) = ptr;
                }
                break;
            }
            case O_EQ:
            {
                READ_DST_A_B_COUNT  

                printf("EQ: set to %08x from %08x and %08x of length *%08x=%08x\n", dst, a, b, cnt, INT_FROM(s, cnt));
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

                printf("OR: set to %08x from %08x and %08x of length *%08x=%08x\n", dst, a, b, cnt, INT_FROM(s, cnt));
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

                printf("AND: set to %08x from %08x and %08x of length *%08x=%08x\n", dst, a, b, cnt, INT_FROM(s, cnt));
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

                printf("AND: set to %08x from %08x and %08x of length *%08x=%08x\n", dst, a, b, cnt, INT_FROM(s, cnt));
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

                printf("CMOV: set to %08x from %08x of length *%08x=%08x ONLY IF %08x=%08x != 0\n", a, b, cnt, INT_FROM(s, cnt), dst, INT_FROM(s, dst));
                cnt = INT_FROM(s, cnt);
                dst = INT_FROM(s, dst);

                if (dst != 0)
                {
                    memmove(s->mem + a, s->mem + b, cnt);
                }
                break;
            }
            case O_ADD:
            {
                READ_DST_A_B_COUNT

                printf("ADD: set to %08x from %08x and %08x of length *%08x=%08x\n", dst, a, b, cnt, INT_FROM(s, cnt));
                cnt = INT_FROM(s, cnt);

                if (dst != a)
                {
                    memcpy(s->mem + dst, s->mem + a, cnt);
                }
                printf("%d\n", INT_FROM(s, dst));
                printf("%d\n", INT_FROM(s, b));
                large_integer_add(s->mem + dst, s->mem + b, cnt);
                printf("->%d\n", INT_FROM(s, dst));
                break;
            }
            case O_SUB:
            {
                READ_DST_A_B_COUNT

                printf("SUB: set to %08x from %08x and %08x of length *%08x=%08x\n", dst, a, b, cnt, INT_FROM(s, cnt));
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

                printf("MUL: set to %08x from %08x and %08x of length *%08x=%08x\n", dst, a, b, cnt, INT_FROM(s, cnt));
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

                printf("DIV: set to %08x from %08x and %08x of length *%08x=%08x\n", dst, a, b, cnt, INT_FROM(s, cnt));
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
            fprintf(stderr, "Error: unkown opcode: 0x%02x [from 0x%02x]\n", (opcode & (~ARG_PTR_OPCODE_MASK)), opcode);
            return;
        }
        }
    }
}


int main()
{
    char *filename = "a.bc";

    /* allocate memory for computer */
    struct spu s;
    
    s.mem_size = 64 * 1024 * 1024;
    #ifdef _WIN32
        size_t min_size = GetLargePageMinimum();
        s.mem_size /= min_size;
        s.mem_size *= min_size;
        s.mem_size += min_size;
        printf("%zd\n", s.mem_size);
        s.mem = VirtualAlloc(NULL, s.mem_size, MEM_COMMIT, PAGE_READWRITE); // MEM_LARGE_PAGES
    #else
        s.mem = malloc(s.mem_size);
    #endif
    if (s.mem == NULL)
    {
        printf("Memory allocation denied: %ld\n", GetLastError());
        return 1;
    }
    memset(s.mem, 0, s.mem_size);

    printf("Memory allocated\n");

    /* load program */
    {
        size_t load_address = 0x4000;
        struct stat file_stat;
        int f = open(filename, O_RDONLY);
        if (fstat(f, &file_stat) != 0)
        {
            fprintf(stderr, "cannot open file %s\n", filename);
            return 1;
        }
        ssize_t len = read(f, s.mem + load_address, file_stat.st_size);
        printf("program loaded. read %zd bytes\n", len);
    }

    /* set instruction pointer */

    ((uint32_t *)s.mem)[0] = 0x4000;

    run(&s);
    dump(s.mem, 0x3FF0, 0x4100);
}

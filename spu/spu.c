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
    #define VERBOSE_INFO(...) PRINT_INFO(__VA_ARGS__)
#else
    #define VERBOSE_INFO(...)
#endif


#define NOT_DEFINE_INTEGER_TYPES
#include "../utils/assembler.h"
#include "../utils/specs.h"
#include "../logger/logger.h"
#include "spu.h"


#define MAP_BASE_SIZE_OPTIMIZATION(MACRO) \
    switch (size) \
    { \
        case sizeof(int8_t): \
            MACRO((*(int8_t *)s), (*(int8_t *)s), (*(int8_t *)a)); \
            return; \
        case sizeof(int16_t): \
            MACRO((*(int16_t *)s), (*(int16_t *)s), (*(int16_t *)a)); \
            return; \
        case sizeof(int32_t): \
            MACRO((*(int32_t *)s), (*(int32_t *)s), (*(int32_t *)a)); \
            return; \
        case sizeof(int64_t): \
            MACRO((*(int64_t *)s), (*(int64_t *)s), (*(int64_t *)a)); \
            return; \
        default: \
            break; \
    }


struct port_mapping_t *find_port_mapping(struct spu *s, int32_t port)
{
    for (size_t i = 0; i < s->port_mappings_len; ++i)
    {
        if (s->port_mappings[i].port == port)
        {
            return s->port_mappings + i;
        }
    }
    return NULL;
}


void send_port(struct spu *s, int32_t port, BYTE *data, size_t count)
{
    struct port_mapping_t *t = find_port_mapping(s, port);
    if (t != NULL && t->send != NULL)
    {
        t->send(t, data, count);
    }
}


void read_port(struct spu *s, int32_t port, BYTE *data, size_t count)
{
    struct port_mapping_t *t = find_port_mapping(s, port);
    if (t != NULL && t->send != NULL)
    {
        t->read(t, data, count);
    } 
}


void dump(BYTE *s, size_t from, size_t to)
{
    const int STEP = 16;
    size_t i = from;
    printf("         _ ");
    for (int i = 0; i < STEP; ++i)
    {
        printf("%02X ", i); // TODO: WHY?
    }
    printf(" _\n");
    while (i <= to)
    {
        printf("%08x : ", (int)i);
        for (int x = 0; x < STEP; ++x)
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
        uint32_t res = s[i] + carry;
        s[i] = (BYTE)res;
        carry = res >> (sizeof(BYTE) * CHAR_BIT);
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
    #define ADD(to, a, b) to = a + b;
    MAP_BASE_SIZE_OPTIMIZATION(ADD)
    #undef ADD
    
    int carry = 0;
    for (size_t i = 0; i < size; ++i)
    {
        uint32_t res = s[i] + a[i] + carry;
        s[i] = res;
        carry = res >> (sizeof(BYTE) * CHAR_BIT);
    }
}


void large_integer_sub(BYTE *s, BYTE *a, size_t size)
{
    #define SUB(to, a, b) to = a - b;
    MAP_BASE_SIZE_OPTIMIZATION(SUB)
    #undef SUB
    
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


void large_integer_mul(BYTE *s, BYTE *a, size_t size)
{
    #define MUL(to, a, b) to = a * b;
    MAP_BASE_SIZE_OPTIMIZATION(MUL)
    #undef MUL
    
    BYTE *tmp = calloc(1, size);
    memcpy(tmp, s, size);
    memset(s, 0, size);

    for (size_t k = 0; k < size; ++k)
    {
        int carry = 0;
        int mul = tmp[k];
        for (size_t i = 0; i < size - k; ++i)
        {
            uint32_t res = s[i + k] + a[i] * mul + carry;
            s[i + k] = res;
            carry = res >> (sizeof(BYTE) * CHAR_BIT);
        }
    }
    
    free(tmp);
}


void large_integer_div(BYTE *s, BYTE *a, size_t size)
{
    #define DIV(to, a, b) to = a / b;
    MAP_BASE_SIZE_OPTIMIZATION(DIV)
    #undef DIV
    
    PRINT_ERROR("-----: not implemented: integer division");
    abort();
}


int32_t large_unsigned_integer_less(BYTE *a, BYTE *b, size_t size)
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


int32_t large_integer_less(BYTE *a, BYTE *b, size_t size)
{
    
    if (size == 8)
    {
        return (*(int64_t *)a) < (*(int64_t *)b);
    }
    if (size == 4)
    {
        return (*(int32_t *)a) < (*(int32_t *)b);
    }
    if (size == 2)
    {
        return (*(int16_t *)a) < (*(int16_t *)b);
    }
    if (size == 1)
    {
        return (*(int8_t *)a) < (*(int8_t *)b);
    }
    int a_neg = a[size - 1] & 0x80;
    int b_neg = b[size - 1] & 0x80;

    if (!a_neg && !b_neg)
    {
        return large_unsigned_integer_less(a, b, size);
    }
    if (a_neg != b_neg)
    {
        return a_neg > b_neg;
    }
    return large_unsigned_integer_less(b, a, size);
}


#define GET_ARG(s, ip, id) (*((int32_t *)((s)->mem + ip + 1 + 4 * (id))))
#define INT_FROM(s, pos) (*((int32_t *)((s)->mem + (pos))))

/* logical conversions */
#define PTR_FROM_PTR(s, ptr) INT_FROM(s, ptr)
#define REL_TO_PTR(s, ptr) ((ptr) + ip)
#define PTR_TO_REAL(s, ptr) ((s)->mem + (ptr))

#define READ_DST_SRC_COUNT \
    int32_t dst = REL_TO_PTR(s, GET_ARG(s, ip, 0)); \
    int32_t src = REL_TO_PTR(s, GET_ARG(s, ip, 1)); \
    int32_t cnt = REL_TO_PTR(s, GET_ARG(s, ip, 2)); \
    \
    if ((opcode & ARG_PTR_OPCODE_MASK) == ARG_PTR_ON_PTR) \
    { \
        VERBOSE_INFO("dest = *%08x=%08x src = *%08x=%08x cnt = *%08x=%08x\n", \
                      dst, PTR_FROM_PTR(s, dst), \
                      src, PTR_FROM_PTR(s, src), \
                      cnt, PTR_FROM_PTR(s, cnt)); \
        dst = PTR_FROM_PTR(s, dst); \
        src = PTR_FROM_PTR(s, src); \
        cnt = PTR_FROM_PTR(s, cnt); \
    }

#define READ_DST_A_B_COUNT \
    int32_t dst = REL_TO_PTR(s, GET_ARG(s, ip, 0)); \
    int32_t a   = REL_TO_PTR(s, GET_ARG(s, ip, 1)); \
    int32_t b   = REL_TO_PTR(s, GET_ARG(s, ip, 2)); \
    int32_t cnt = REL_TO_PTR(s, GET_ARG(s, ip, 3)); \
    \
    if ((opcode & ARG_PTR_OPCODE_MASK) == ARG_PTR_ON_PTR) \
    { \
        VERBOSE_INFO("dest = *%08x=%08x a = *%08x=%08x b = *%08x=%08x cnt = *%08x=%08x\n", \
                      dst, PTR_FROM_PTR(s, dst), \
                      a, PTR_FROM_PTR(s, a), \
                      b, PTR_FROM_PTR(s, b), \
                      cnt, PTR_FROM_PTR(s, cnt)); \
        dst = PTR_FROM_PTR(s, dst); \
        a   = PTR_FROM_PTR(s, a); \
        b   = PTR_FROM_PTR(s, b); \
        cnt = PTR_FROM_PTR(s, cnt); \
    }


void run(struct spu *s)
{
    while (1)
    {
        #ifdef DUMP_MEM
            dump(s->mem, 0x3FF0, 0x4200);
        #endif
        /* load instruction */
        uint32_t ip = INT_FROM(s, 0);
        VERBOSE_INFO("IP = %08x\n", ip);

        if (ip >= s->mem_size)
        {
            PRINT_ERROR("ip is outside of memory bounds.");
            break;
        }
        
        int64_t cmd_size = decode_instruction_length(PTR_TO_REAL(s, ip));
        
        if (ip + cmd_size > (int64_t)s->mem_size)
        {
            PRINT_ERROR("ip + cmd_size is outside of memory bounds.");
            break;
        }
        
        INT_FROM(s, 0) = ip + cmd_size;
        
        /* run instruction */
        BYTE opcode = s->mem[ip];
        switch (opcode & (~ARG_PTR_OPCODE_MASK))
        {
        
            #define INSTRUCTION(opcode_macro, name, nargs, const_first_argument, opcode, handler) case opcode: {handler} break;
            #include "../utils/instructions.inc"
            #undef INSTRUCTION
            
            default:
            {
                PRINT_ERROR("unkown opcode: 0x%02x [from 0x%02x] at %08x", (opcode & (~ARG_PTR_OPCODE_MASK)), opcode, ip);
                return;
            }
        }
    }
}


static result_t allocate_memory(struct spu *s, size_t memsize)
{
    s->mem_size = memsize;
    #ifdef _WIN32
        // size_t min_size = GetLargePageMinimum();
        // s.mem_size /= min_size;
        // s.mem_size *= min_size;
        // s.mem_size += min_size;
        // printf("%zu\n", s.mem_size);
        s->mem = VirtualAlloc(NULL, s->mem_size, MEM_COMMIT, PAGE_READWRITE); // MEM_LARGE_PAGES
        if (s->mem == NULL)
        {
            PRINT_ERROR("Memory allocation denied: %ld", GetLastError());
            return 1;
        }
    #else
        s->mem = malloc(s->mem_size);
        if (s.mem == NULL)
        {
            PRINT_ERROR("Memory allocation denied");
            return 1;
        }
    #endif
    
    memset(s->mem, 0, s->mem_size);
    return 0;
}

static result_t load_image(struct spu *s, char *filename, size_t load_address)
{
    struct stat file_stat;
    FILE *f = fopen(filename, "rb");
    if (fstat(fileno(f), &file_stat) != 0)
    {
        PRINT_ERROR("cannot open/find image %s", filename);
        return 1;
    }
    int64_t len = fread(s->mem + load_address, 1, file_stat.st_size, f);
    PRINT_INFO("image loaded by offset %zu, read %zu bytes", load_address, len);
    fclose(f);
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
                    PRINT_ERROR("load_spu_port_mapping error");
                    return 1;
                }

                i += 1; /* skip N parameters of -map flag */
                continue;
            }
            else
            {
                PRINT_ERROR("-map flag wasn't followed by mapping string");
                return 1;
            }
        }
        else if (strcmp(argv[i], "-mem") == 0)
        {
            if (s.mem != NULL)
            {
                PRINT_ERROR("-mem must be specified before any action which loads memory (for example -image flag) or there is two -mem flags");
                return 1;
            }
            if (i + 1 < argc)
            {
                char *end = NULL;
                size_t size = strtoull(argv[i + 1], &end, 0);
                if (*end != '\0')
                {
                    PRINT_ERROR("memory must be unsigned integer - memory size in bytes.");
                    return 1;
                }
                s.mem_size = size;

                i += 1; /* skip N parameters of -mem flag */
                continue;
            }
            else
            {
                PRINT_ERROR("-mem flag wasn't followed by memory size in bytes");
                return 1;
            }
        }
        else if (strcmp(argv[i], "-image") == 0)
        {
            if (i + 2 >= argc)
            {
                PRINT_ERROR("-image flag wasn't followed by image offset in bytes, and by path to file");
                return 1;
            }
            if (s.mem == NULL)
            {
                if (s.mem_size == 0)
                {
                    PRINT_INFO("Using default memory size: 64MB");
                    s.mem_size = 64 * 1024 * 1024;
                }
                allocate_memory(&s, s.mem_size);
            }
            
            /* load image into given address */
            char *end = NULL;
            size_t load_address = strtoull(argv[i + 1], &end, 0);
            if (*end != '\0')
            {
                PRINT_ERROR("image offset must be unsigned integer.");
                return 1;
            }
            char *image_filename = argv[i + 2];


            load_image(&s, image_filename, load_address);

            i += 2; /* skip N parameters of -image flag */
            continue;
        }
        else if (strcmp(argv[i], "-entry") == 0)
        {
            if (entry_ptr != 0)
            {
                PRINT_ERROR("-entry was passed twice; previous value: %zu", entry_ptr);
                return 1;
            }
            if (i + 1 < argc)
            {
                char *end = NULL;
                size_t size = strtoull(argv[i + 1], &end, 0);
                if (*end != '\0')
                {
                    PRINT_ERROR("entry offset must be unsigned integer - entry offset in bytes.");
                    return 1;
                }
                if (size == 0)
                {
                    PRINT_ERROR("entry offset must be non zero [zero is IP, so it is some wrong usage].");
                    return 1;
                }
                entry_ptr = size;

                i += 1; /* skip N parameters of -entry flag */
                continue;
            }
            else
            {
                PRINT_ERROR("-entry flag wasn't followed by entry offset size in bytes");
                return 1;
            }
        }
        else
        {
            PRINT_ERROR("Unknown flag: %s", argv[i]);
            return 1;
        }
    }
    
    if (s.mem == NULL)
    {
        PRINT_ERROR("no images provided.");
        return 1;
    }

    /* set instruction pointer */
    if (entry_ptr == 0)
    {
        ((uint32_t *)s.mem)[0] = 0x4000;
        PRINT_INFO("Using default entry pointer: %u", ((uint32_t *)s.mem)[0]);
    }
    else
    {
        if (entry_ptr >= s.mem_size)
        {
            PRINT_ERROR("entry offset is outsize of SPU memory. [%zu > %zu]", entry_ptr, s.mem_size);
            return 1;
        }
        ((uint32_t *)s.mem)[0] = entry_ptr;
    }

    PRINT_INFO("Running...");

    run(&s);
    
    #ifdef DUMP_MEM
        dump(s.mem, 0x3FF0, 0x4100);
    #endif
}

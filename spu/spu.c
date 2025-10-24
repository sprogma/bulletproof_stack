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
        case sizeof(int8_t):  MACRO((*(int8_t *)first), (*(int8_t *)first), (*(int8_t *)second)); return; \
        case sizeof(int16_t): MACRO((*(int16_t *)first), (*(int16_t *)first), (*(int16_t *)second)); return; \
        case sizeof(int32_t): MACRO((*(int32_t *)first), (*(int32_t *)first), (*(int32_t *)second)); return; \
        case sizeof(int64_t): MACRO((*(int64_t *)first), (*(int64_t *)first), (*(int64_t *)second)); return; \
        default: break; \
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


void empty_port_fn(struct port_mapping_t *mapping, BYTE *data, size_t count)
{
    (void)mapping;
    (void)data;
    (void)count;
    return;
}

void send_port(struct spu *s, int32_t port, BYTE *data, size_t count)
{
    struct port_mapping_t *t = find_port_mapping(s, port);
    /* 
    if (t != NULL && t->send != NULL)
    {
        t->send(t, data, count);
    }
    */
    (t ? t->send : empty_port_fn)(t, data, count);
}


void read_port(struct spu *s, int32_t port, BYTE *data, size_t count)
{
    struct port_mapping_t *t = find_port_mapping(s, port);
    (t ? t->read : empty_port_fn)(t, data, count);
}


void dump(BYTE *s, size_t from, size_t to)
{
    const int STEP = 16;
    size_t i = from;
    printf("         _ ");
    for (int i = 0; i < STEP; ++i)
    {
        printf("%02X ", i);
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


void large_integer_add(BYTE *first, BYTE *second, size_t size)
{
    #define ADD(to, a, b) to = a + b;
    MAP_BASE_SIZE_OPTIMIZATION(ADD)
    #undef ADD
    
    int carry = 0;
    for (size_t i = 0; i < size; ++i)
    {
        uint32_t res = first[i] + second[i] + carry;
        first[i] = res;
        carry = res >> (sizeof(BYTE) * CHAR_BIT);
    }
}


void large_integer_sub(BYTE *first, BYTE *second, size_t size)
{
    #define SUB(to, a, b) to = a - b;
    MAP_BASE_SIZE_OPTIMIZATION(SUB)
    #undef SUB
    
    int carry = 0;
    for (size_t i = 0; i < size; ++i)
    {
        int res = (int)first[i] - (int)second[i] + carry;
        carry = (res < 0 ? -1 : 0);
        first[i] = res - carry * (1 << (sizeof(BYTE) * CHAR_BIT));
    }
}


void large_integer_mul(BYTE *first, BYTE *second, size_t size)
{
    #define MUL(to, a, b) to = a * b;
    MAP_BASE_SIZE_OPTIMIZATION(MUL)
    #undef MUL
    
    BYTE *tmp = calloc(1, size);
    memcpy(tmp, first, size);
    memset(first, 0, size);

    for (size_t k = 0; k < size; ++k)
    {
        int carry = 0;
        int mul = tmp[k];
        for (size_t i = 0; i < size - k; ++i)
        {
            uint32_t res = first[i + k] + second[i] * mul + carry;
            first[i + k] = res;
            carry = res >> (sizeof(BYTE) * CHAR_BIT);
        }
    }
    
    free(tmp);
}


void large_integer_div(BYTE *first, BYTE *second, size_t size)
{
    #define DIV(to, a, b) to = a / b;
    MAP_BASE_SIZE_OPTIMIZATION(DIV)
    #undef DIV
    
    PRINT_ERROR("-----: not implemented: integer division");
    abort();
}

int32_t large_unsigned_integer_less(BYTE *first, BYTE *second, size_t size)
{    
    for (size_t x = size - 1; x < size; --x)
    {
        if (first[x] != second[x])
        {
            return (first[x] < second[x] ? -1 : 0);
        }
    }
    return 0;
}


int32_t large_integer_less(BYTE *first, BYTE *second, size_t size)
{
    // can't use optimizate_size... becouse this construction needs non null return  
    if (size == 8)
    {
        return -((*(int64_t *)first) < (*(int64_t *)second));
    }
    if (size == 4)
    {
        return -((*(int32_t *)first) < (*(int32_t *)second));
    }
    if (size == 2)
    {
        return -((*(int16_t *)first) < (*(int16_t *)second));
    }
    if (size == 1)
    {
        return -((*(int8_t *)first) < (*(int8_t *)second));
    }
    int a_neg = (int8_t)first[size - 1] < 0;
    int b_neg = (int8_t)second[size - 1] < 0;

    if (!a_neg && !b_neg)
    {
        return large_unsigned_integer_less(first, second, size);
    }
    if (a_neg != b_neg)
    {
        return -(a_neg > b_neg);
    }
    return large_unsigned_integer_less(second, first, size);
}

int32_t get_command_arg(struct spu *s, int ip, int arg_id)
{
    /* 1 + 4 * arg_id is shift from command begining */
    /* 4 == sizeof(int32_t) - size of one argument for now */
    return *(int32_t *)(s->mem + ip + 1 + 4 * arg_id);
}

int32_t int_from(struct spu *s, int addr)
{
    return *(int32_t *)(s->mem + addr);
}

/* logical pointers conversions */
int32_t ptr_from_ptr(struct spu *s, int addr)
{
    return int_from(s, addr);
}

int32_t rel_to_abs(struct spu *s, int ip, int addr)
{
    (void)s;
    return addr + ip;
}

BYTE *ptr_to_memory(struct spu *s, int addr)
{
    return s->mem + addr;
}

// TODO: a lot less love for macros, please

#define READ_DST_SRC_COUNT \
    int32_t dst = rel_to_abs(s, ip, get_command_arg(s, ip, 0)); \
    int32_t src = rel_to_abs(s, ip, get_command_arg(s, ip, 1)); \
    int32_t cnt = rel_to_abs(s, ip, get_command_arg(s, ip, 2)); \
    \
    if ((opcode & ARG_PTR_OPCODE_MASK) == ARG_PTR_ON_PTR) \
    { \
        VERBOSE_INFO("dest = *%08x=%08x src = *%08x=%08x cnt = *%08x=%08x\n", \
                      dst, ptr_from_ptr(s, dst), \
                      src, ptr_from_ptr(s, src), \
                      cnt, ptr_from_ptr(s, cnt)); \
        dst = ptr_from_ptr(s, dst); \
        src = ptr_from_ptr(s, src); \
        cnt = ptr_from_ptr(s, cnt); \
    }

#define READ_DST_A_B_COUNT \
    int32_t dst = rel_to_abs(s, ip, get_command_arg(s, ip, 0)); \
    int32_t a   = rel_to_abs(s, ip, get_command_arg(s, ip, 1)); \
    int32_t b   = rel_to_abs(s, ip, get_command_arg(s, ip, 2)); \
    int32_t cnt = rel_to_abs(s, ip, get_command_arg(s, ip, 3)); \
    \
    if ((opcode & ARG_PTR_OPCODE_MASK) == ARG_PTR_ON_PTR) \
    { \
        VERBOSE_INFO("dest = *%08x=%08x a = *%08x=%08x b = *%08x=%08x cnt = *%08x=%08x\n", \
                      dst, ptr_from_ptr(s, dst), \
                      a,   ptr_from_ptr(s, a), \
                      b,   ptr_from_ptr(s, b), \
                      cnt, ptr_from_ptr(s, cnt)); \
        dst = ptr_from_ptr(s, dst); \
        a   = ptr_from_ptr(s, a); \
        b   = ptr_from_ptr(s, b); \
        cnt = ptr_from_ptr(s, cnt); \
    }


void run(struct spu *s)
{
    while (1)
    {
        #ifdef DUMP_MEM
            dump(s->mem, 0x3FF0, 0x4200);
        #endif
        /* load instruction */
        uint32_t ip = int_from(s, 0);
        VERBOSE_INFO("IP = %08x\n", ip);

        if (ip >= s->mem_size)
        {
            PRINT_ERROR("ip is outside of memory bounds.");
            break;
        }
        
        int64_t cmd_size = decode_instruction_length(ptr_to_memory(s, ip));
        
        if (ip + cmd_size > (int64_t)s->mem_size)
        {
            PRINT_ERROR("ip + cmd_size is outside of memory bounds.");
            break;
        }

        *(int32_t *)ptr_to_memory(s, 0) = ip + cmd_size;
        
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


result_t allocate_memory(struct spu *s, size_t memsize)
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

result_t load_image(struct spu *s, char *filename, size_t load_address)
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
    
    return 0;
}


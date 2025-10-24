#include "stdio.h"
#include "string.h"
#include "stdlib.h"
#include "assert.h"


#include "inttypes.h"
typedef unsigned char BYTE;


void out_memory(unsigned char *mem, int count)
{
    printf("OUT BYTES: %d\n", count);
    for (int i = 0; i < count; ++i)
    {
        printf("OUT MEM: %02x\n", mem[i]);
    }
}



#define MAP_BASE_SIZE_OPTIMIZATION(MACRO) \
    switch (size) \
    { \
        case sizeof(int8_t):  MACRO((*(int8_t *)first), (*(int8_t *)first), (*(int8_t *)second)); return; \
        case sizeof(int16_t): MACRO((*(int16_t *)first), (*(int16_t *)first), (*(int16_t *)second)); return; \
        case sizeof(int32_t): MACRO((*(int32_t *)first), (*(int32_t *)first), (*(int32_t *)second)); return; \
        case sizeof(int64_t): MACRO((*(int64_t *)first), (*(int64_t *)first), (*(int64_t *)second)); return; \
        default: break; \
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
    
    printf("-----: not implemented: integer division");
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


int32_t large_integer_less(unsigned int *res, BYTE *first, BYTE *second, size_t size)
{
    // can't use optimizate_size... becouse this construction needs non null return
    if (size == 8)
    {
        *res = -((*(int64_t *)first) < (*(int64_t *)second));
    }
    if (size == 4)
    {
        *res = -((*(int32_t *)first) < (*(int32_t *)second));
    }
    if (size == 2)
    {
        *res = -((*(int16_t *)first) < (*(int16_t *)second));
    }
    if (size == 1)
    {
        *res = -((*(int8_t *)first) < (*(int8_t *)second));
    }
    int a_neg = (int8_t)first[size - 1] < 0;
    int b_neg = (int8_t)second[size - 1] < 0;

    if (!a_neg && !b_neg)
    {
        *res = large_unsigned_integer_less(first, second, size);
    }
    if (a_neg != b_neg)
    {
        *res = -(a_neg > b_neg);
    }
    *res = large_unsigned_integer_less(second, first, size);
}


void large_integer_inv(BYTE *first, BYTE *second, int size)
{    
    for (ssize_t i = 0; i < size; ++i)
    {
        first[i] = ~second[i];
    }
}


void large_integer_neg(BYTE *first, BYTE *second, int size)
{    
    for (ssize_t i = 0; i < size; ++i)
    {
        first[i] = ~second[i];
    }
    large_integer_inc(first, size);
}


void large_integer_eq(BYTE *first, BYTE *second, int size)
{
    for (ssize_t i = 0; i < size; ++i)
    {
        first[i] = ~(first[i] ^ second[i]);
    }
}


void large_integer_or(BYTE *first, BYTE *second, int size)
{
    for (ssize_t i = 0; i < size; ++i)
    {
        first[i] = (first[i] | second[i]);
    }
}


void large_integer_and(BYTE *first, BYTE *second, int size)
{
    for (ssize_t i = 0; i < size; ++i)
    {
        first[i] = (first[i] & second[i]);
    }
}


void large_integer_xor(BYTE *first, BYTE *second, int size)
{
    for (ssize_t i = 0; i < size; ++i)
    {
        first[i] = (first[i] | second[i]);
    }
}

void large_integer_all(int *res, BYTE *mem, int size)
{   
    BYTE total = 0xFF;
    for (ssize_t i = 0; i < size; ++i)
    {
        total &= mem[i];
    }
    *res = (total == 0xFF ? 0xFFFFFFFF : 0);
}

void large_integer_any(int *res, BYTE *mem, int size)
{   
    BYTE total = 0x00;
    for (ssize_t i = 0; i < size; ++i)
    {
        total |= mem[i];
    }
    *res = (total == 0 ? 0 : 0xFFFFFFFF);
}

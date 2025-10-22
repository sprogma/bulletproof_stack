#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int set_region_value(struct tree *t, int start, int end, int is_zero, void *value)
{
    
    if (start == -1)
    {
        if (end != -1)
        {
            printf("ERROR: set_region_value with start == -1 and end != -1\n");
            abort();
        }
        if (is_zero || value != NULL)
        {
            printf("WARNING: set_region_value with start == -1 and is_zero != 0 or value != NULL [is_zero: %d, value: %p]\n", is_zero, value);
            is_zero = 0;
            value = NULL;
        }
        for (int i = 0; i < t->regions_len; ++i)
        {
            if (t->regions[i].is_restrict == 0)
            {
                t->regions[i].is_zero = 0;
                t->regions[i].value = NULL;
            }
        }
        return 0;
    }
    
    int from, to;
    get_mem_slice(t, start, end, &from, &to);
    /* set data */
    if (is_zero)
    {
        if (end == -1)
        {
            printf("ERROR: set_region_value with end == -1 and is_zero != 0\n");
            abort();
        }
        for (int i = from; i <= to; ++i)
        {
            t->regions[i].is_zero = 1;
        }
    }
    else if (value == NULL)
    {
        for (int i = from; i <= to; ++i)
        {
            t->regions[i].is_zero = 0;
            t->regions[i].value = NULL;
        }
    }
    else
    {
        if (end == -1)
        {
            printf("ERROR: set_region_value with end == -1 and value != NULL\n");
            abort();
        }
        BYTE *ptr = malloc(end - start);
        memcpy(ptr, value, end - start);
        for (int i = from; i <= to; ++i)
        {
            printf("SET MEM reg[%d] PTR = %p VALUE = %d\n", i, ptr, *(int *)ptr);
            t->regions[i].is_zero = 0;
            t->regions[i].value = ptr;
            ptr += t->regions[i].end - t->regions[i].start;
        } 
    }

    return 0;
}



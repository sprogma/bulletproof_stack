#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int add_mem_value(struct mem_value **mem, BYTE *pointer, int size)
{
    return 0;
    struct mem_value *x = *mem;
    while (x != NULL)
    {
        if (x->size == size && memcpy(x->mem, pointer, size) == 0)
        {
            return 0;
        }
        x = x->next;
    }
    struct mem_value *new_mem_node = malloc(sizeof(*new_mem_node));
    new_mem_node->mem = pointer;
    new_mem_node->size = size;
    new_mem_node->next = *mem;
    *mem = new_mem_node;
    return 0;
}

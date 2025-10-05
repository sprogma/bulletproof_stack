#include "malloc.h"

#include "compiler.h"


result_t reserve_buffer(struct code_buffer_t *b, size_t size)
{
    if (b->alloc < size)
    {
        while (b->alloc < size)
        {
            b->alloc = 2 * b->alloc + !(b->alloc);
        }

        char *new_ptr = realloc(b->buffer, b->alloc);
        if (new_ptr == NULL)
        {
            return 1;
        }
        b->buffer = new_ptr;
    }

    return 0;
}

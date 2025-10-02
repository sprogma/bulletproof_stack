#include "assert.h"
#include "malloc.h"
#include "../utils/assembler.h"


int reserve_output_buffer(struct output_buffer *b, ssize_t size)
{
    assert(b->alloc >= 0 && b->len >= 0);
    
    while (b->alloc < size)
    {
        b->alloc = 2 * b->alloc + !(b->alloc);
    }
    
    BYTE *new_ptr = realloc(b->buffer, sizeof(*b->buffer) * b->alloc);
    if (new_ptr == NULL)
    {
        return 1;
    }
    
    b->buffer = new_ptr;
    return 0;
}

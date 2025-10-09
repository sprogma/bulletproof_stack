#include "assert.h"
#include "malloc.h"
#include "stdio.h"
#include "stdarg.h"
#include "string.h"


#include "../utils/assembler.h"


result_t reserve_output_buffer(struct output_buffer *b, int64_t size)
{
    assert(b->alloc >= 0 && b->len >= 0);
    
    if (b->alloc < size)
    {
        while (b->alloc < size)
        {
            b->alloc = 2 * b->alloc + !(b->alloc);
        }


        char *new_ptr = realloc(b->buffer, sizeof(*b->buffer) * b->alloc);
        if (new_ptr == NULL)
        {
            return 1;
        }
        
        b->text = new_ptr;
    }
    
    return 0;
}


result_t print_buffer(struct output_buffer *b, char *format_string, ...)
{
    reserve_output_buffer(b, b->len + 512);
    
    va_list args;
    
    va_start(args, format_string);
    b->len += vsprintf(b->text + b->len, format_string, args);
    va_end(args);

    return 0;
}


result_t copy_to_end(struct output_buffer *b, void *data, size_t size)
{
    reserve_output_buffer(b, b->len + size);
    memcpy(b->buffer + b->len, data, size);
    b->len += size;
    return 0;
}

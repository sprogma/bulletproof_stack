#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "malloc.h"
#include "assert.h"

#include "assembler.h"


int reserve_output_buffer(struct output_buffer *b, ssize_t size)
{
    assert(b->alloc >= 0 && b->len >= 0);
    
    while (b->alloc < size)
    {
        b->alloc = 2 * b->alloc + !(b->alloc);
    }
    
    char *new_ptr = realloc(b->buffer, sizeof(*b->buffer) * b->alloc);
    if (new_ptr == NULL)
    {
        return 1;
    }
    
    b->buffer = new_ptr;
    return 0;
}


int main()
{
    char *filename = "a.asm";
    char *outputname = "a.bc";

    char **lines;
    ssize_t lines_len;

    read_file(filename, &lines, &lines_len);

    ssize_t output_size = 128;
    char *output_buffer = calloc(1, sizeof(*output_buffer) * output_size);

    struct output_buffer b = {NULL, 0, 0};

    /* simple assembler: encode each instruction */
    for (ssize_t i = 0; i < lines_len; ++i)
    {
        ssize_t written_bytes = 0;
        reserve_output_buffer(&b, b.len + MAX_INSTRUCTION_LENGTH);
        if (encode_instruction(lines[i], b.buffer + b.len, &written_bytes) != 0)
        {
            fprintf(stderr, "Error at encoding line %s:%zd\n>%s\n", filename, i, lines[i]);
        }
        assert(written_bytes <= MAX_INSTRUCTION_LENGTH);
        b.len += written_bytes;
    }

    /* free text */
    free(lines[0]);

    /* write result to file */
    FILE *f = fopen(outputname, "wb");
    fwrite(b.buffer, 1, b.len, f);
    fclose(f);
    
    return 0;
}

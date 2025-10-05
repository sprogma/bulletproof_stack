#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "malloc.h"
#include "assert.h"

#include "../utils/assembler.h"


int main(int argc, char **argv)
{
    if (argc != 3)
    {
        printf("Disassembler must take 2 files: source and destination.\n");
        return 1;
    }
    
    char *filename = argv[1];
    char *outputname = argv[2];

    BYTE *buffer;
    ssize_t buffer_size;

    read_binary_file(filename, &buffer, &buffer_size);

    ssize_t output_size = 128;
    char *output_buffer = calloc(1, sizeof(*output_buffer) * output_size);

    struct string_output_buffer b = {NULL, 0, 0};

    decode_program(buffer, buffer_size, &b);

    /* free text */
    free(buffer);    

    /* write result to file */
    FILE *f = fopen(outputname, "wb");
    fwrite(b.buffer, 1, b.len, f);
    fclose(f);
    
    return 0;
}

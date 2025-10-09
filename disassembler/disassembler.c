#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "malloc.h"
#include "assert.h"

#include "../utils/assembler.h"


int main(int argc, char **argv)
{
    if (argc != 3)
    {
        PRINT_ERROR("Disassembler must take 2 files: source and destination.");
        return 1;
    }

    
    char *in_file = argv[1];
    char *out_file = argv[2];


    BYTE *buffer;
    ssize_t buffer_size;
    HANDLE_ERROR(read_binary_file(in_file, &buffer, &buffer_size));


    struct output_buffer b = {{NULL}, 0, 0};
    HANDLE_ERROR(decode_program(buffer, buffer_size, &b));


    /* free text */
    free(buffer);    
    

    /* write result to file */
    write_file(out_file, b.text, b.len);
    
    return 0;
}

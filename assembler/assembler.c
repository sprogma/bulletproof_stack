#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "malloc.h"
#include "assert.h"

#include "./assembler_internal.h"
#include "../logger/logger.h"


int main(int argc, char **argv)
{
    if (argc != 3)
    {
        PRINT_ERROR("Assembler must take 2 files: source and destination.");
        return 1;
    }
    
    char *in_file = argv[1];
    char *out_file = argv[2];


    FILE *f = fopen("result.dat", "w");


    char **lines;
    int64_t lines_len;
    HANDLE_ERROR(read_file(in_file, &lines, &lines_len));

    
    struct output_buffer b = {{NULL}, 0, 0};
    HANDLE_ERROR(build_program(lines, lines_len, &b, f));
    
    /* free input text */
    free(lines[0]);

    /* write result to file */
    write_file(out_file, (char *)b.buffer, b.len);
    
    return 0;
}

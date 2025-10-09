#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "assert.h"
#include "malloc.h"
#include "fcntl.h"
#include "sys/stat.h"


#include "../utils/assembler.h"

    
result_t read_binary_file(const char *filename, BYTE **buffer, ssize_t *buffer_len)
{
    struct stat file_stat;
    int f = open(filename, O_RDONLY);
    if (fstat(f, &file_stat) != 0)
    {
        PRINT_ERROR("cannot open file %s\n", filename);
        return 1;
    }
    
    *buffer = calloc(1, file_stat.st_size);
    *buffer_len = read(f, *buffer, file_stat.st_size);
    
    return 0;
}

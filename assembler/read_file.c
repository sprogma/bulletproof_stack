#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "assert.h"
#include "malloc.h"
#include "fcntl.h"
#include "sys/stat.h"


#include "../utils/assembler.h"

    
int read_file(const char *filename, char ***lines, ssize_t *lines_len)
{
    struct stat file_stat;
    int f = open(filename, O_RDONLY);
    if (fstat(f, &file_stat) != 0)
    {
        fprintf(stderr, "cannot open file %s\n", filename);
        return 1;
    }
    
    char *buffer = calloc(1, file_stat.st_size + 1);
    ssize_t len = read(f, buffer, file_stat.st_size);
    buffer[len] = 0;

    /* count newlines */
    int lines_count = 1;
    char *pos = buffer;
    while (pos && (pos = strchr(pos + 1, '\n'))) { lines_count++; }

    *lines = calloc(1, sizeof(**lines) * lines_count);
    *lines_len = lines_count;

    /* fill lines */
    (*lines)[0] = buffer;
    for (ssize_t i = 1; i < lines_count; ++i)
    {
        (*lines)[i] = strchr((*lines)[i - 1], '\n') + 1;
    }
    
    /* split lines */
    for (ssize_t i = 1; i < lines_count; ++i)
    {
        (*lines)[i][-1] = 0;
        if ((*lines)[i] - 2 >= buffer && (*lines)[i][-2] == '\r')
        {
            (*lines)[i][-2] = 0;
        }
    }

    close(f);
    return 0;
}

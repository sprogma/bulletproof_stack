#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "assert.h"
#include "malloc.h"
#include "fcntl.h"
#include "sys/stat.h"


#include "../utils/assembler.h"
#include "../logger/logger.h"



static result_t get_file_size(int handle, int64_t *size)
{
    struct stat file_stat;
    if (fstat(handle, &file_stat) != 0)
    {
        PRINT_ERROR("fstat function failed");
        return 1;
    }

    *size = file_stat.st_size;

    return 0;
}


static int64_t count_char(char *string, char c)
{
    int64_t count = 1;
    
    while (*string && (string = strchr(string + 1, c))) { count++; }

    return count;
}


result_t read_file(const char *filename, char ***p_lines, int64_t *p_lines_len)
{
    int handle = open(filename, O_RDONLY);
    if (handle == -1)
    {
        PRINT_ERROR("Cannot open file");
        return 1;
    }

    int64_t size = 0;
    get_file_size(handle, &size);

    
    char *buffer = calloc(1, size + 1);
    int64_t len = read(handle, buffer, size);
    buffer[len] = 0;


    /* count newlines */
    int64_t lines_count = count_char(buffer, '\n');


    /* fill lines */
    char **lines = calloc(1, sizeof(*lines) * lines_count);

    if (lines == NULL)
    {
        PRINT_ERROR("out of memory");
        return 1;
    }
    
    lines[0] = buffer;
    for (int64_t i = 1; i < lines_count; ++i)
    {
        lines[i] = strchr(lines[i - 1], '\n') + 1;
    }

    /* split lines */
    for (int64_t i = 1; i < lines_count; ++i)
    {
        lines[i][-1] = '\0';
        
    #ifdef _WIN32
        if (lines[i] - 2 >= buffer && lines[i][-2] == '\r')
        {
            lines[i][-2] = '\0';
        }
    #endif
    }

    *p_lines = lines;
    *p_lines_len = lines_count;

    close(handle);
    
    return 0;
}


result_t write_file(const char *filename, char *buffer, int64_t size)
{
    FILE *file = fopen(filename, "wb");
    if (file == NULL)
    {
        PRINT_ERROR("Cannot open file to write into");
        return 1;
    }
    fwrite(buffer, 1, size, file);
    fclose(file);
    return 0;
}
 

result_t read_binary_file(const char *filename, BYTE **buffer, ssize_t *buffer_len)
{    
    /* get file size */
    int fh = open(filename, O_RDONLY);
    if (fh == -1)
    {
        PRINT_ERROR("Cannot open file");
        return 1;
    }

    int64_t size = 0;
    get_file_size(fh, &size);

    close(fh);

    /* read file, open it one more time */
    
    FILE *f = fopen(filename, "rb");
    if (f == NULL)
    {
        return 1;
    }
    
    *buffer = calloc(1, size);
    *buffer_len = fread(*buffer, 1, size, f);

    fclose(f);
    return 0;
}


#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "assert.h"
#include "malloc.h"
#include "fcntl.h"
#include "sys/stat.h"
#include "string.h"
#include "ctype.h"

#include "assembler.h"


int encode_instruction(char *line, char *destination, ssize_t *bytes_written)
{
    char *begin = line;
    while (*begin != '\0' && isspace(*begin))
    {
        begin++;
    }

    if (*begin == '\0')
    {
        return 0;
    }
    
    printf("compile %s -> %s\n", line, line);
    strcpy(destination, line);
    *bytes_written = strlen(line);
    return 0;
}


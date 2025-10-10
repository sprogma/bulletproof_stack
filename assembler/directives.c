#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "assert.h"
#include "malloc.h"
#include "string.h"
#include "stdlib.h"
#include "ctype.h"


#include "./assembler_internal.h"


#define STARTSWITH(s, str) (strncmp((s), str, sizeof(str) - 1) == 0 && !iskey((s)[sizeof(str) - 1]))


static result_t encode_directive_data(struct compilation_table *table, 
                                      char *line, 
                                      char *line_end, 
                                      int64_t position, 
                                      struct output_buffer *dst, 
                                      int64_t *result_length)
{
    (void)table;
    (void)position;
    
    str_trim(&line, &line_end);
    
    int32_t element_size = 0;

    if      (STARTSWITH(line, ".db")) { element_size = 1; }
    else if (STARTSWITH(line, ".dw")) { element_size = 2; }
    else if (STARTSWITH(line, ".dd")) { element_size = 4; }
    else
    {
        PRINT_ERROR("not .db .dw or .dd given in .db .dw or .dd directive [strange error]");
        return 1;
    }

    *result_length = 0;

    char *num_start = line + strlen(".db");
    while (num_start < line_end)
    {
        char *end = OR(strchr(num_start, ','), line_end);

        str_trim(&num_start, &end);

        int32_t value = 0;
        HANDLE_ERROR(parse_integer(num_start, end, &value));

        *result_length += element_size;
        
        if (dst != NULL)
        {
            copy_to_end(dst, &value, element_size);
        }

        num_start = end + 1;
    }
    if (*result_length == 0)
    {
        PRINT_ERROR("No data given in .db .dw or .dd directive");
        return 1;
    }
    return 0;
}


static result_t encode_directive_align(struct compilation_table *table, 
                                       char *line, 
                                       char *line_end, 
                                       int64_t position, 
                                       struct output_buffer *dst, 
                                       int64_t *result_length)
{
    (void)table;
    
    str_trim(&line, &line_end);
    
    /* read integer */
    char *num_start = line + strlen(".align");
    if (num_start >= line_end)
    {
        PRINT_ERROR("Cannot read mandatory value of .align directive from <%*.*s>\n", (int)(line_end - num_start), (int)(line_end - num_start), num_start);
        return 1;
    }
    
    int32_t value = 0;
    HANDLE_ERROR(parse_integer(num_start, line_end, &value));
    if (value > 10000)
    {
        PRINT_WARNING("Too big .align number: %d is greated than 10000\n", value);
    }

    int32_t p = position;
    if (p % value != 0)
    {
        p += ((-p) % value + value) % value;
    }

    *result_length = p - position;

    if (dst == NULL)
    {
        return 0;
    }

    memset(dst->buffer + dst->len, 0, *result_length);
    dst->len += *result_length;

    return 0;
}


result_t encode_directive(struct compilation_table *table, 
                          char *line, 
                          int64_t position, 
                          struct output_buffer *dst, 
                          int64_t *result_length)
{
    /* end of line - start of comment or new line */
    char *line_end = OR(strchr(line, ';'), line + strlen(line));

    str_trim(&line, &line_end);

    if (STARTSWITH(line, ".db") ||
        STARTSWITH(line, ".dw") ||
        STARTSWITH(line, ".dd"))
    {
        return encode_directive_data(table, line, line_end, position, dst, result_length);
    }
    else if (STARTSWITH(line, ".align"))
    {
        return encode_directive_align(table, line, line_end, position, dst, result_length);
    }
    else
    {
        fprintf(stderr, "Unknown directive: %s\n", line);
        return 1;
    }
    return 0;
}


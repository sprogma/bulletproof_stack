#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "assert.h"
#include "malloc.h"
#include "string.h"
#include "stdlib.h"
#include "ctype.h"


#include "./assembler_internal.h"



result_t build_pass(struct compilation_table *table, char **lines, int64_t lines_len, struct output_buffer *out, int64_t read_labels)
{
    int32_t position = 0;
    for (int64_t i = 0; i < lines_len; ++i)
    {
        char *s = skip_leading_spaces(lines[i]);
        if (*s == '\0') { continue; }


        if (s[0] == '.')
        {
            /* compilation directives */
            int64_t written = 0;
            encode_directive(table, s, position, out, &written);
            position += written;
            continue;
        }

        /* parse first word in string */
        char *name_end = s;
        /* first letter of name must be not digit, and this if check this */
        if (isstartkey(*name_end))
        {
            while (iskey(*name_end)) { name_end++; }
        }

        char *after_name = skip_leading_spaces(name_end);
        if (*after_name == ':')
        {
            if (s != name_end)
            {
                if (read_labels)
                {
                    add_label(table, s, name_end - s, position);
                }
            }
            else
            {
                PRINT_ERROR("Wrong syntax: label with empty name at> %s", lines[i]);
            }
            continue;
        }

        /* else: */
        /* compile basic command */
        int64_t written = 0;
        encode_command(table, s, position, out, &written);
        position += written;
    }

    PRINT_INFO("Total assebmly pass size: %d bytes", position);
}


result_t build_program(char **lines, int64_t lines_len, struct output_buffer *out)
{
    struct compilation_table table;
    table.labels = NULL;
    table.labels_len = 0;
    table.labels_alloc = 0;


    build_pass(&table, lines, lines_len, NULL, 1);
    build_pass(&table, lines, lines_len, out, 0);

    PRINT_INFO("Compiled into %zd bytes", out->len);

    return 0;
}


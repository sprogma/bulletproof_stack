#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "assert.h"
#include "malloc.h"
#include "string.h"
#include "stdlib.h"
#include "ctype.h"


#include "./assembler_internal.h"



result_t encode_command(struct compilation_table *table, char *line, int64_t position, struct output_buffer *dst, int64_t *result_length)
{

    /* end of line - start of comment or new line */
    char *line_end = OR(strchr(line, ';'), line + strlen(line));

    str_trim(&line, &line_end);
    
    if (line >= line_end)
    {
        return 0;
    }
    
    int pointer_mode = ARG_PTR;
    if (*line == '$')
    {
        pointer_mode = ARG_PTR_ON_PTR;
        line++;
    }

    /* find native_command */
    size_t name_len = 0;
    const struct command *cmd = NULL;
    for (size_t i = 0; i < ARRAYLEN(native_commands); ++i)
    {
        name_len = strlen(native_commands[i].name);
        if (strncmp(line, native_commands[i].name, name_len) == 0 && !iskey(line[name_len]))
        {
            cmd = native_commands + i;
            break;
        }
    }

    if (cmd == NULL)
    {
        PRINT_ERROR("Unknown command: %s\n", line);
        return 1;
    }

    /* write opcode */
    *result_length = 1 + 4 * cmd->nargs;
    if (dst == NULL)
    {
        return 0;
    }

    BYTE header = cmd->code | pointer_mode;
    int32_t offsets[MAX_COMMAND_ARGUMENTS] = {};
    
    if (cmd->const_first_argument)
    {
        /* parse first argument as integer */
        char *cnt_e = strchr(line + name_len, ',');
        if (cnt_e == NULL && cmd->nargs != 1)
        {
            PRINT_ERROR("command %s have only one parameter.", cmd->name);
            return 1;
        }

        cnt_e = OR(cnt_e, line_end);
        
        HANDLE_ERROR(parse_integer(line + name_len, cnt_e, offsets + 0));
        if (cmd->nargs == 1)
        { 
            HANDLE_ERROR(calculate_offsets(table, position, cnt_e + 1, line_end, cmd->nargs - 1, offsets + 1));
        }
    }
    else
    {
        HANDLE_ERROR(calculate_offsets(table, position, line + name_len, line_end, cmd->nargs, offsets));
    }
    
    copy_to_end(dst, &header, sizeof(header));
    copy_to_end(dst, offsets, sizeof(*offsets) * cmd->nargs);
    
    PRINT_INFO("ENCODED COMMAND: %s into %zd bytes", cmd->name, *result_length);
    return 0;
}


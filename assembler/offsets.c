#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "assert.h"
#include "malloc.h"
#include "string.h"
#include "stdlib.h"
#include "ctype.h"


#include "./assembler_internal.h"


static result_t calculate_offset(struct compilation_table *table, int64_t position, char *arg, char *arg_end, int32_t *offset)
{
    /* skip leading and trailing spaces */
    str_trim(&arg, &arg_end);

    if (arg == arg_end)
    {
        PRINT_ERROR("empty command argument");
        return 1;
    }

    if (is_all_digits(arg, arg_end) || 
       (arg[0] == '-' && is_all_digits(arg + 1, arg_end)))
    {
        PRINT_WARNING("Absolute address aren'table supported, this pointer will be relative to current instruction [in arg <%*.*s>]",
                                                                              (int)(arg_end - arg), (int)(arg_end - arg), arg);
        // parse integer offset, and store it to result.
        HANDLE_ERROR(parse_integer(arg, arg_end, offset));
        return 0;
    }

    char *name_end = arg;
    /* first key must be not digit, so this if check this */
    if (isstartkey(*name_end))
    {
        while (name_end < arg_end && iskey(*name_end)) { name_end++; }
    }


    if (name_end == arg)
    {
        PRINT_ERROR("Argument isn'table name or absolute address [in arg <%*.*s>]", (int)(arg_end - arg), (int)(arg_end - arg), arg);
        return 1;
    }

    /* find name in global offsets table */
    struct label *label = NULL;
    for (int64_t i = 0; i < table->labels_len; ++i)
    {
        if (table->labels[i].name_len == name_end - arg &&
            strncmp(table->labels[i].name, arg, table->labels[i].name_len) == 0)
        {
            label = table->labels + i;
        }
    }

    if (label == NULL)
    {
        PRINT_ERROR("Not found label with name: <%*.*s> [in arg <%*.*s>]", (int)(name_end - arg), (int)(name_end - arg), arg,
                                                                           (int)(arg_end - arg), (int)(arg_end - arg), arg);
        return 1;
    }

    /* is there number shift? */
    int32_t add_offset = 0;
    {
        char *n = name_end;
        str_trim(&n, &name_end);
        if (*n == '+' || *n == '-')
        {
            if (parse_integer(n, arg_end, &add_offset) != 0)
            {
                PRINT_ERROR("Not integer value after '+' or '-' [in arg <%*.*s>]",
                                 (int)(arg_end - arg), (int)(arg_end - arg), arg);
                return 1;
            }
        }
    }

    PRINT_INFO("FOUND LABEL: offset=%x; add_offset=%x", label->position, add_offset);
    *offset = label->position + add_offset - position;
    return 0;
}


result_t calculate_offsets(struct compilation_table *table, int64_t position, char *args, char *args_end, int64_t nargs, int32_t *offsets_length)
{
    /* skip leading and trailing spaces */
    str_trim(&args, &args_end);
        
    char *arg = args;
    for (int64_t i = 0; i < nargs; ++i)
    {
        if (arg >= args_end)
        {
            fprintf(stderr, "Not enough parameters given: read %zd of %zd at %s\n", i, nargs, args);
            return 1;
        }
        char *arg_end = strchr(arg, ',');
        if (arg_end == NULL || arg_end > args_end)
        {
            arg_end = args_end;
        }
        /* calculate offset of this argument */
        {
            HANDLE_ERROR(calculate_offset(table, position, arg, arg_end, offsets_length + i));
        }
        arg = arg_end + 1;
    }

    if (arg < args_end)
    {
        printf("%p %p\n", arg, args_end);
        fprintf(stderr, "Too many arguments, need only %zd, at %s\n", nargs, args);
        return 1;
    }
    return 0;
}

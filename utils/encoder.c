#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "assert.h"
#include "malloc.h"
#include "string.h"
#include "stdlib.h"
#include "ctype.h"

#include "../utils/assembler.h"


int iskey(int c)
{
    return isalpha(c) || c == '_';
}


ssize_t decode_instruction_length(BYTE *line)
{
    BYTE header = *line;
    switch (header & ARG_NUM_OPCODE_MASK)
    {
        case ARG_NUM_0:
            return 1;
        case ARG_NUM_2:
            return 1 + 4 * 2;
        case ARG_NUM_3:
            return 1 + 4 * 3;
        case ARG_NUM_4:
            return 1 + 4 * 4;
        default:
            return 0;
    }
}

static int add_label(struct compilation_table *t, char *name, ssize_t len, int32_t offset);
static int encode_command(struct compilation_table *t, char *line, ssize_t position, BYTE *dst, ssize_t *result_length);

static char *skip_leading_spaces(char *s)
{
    while (*s != '\0' && isspace(*s))
    {
        s++;
    }
    return s;
}

static int add_label(struct compilation_table *t, char *name, ssize_t len, int32_t offset)
{
    if (t->labels_len == t->labels_alloc)
    {
        t->labels_alloc = 2 * t->labels_alloc + !(t->labels_alloc);
        void *new_ptr = realloc(t->labels, sizeof(*t->labels) * t->labels_alloc);
        if (new_ptr == NULL)
        {
            return 1;
        }
        t->labels = new_ptr;
    }
    ssize_t id = t->labels_len++;
    t->labels[id] = (struct label){name, len, offset};
    return 0;
}


static int parse_integer(char *s, char *e, int32_t *result)
{
    while (s < e && isspace(s[0])) { s++; }
    char sign = '+';
    if (*s == '+' || *s == '-')
    {
        sign = *s;
        s++;
    }
    while (s < e && isspace(s[0])) { s++; }
    while (s < e && isspace(e[-1])) { e--; }

    char *text = malloc(e - s + 1);
    memcpy(text, s, e - s);
    text[e - s] = 0;

    char *end_ptr = text + (e - s);
    int32_t res = strtoll(text, &end_ptr, 0);

    if (*end_ptr != 0)
    {
        /* full text */
        fprintf(stderr, "Error: strtol cannot parse nuber to end: number <%*.*s>\n", (int)(e - s), (int)(e - s), s);
        *result = 0;
        free(text);
        return 1;
    }

    if (sign == '-')
    {
        res = -res;
    }
    *result = res;
    free(text);
    return 0;
}


static int calculate_offset(struct compilation_table *t, ssize_t position, char *arg, char *arg_end, int32_t *offset)
{
    /* skip leading and trailing spaces */
    while (arg < arg_end && isspace(arg[0])) { arg++; }
    while (arg < arg_end && isspace(arg_end[-1])) { arg_end--; }
    if (arg == arg_end)
    {
        fprintf(stderr, "error: empty command argument\n");
        return 1;
    }
    /* if there is no name, show error */
    {
        for (char *s = arg; s < arg_end; ++s)
        {
            if (!isdigit(*s))
            {
                goto not_a_number;
            }
        }
        // fprintf(stderr, "Error: absolute address aren't supported for now [in arg <%*.*s>]\n", (int)(arg_end - arg), (int)(arg_end - arg), arg);
        parse_integer(arg, arg_end, offset);
        *offset += position;
        return 0;
    not_a_number:;
    }
    /* if there is name, parse it */
    {
        char *name_end = arg;
        while (name_end < arg_end && iskey(*name_end)) { name_end++; }
        if (name_end == arg)
        {
            fprintf(stderr, "Error: argument isn't name nor absolute address [in arg <%*.*s>]\n", (int)(arg_end - arg), (int)(arg_end - arg), arg);
            return 1;
        }
        /* find name in global offsets table */
        for (ssize_t i = 0; i < t->labels_len; ++i)
        {
            if (strncmp(t->labels[i].name, arg, t->labels[i].name_len) == 0 &&
                t->labels[i].name_len == name_end - arg)
            {
                /* is there number shift? */
                int32_t add_offset = 0;
                {
                    char *n = name_end;
                    while (n < arg_end && isspace(*n)) { n++; }
                    if (*n == '+' || *n == '-')
                    {
                        /* parse integer offset */
                        if (parse_integer(n, arg_end, &add_offset) != 0)
                        {
                            fprintf(stderr, "Error: not integer value after '+' or '-' [in arg <%*.*s>]\n",
                                            (int)(arg_end - arg), (int)(arg_end - arg), arg);

                        }
                    }
                }
                // printf("FOUND LABEL: offset=%x; add_offset=%x\n", t->labels[i].position, add_offset);
                *offset = t->labels[i].position + add_offset;
                return 0;
            }
        }
        fprintf(stderr, "Error: not found label with name: <%*.*s> [in arg <%*.*s>]\n", (int)(name_end - arg), (int)(name_end - arg), arg,
                                                                                        (int)(arg_end - arg), (int)(arg_end - arg), arg);
        return 1;
    }
    return 0;
}


static int calculate_offsets(struct compilation_table *t, ssize_t position, char *args, char *args_end, ssize_t nargs, int32_t *offsets_length)
{
    char *arg = args;
    for (ssize_t i = 0; i < nargs; ++i)
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
            calculate_offset(t, position, arg, arg_end, offsets_length + i);
            offsets_length[i] -= position;
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


static int encode_command(struct compilation_table *t, char *line, ssize_t position, BYTE *dst, ssize_t *result_length)
{
    line = skip_leading_spaces(line);

    int pointer_mode = 0;
    if (*line == '$')
    {
        pointer_mode = 1;
        line++;
    }

    /* end of line - start of comment or new line */
    char *line_end = strchr(line, ';');
    if (line_end == NULL)
    {
        line_end = line + strlen(line);
    }
    while (line < line_end && isspace(line_end[-1])) { line_end--; }

    if (line >= line_end)
    {
        return 0;
    }

    /* encode native_command */
    for (ssize_t i = 0; i < (ssize_t)sizeof(native_commands) / (ssize_t)sizeof(*native_commands); ++i)
    {
        size_t name_len = strlen(native_commands[i].name);
        if (strncmp(line, native_commands[i].name, name_len) == 0 && !iskey(line[name_len]))
        {
            /* write opcode */
            *result_length = 1 + 4 * native_commands[i].nargs;
            if (dst == NULL)
            {
                return 0;
            }

            *dst++ = native_commands[i].code | (pointer_mode ? ARG_PTR_ON_PTR : ARG_PTR);

            /* write arguments */
            if (strcmp(native_commands[i].name, "MOV_CONST") == 0)
            {
                /* parse first argument as integer */
                int32_t code = 0;
                char *cnt_e = strchr(line + name_len, ',');
                {
                    if (cnt_e == NULL)
                    {
                        fprintf(stderr, "Error: MOV_CONST have only one parameter. [excepted 2]\n");
                        return 1;
                    }
                    char *end = NULL;
                    code = strtoll(line + name_len, &end, 0);
                    if (*end != ' ' && *end != ',')
                    {
                        fprintf(stderr, "Error: MOV_CONST must have constant integer as first argument, not <%s>\n", line + name_len);
                        return 1;
                    }
                }
                /* parse other arguments */
                int32_t offsets[MAX_COMMAND_ARGUMENTS] = {};
                calculate_offsets(t, position, cnt_e + 1, line_end, 1, offsets);
                /* encode results */
                memcpy(dst, &code, sizeof(code));
                dst += sizeof(code);
                memcpy(dst, offsets, sizeof(offsets[0]));
                dst += sizeof(offsets[0]);
            }
            else if (strcmp(native_commands[i].name, "INT") == 0)
            {
                /* parse first argument as integer */
                int32_t code = 0;
                char *cnt_e = strchr(line + name_len, ',');
                {
                    if (cnt_e == NULL)
                    {
                        fprintf(stderr, "Error: MOV_CONST have only one parameter. [excepted 2]\n");
                        return 1;
                    }
                    char *end = NULL;
                    code = strtoll(line + name_len, &end, 0);
                    if (*end != ' ' && *end != ',')
                    {
                        fprintf(stderr, "Error: MOV_CONST must have constant integer as first argument, not <%s>\n", line + name_len);
                        return 1;
                    }
                }
                /* parse other arguments */
                int32_t offsets[MAX_COMMAND_ARGUMENTS] = {};
                calculate_offsets(t, position, cnt_e + 1, line_end, 1, offsets);
                /* encode results */
                memcpy(dst, &code, sizeof(code));
                dst += sizeof(code);
                memcpy(dst, offsets, sizeof(offsets[0]));
                dst += sizeof(offsets[0]);
            }
            else
            {
                int32_t offsets[MAX_COMMAND_ARGUMENTS] = {};
                calculate_offsets(t, position, line + name_len, line_end, native_commands[i].nargs, offsets);

                for (ssize_t a = 0; a < native_commands[i].nargs; ++a)
                {
                    memcpy(dst, offsets + a, sizeof(*offsets));
                    dst += sizeof(*offsets);
                }

            }
            fprintf(stderr, "debug: ENCODED COMMAND: %s into %zd bytes\n", native_commands[i].name, *result_length);
            return 0;
        }
    }
    fprintf(stderr, "Unknown command: %s\n", line);
    return 1;
}


#define STARTSWITH(s, str) (strncmp((s), str, sizeof(str) - 1) == 0 && !iskey((s)[sizeof(str) - 1]))


static int encode_directive(struct compilation_table *t, char *line, ssize_t position, BYTE *dst, ssize_t *result_length)
{
    (void)t;

    line = skip_leading_spaces(line);

    /* end of line - start of comment or new line */
    char *line_end = strchr(line, ';');
    if (line_end == NULL)
    {
        line_end = line + strlen(line);
    }
    while (line < line_end && isspace(line_end[-1])) { line_end--; }

    if (STARTSWITH(line, ".db") || 
        STARTSWITH(line, ".dw") || 
        STARTSWITH(line, ".dd"))
    {
        int32_t element_size = 0;

        if (STARTSWITH(line, ".db"))
        {
            element_size = 1;
        }
        else if (STARTSWITH(line, ".dw"))
        {
            element_size = 1;
        }
        else if (STARTSWITH(line, ".dd"))
        {
            element_size = 4;
        }
        else
        {
            fprintf(stderr, "Error: not .db .dw or .dd given in .db .dw or .dd directive [strange error]\n");
        }
        
        *result_length = 0;

        /* read integer */
        int32_t value = 0;
        int32_t writed = 0;
        char *num_start = line + 3;
        while (num_start < line_end)
        {
            char *end = strchr(num_start, ',');
            if (end == NULL)
            {
                end = line_end;
            }

            while (isspace(end[-1])) { end--; }
            while (isspace(num_start[0])) { num_start++; }
            
            if (parse_integer(num_start, end, &value) != 0)
            {
                fprintf(stderr, "Error: cannot read value of .dw directive from <%*.*s>\n", (int)(line_end - num_start), (int)(line_end - num_start), num_start);
                return 1;
            }
            
            *result_length += element_size;
            if (dst != NULL)
            {
                memcpy(dst, &value, element_size);
                dst += element_size;
            }
            writed = 1;

            num_start = end + 1;
        }

        if (!writed)
        {
            fprintf(stderr, "Error: no data given in .db .dw or .dd directive\n");
            return 1;
        }

        return 0;
    }
    else if (STARTSWITH(line, ".align"))
    {
        /* read integer */
        int32_t value = 0;
        char *num_start = line + 6;
        if (num_start >= line_end)
        {
            fprintf(stderr, "Error: cannot read mandatory value of .align directive from <%*.*s>\n", (int)(line_end - num_start), (int)(line_end - num_start), num_start);
        }
        if (parse_integer(num_start, line_end, &value) != 0)
        {
            fprintf(stderr, "Error: cannot read value of .align directive from <%*.*s>\n", (int)(line_end - num_start), (int)(line_end - num_start), num_start);
        }
        if (value > 10000)
        {
            fprintf(stderr, "Error: too big .align number: %d is greated than 10000\n", value);
        }

        int32_t p = position;
        if (p % value != 0)
        {
            p += ((value - p) % value + value % value);
        }

        *result_length = p - position;

        if (dst == NULL)
        {
            return 0;
        }

        for (int i = 0; i < *result_length; ++i)
        {
            *dst++ = 0;
        }

        return 0;
    }
    else
    {
        fprintf(stderr, "Unknown directive: %s\n", line);
        return 1;
    }
    return 0;
}


int build_program(char **lines, ssize_t lines_len, struct output_buffer *out)
{
    struct compilation_table t;
    t.labels = NULL;
    t.labels_len = 0;
    t.labels_alloc = 0;


    /* FIRST PASS: calculation of positions */
    int32_t position = 0;
    for (ssize_t i = 0; i < lines_len; ++i)
    {
        /* skip leading spaces */
        char *s = skip_leading_spaces(lines[i]);
        if (*s == '\0') { continue; }

        char *name_end = s;
        while (iskey(*name_end)) { name_end++; }
        char *end = name_end;
        while (isspace(*end)) { end++; }

        /* switch line type */
        if (s[0] == '.')
        {
            /* compilation directives */
            ssize_t written = 0;
            encode_directive(&t, s, position, NULL, &written);
            position += written;
        }
        else if (*end == ':')
        {
            /* label */
            if (s != name_end)
            {
                add_label(&t, s, name_end - s, position);
            }
            else
            {
                fprintf(stderr, "Wrong syntax: label with empty name at> %s\n", lines[i]);
            }
        }
        else
        {
            /* calculate command size */
            ssize_t written = 0;
            encode_command(&t, s, position, NULL, &written);
            position += written;
        }
    }

    printf("debug: Total assebmly size: %d bytes\n", position);

    /* SECOND PASS: compilation */
    out->len = 0;
    for (ssize_t i = 0; i < lines_len; ++i)
    {
        /* skip leading spaces */
        char *s = skip_leading_spaces(lines[i]);
        if (*s == '\0') { continue; }

        char *name_end = s;
        while (iskey(*name_end)) { name_end++; }
        char *end = name_end;
        while (isspace(*end)) { end++; }

        /* switch line type */
        if (s[0] == '.')
        {
            /* compilation directives */
            ssize_t written = 0;
            encode_directive(&t, s, out->len, out->buffer + out->len, &written);
            out->len += written;
        }
        else if (*end == ':')
        {
            /* label: nothing to do */
        }
        else
        {
            /* compile command */
            ssize_t written = 0;
            reserve_output_buffer(out, out->len + MAX_MACRO_INSTRUCTION_LENGTH);
            encode_command(&t, s, out->len, out->buffer + out->len, &written);
            out->len += written;
        }
    }

    printf("debug: Compiled into %zd bytes\n", out->len);

    return 0;
}


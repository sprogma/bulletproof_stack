#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "assert.h"
#include "malloc.h"
#include "string.h"
#include "stdlib.h"
#include "ctype.h"

#include "../utils/assembler.h"


int isstartkey(int c)
{
    return isalpha(c) || c == '_';
}


int iskey(int c)
{
    return isalpha(c) || isdigit(c) || c == '_';
}


int64_t decode_instruction_length(BYTE *line)
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



static result_t add_label(struct compilation_table *table, char *name, int64_t len, int32_t offset);
static result_t encode_command(struct compilation_table *table, char *line, int64_t position, struct output_buffer *dst, int64_t *result_length);

static int is_all_digits(char *s, char *e)
{
    for (char *p = s; p < e; ++p)
    {
        if (!isdigit(*p))
        {
            return 0;
        }
    }
}

static char *skip_leading_spaces(char *s)
{
    while (*s != '\0' && isspace(*s)) { s++; }
    return s;
}

static void str_trim(char **p_s, char **p_e)
{
    *p_s = skip_leading_spaces(*p_s);

    char *e = *p_e;
    // e[-1] is last character inside string [s, e)
    while (e[-1] != '\0' && isspace(e[-1])) { e--; }
}


static result_t add_label(struct compilation_table *table, char *name, int64_t len, int32_t offset)
{
    for (int64_t i = 0; i < table->labels_len; ++i)
    {
        if (strcmp(table->labels[i].name, name) == 0)
        {
            PRINT_ERROR("Redefenition of label <%s>", name);
            return 1;
        }
    }

    /* allocate additional memory */
    if (table->labels_len >= table->labels_alloc)
    {
        table->labels_alloc = 2 * table->labels_alloc + !(table->labels_alloc);
        void *new_ptr = realloc(table->labels, sizeof(*table->labels) * table->labels_alloc);
        if (new_ptr == NULL) { PRINT_ERROR("out of memory"); return 1; }
        table->labels = new_ptr;
    }

    int64_t id = table->labels_len++;
    table->labels[id] = (struct label){name, len, offset};
    PRINT_INFO("register label <%*.*s> with offset: %08x", (int)len, (int)len, name, offset);

    return 0;
}


static result_t parse_integer(char *s, char *e, int32_t *result)
{
    str_trim(&s, &e);

    char sign = '+';
    if (*s == '+' || *s == '-')
    {
        sign = *s++;
    }

    char *end_ptr = NULL;
    int32_t res = strtoll(s, &end_ptr, 0);

    if (end_ptr < e)
    {
        /* this is full text */
        PRINT_ERROR("Strtol cannot parse nuber to end: number <%*.*s>", (int)(e - s), (int)(e - s), s);
        *result = 0;
        return 1;
    }

    if (sign == '-')
    {
        res = -res;
    }

    *result = res;
    return 0;
}


static result_t calculate_offset(struct compilation_table *table, int64_t position, char *arg, char *arg_end, int32_t *offset)
{
    /* skip leading and trailing spaces */
    str_trim(&arg, &arg_end);

    if (arg == arg_end)
    {
        PRINT_ERROR("empty command argument");
        return 1;
    }

    if (is_all_digits(arg, arg_end))
    {
        PRINT_WARNING("Absolute address aren'table supported, this pointer will be relative to start of program [in arg <%*.*s>]",
                                                                              (int)(arg_end - arg), (int)(arg_end - arg), arg);
        HANDLE_ERROR(parse_integer(arg, arg_end, offset));
        *offset += position;
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
    *offset = label->position + add_offset;
    return 0;
}


static result_t calculate_offsets(struct compilation_table *table, int64_t position, char *args, char *args_end, int64_t nargs, int32_t *offsets_length)
{
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


static result_t encode_command(struct compilation_table *table, char *line, int64_t position, struct output_buffer *dst, int64_t *result_length)
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

    /* encode native_command */
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
    
    // TODO: corner cases, this isn'table pretty :(
    if (strcmp(cmd->name, "MOV_CONST") == 0 ||
        strcmp(cmd->name, "INT") == 0 ||
        strcmp(cmd->name, "IN") == 0 ||
        strcmp(cmd->name, "OUT") == 0)
    {
        /* parse first argument as integer */
        char *cnt_e = strchr(line + name_len, ',');
        if (cnt_e == NULL)
        {
            PRINT_ERROR("command %s have only one parameter.", cmd->name);
            return 1;
        }
        
        HANDLE_ERROR(parse_integer(line + name_len, cnt_e, offsets + 0));
        HANDLE_ERROR(calculate_offsets(table, position, cnt_e + 1, line_end, cmd->nargs - 1, offsets + 1));
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


#define STARTSWITH(s, str) (strncmp((s), str, sizeof(str) - 1) == 0 && !iskey((s)[sizeof(str) - 1]))


static result_t encode_directive_data(struct compilation_table *table, char *line, char *line_end, int64_t position, struct output_buffer *dst, int64_t *result_length)
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


static result_t encode_directive_align(struct compilation_table *table, char *line, char *line_end, int64_t position, struct output_buffer *dst, int64_t *result_length)
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


static result_t encode_directive(struct compilation_table *table, char *line, int64_t position, struct output_buffer *dst, int64_t *result_length)
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


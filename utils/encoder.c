#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "assert.h"
#include "malloc.h"
#include "string.h"
#include "ctype.h"

#include "../utils/assembler.h"


ssize_t decode_instruction_length(BYTE *line)
{
    BYTE header = *line;
    switch (header & (ARG_SIZE_OPCODE_MASK | ARG_NUM_OPCODE_MASK))
    {
        case ARG_NUM_0 | ARG_SIZE_WORD:
            return 1;
        case ARG_NUM_2 | ARG_SIZE_WORD:
            return 1 + 2 * 2;
        case ARG_NUM_3 | ARG_SIZE_WORD:
            return 1 + 2 * 3;
        case ARG_NUM_4 | ARG_SIZE_WORD:
            return 1 + 2 * 4;
        case ARG_NUM_0 | ARG_SIZE_DWORD:
            return 1;
        case ARG_NUM_2 | ARG_SIZE_DWORD:
            return 1 + 4 * 2;
        case ARG_NUM_3 | ARG_SIZE_DWORD:
            return 1 + 4 * 3;
        case ARG_NUM_4 | ARG_SIZE_DWORD:
            return 1 + 4 * 4;
        default:
            return 0;
    }
}


static char *skip_leading_spaces(char *s)
{
    while (*s != '\0' && isspace(*s))
    {
        s++;
    }
    return s;
}

static int add_label(struct compilation_table *t, char *name, ssize_t len, ssize_t offset)
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

#define STARTSWITH(s, str) strncmp((s), str, sizeof(str)) == 0

static int encode_command(struct compilation_table *t, char *line, struct output_buffer *out)
{
    line = skip_leading_spaces(line);

    /* end of line - start of comment or new line */
    char *line_end = strchr(line, ';');
    if (line_end == NULL)
    {
        line_end = line + strlen(line);
    }

    /* encode command */
    for (ssize_t i = 0; i < (ssize_t)sizeof(commands) / (ssize_t)sizeof(*commands); ++i)
    {
        size_t name_len = strlen(commands[i].name);
        if (strncmp(line, commands[i].name, name_len) == 0)
        {
            /* skip command name */
            line += name_len;

            printf("FOUND COMMAND: %s\n", commands[i].name);

            /* calculate all offsets */
            ssize_t offsets[MAX_COMMAND_ARGUMENTS] = {};
            char *arg = line;
            for (ssize_t a = 0; a < commands[i].nargs; ++a)
            {
                // offsets[a] = calculate_offset(t, arg);
                arg = strchr(line, ',');
            }
        
            /* this is this command: generate headers */
            BYTE opcode = commands[i].code;
            
            return 0;
        }
    }
    fprintf(stderr, "Unknown command: %s\n", line);
    return 1;
}

int build_program(char **lines, ssize_t lines_len, struct output_buffer *out)
{
    struct compilation_table t;
    t.labels = NULL;
    t.labels_len = 0;
    t.labels_alloc = 0;

    for (ssize_t i = 0; i < lines_len; ++i)
    {
        /* skip leading spaces */
        char *s = skip_leading_spaces(lines[i]);
        if (*s == '\0') { continue; }
        
        /* switch line type */
        if (s[0] == '.')
        {
            /* compilation directives */
            if (STARTSWITH(s + 1, "align "))
            {
                fprintf(stderr, "Not implemented error: align directive\n");
                return 1;
            }
            else if (STARTSWITH(s + 1, "data "))
            {
                fprintf(stderr, "Not implemented error: data directive\n");
                return 1;
            }
            /* labels */
            {
                char *start = s + 1, *end = s + 1;
                while (isalpha(*end))
                {
                    end++;
                }
                if (start != end)
                {
                    add_label(&t, start, end - start, out->len);
                }
            }
        }
        else
        {
            /* command */
            encode_command(&t, s, out);
        }
    }
}

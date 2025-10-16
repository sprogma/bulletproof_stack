#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "assert.h"
#include "malloc.h"
#include "string.h"
#include "stdlib.h"
#include "ctype.h"

#include "../utils/assembler.h"


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


int isstartkey(int c)
{
    return isalpha(c) || c == '_';
}


int iskey(int c)
{
    return isalpha(c) || isdigit(c) || c == '_';
}


int is_all_digits(char *s, char *e)
{
    for (char *p = s; p < e; ++p)
    {
        if (!isdigit(*p))
        {
            return 0;
        }
    }
    return 1;
}


char *skip_leading_spaces(char *s)
{
    while (*s != '\0' && isspace(*s)) { s++; }
    return s;
}


void str_trim(char **p_s, char **p_e)
{
    *p_s = skip_leading_spaces(*p_s);

    char *e = *p_e;
    // e[-1] is last character inside string [s, e)
    while (e[-1] != '\0' && isspace(e[-1])) { e--; }
}


result_t parse_integer(char *s, char *e, int32_t *result)
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

#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int add_source_data_line(struct optimizer *o, char type, int s, int e, int line, const char *code)
{
    printf("registating source line: %c [%d %d] %d:%s\n", type, s, e, line, code);
    uint32_t hash = uint32_hash(s);
    uint32_t pos = hash % o->lines_buff;
    for (uint32_t i = 0; i < o->lines_buff && o->lines[pos].start != 0; ++i)
    {
        pos++;
        if (pos == o->lines_buff)
        {
            pos = 0;
        }
    }
    if (o->lines[pos].start != 0)
    {
        printf("Error: no empty cell in hashtable. Increase initial capacity\n");
        abort();
    }
    o->lines[pos].start = s;
    o->lines[pos].end = e;
    o->lines[pos].line = line;
    o->lines[pos].code = strdup(code);
    o->lines[pos].type = (type == 'I' ? SOURCE_LINE_COMMAND : SOURCE_LINE_DATA);
    return 0;
}


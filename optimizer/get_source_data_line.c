#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int get_source_data_line(struct optimizer *o, int start, struct source_line **result)
{
    uint32_t hash = uint32_hash(start);
    uint32_t pos = hash % o->lines_buff;
    for (uint32_t i = 0; i < o->lines_buff && o->lines[pos].start != 0 && o->lines[pos].start != start; ++i)
    {
        pos++;
        if (pos == o->lines_buff)
        {
            pos = 0;
        }
    }
    if (o->lines[pos].start != start)
    {
        printf("Warinig: line with this address [%d] not found in hashtable\n", start);
        return 1;
    }
    *result = o->lines + pos;
    return 0;
}



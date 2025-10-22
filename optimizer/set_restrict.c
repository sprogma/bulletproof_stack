#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int set_restrict(struct tree *t, int start, int end, int is_restrict)
{
    int from, to;
    get_mem_slice(t, start, end, &from, &to);
    /* set data */
    for (int i = from; i <= to; ++i)
    {
        t->regions[i].is_restrict = is_restrict;
    }

    return 0;
}


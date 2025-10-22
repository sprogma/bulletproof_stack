#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int insert_region(struct tree *t, int pos)
{
    memmove(t->regions + pos + 1, t->regions + pos, sizeof(*t->regions) * (t->regions_len - pos));
    t->regions_len++;
    return 0;
}


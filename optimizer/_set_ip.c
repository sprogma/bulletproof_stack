#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int set_ip(struct tree *t, int entry)
{
    set_region_value(t, 0, 4, 0, &entry);
    set_restrict(t, 0, 4, t->restrict_id++);
    return 0;
}


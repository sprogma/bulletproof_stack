#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int get_ip(struct tree *t)
{
    BYTE mem[4];
    BYTE bad[4];
    get_memory(t, 0, 4, mem, bad);
    assert_not_corrupted(bad, 4, "Error: IP is corrupted with unknown data");
    return *(int *)mem;
}


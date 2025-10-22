#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int find_region(struct tree *t, int ptr)
{
    int l = 0, r = t->regions_len;
    while (r - l > 1)
    {
        int m = (l + r) / 2;
        if (t->regions[m].start > ptr)
        {
            r = m;
        }
        else
        {
            l = m;
        }
    }
    if (!(t->regions[l].start <= ptr && t->regions[l].end > ptr))
    {
        printf("search for %d, found at %d : [%d %d]\n", ptr, l, t->regions[l].start, ptr);
        // *(int *)NULL = 5;
        assert(t->regions[l].start <= ptr && t->regions[l].end > ptr);
    }
    return l;
}


#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int clear_region_masters(struct tree *t, int start, int end)
{

    if (start == -1)
    {
        if (end != -1)
        {
            printf("ERROR: clear_region_masters with start == -1 and end != -1\n");
            abort();
        }
        for (int i = 0; i < t->regions_len; ++i)
        {
            if (t->regions[i].is_restrict == 0)
            {
                free_ll_node(t->regions[i].deps);
                t->regions[i].deps = NULL;
            }
        }
        return 0;
    }
    
    if (end == -1)
    {
        /* if length is unknown, don't remove masters from segment */
        return 0;
    }
    
    int from, to;
    get_mem_slice(t, start, end, &from, &to);
    
    for (int i = from; i <= to; ++i)
    {
        free_ll_node(t->regions[i].deps);
        t->regions[i].deps = NULL;
    }
    return 0;
}



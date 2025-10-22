#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int add_region_master(struct tree *t, int start, int end, struct node *master)
{
    if (start == -1)
    {
        if (end != -1)
        {
            printf("ERROR: add_region_master with start == -1 and end != -1\n");
            abort();
        }
        for (int i = 0; i < t->regions_len; ++i)
        {
            if (t->regions[i].is_restrict == 0)
            {
                add_ll_node(t->regions + i, master);
            }
        }
        return 0;
    }
    
    int from, to;
    get_mem_slice(t, start, end, &from, &to);
    
    for (int i = from; i <= to; ++i)
    {
        add_ll_node(t->regions + i, master);
    }
    return 0;
}



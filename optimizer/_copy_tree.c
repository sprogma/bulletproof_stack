#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int copy_tree(struct tree *t1, struct tree *t2)
{
    *t2 = *t1;
    /* duplicate regions */
    t2->regions = calloc(1, sizeof(*t2->regions) * 128 * 1024);
    t2->regions_len = t1->regions_len;
    for (int i = 0; i < t1->regions_len; ++i)
    {
        t2->regions[i] = t1->regions[i];
        /* copy ll_nodes */
        t2->regions[i].deps = NULL;
        {
            struct ll_node *x = t1->regions[i].deps;
            while (x != NULL)
            {
                add_ll_node(t2->regions + i, x->node);
                x = x->next;
            }
        }
    }
    return 0;
}


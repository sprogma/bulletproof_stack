#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int load_deps_ll_nodes(struct tree *t, struct dependence *deps, int deps_len)
{
    for (int i = 0; i < deps_len; ++i)
    {
        if (deps[i].start != -1)
        {
            if (deps[i].end != -1)
            {
                int size = deps[i].start - deps[i].end;
                /* load information */
                BYTE *mem = malloc(size);
                BYTE *bad = malloc(size);
                get_memory(t, deps[i].start, size, mem, bad);
                if (!is_corrupted(bad, size))
                {
                    add_mem_value(&deps[i].mem, mem, size);
                }
                free(mem);
                free(bad);
            }
            int from, to;
            get_mem_slice(t, deps[i].start, deps[i].end, &from, &to);
            /* copy all nodes */
            for (int j = from; j <= to; ++j)
            {
                struct ll_node *x = t->regions[j].deps;
                while (x != NULL)
                {
                    add_ll_node_to_dep(deps + i, x->node);
                    x = x->next;
                }
            }
        }
    }
    return 0;
}


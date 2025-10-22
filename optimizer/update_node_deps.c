#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int update_node_deps(struct node *n, struct dependence *deps, int deps_len)
{
    /* foreach dep: if node already have dep with same address, than join ll_lists - else - add new dep */
    for (int i = 0; i < deps_len; ++i)
    {
        int was = 0;
        for (; was < n->deps_len; ++was)
        {
            if (n->deps[was].start == deps[i].start && n->deps[was].end == deps[i].end)
            {
                struct ll_node *x = deps[i].deps;
                while (x != NULL)
                {
                    add_ll_node_to_dep(n->deps + was, x->node);
                    x = x->next;
                }
                free_ll_node(deps[i].deps);
                break;
            }
        }
        if (was == n->deps_len)
        {
            assert(n->deps_len < MAX_CHILDS);
            n->deps[n->deps_len++] = deps[i];
        }
    }

    return 0;
}



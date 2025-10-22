#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int update_write_dependence(struct tree *t, struct node *n, int start, int end)
{
    /* update master's set array */
    struct write *w = NULL;
    {
        for (int i = 0; i < n->set_len; ++i)
        {
            assert(n->set[i].end != 0);
            if (n->set[i].start == start && n->set[i].end == end)
            {
                w = n->set + i;
                break;
            }
        }
        if (w == NULL)
        {
            w = n->set + (n->set_len++);
            w->start = start;
            w->end = end;
            w->deps = NULL;
        }
    }

    assert(w->start == start);
    assert(w->end == end);
    
    if (start == -1)
    {
        if (end != -1)
        {
            printf("ERROR: update_write_dependence with start == -1 and end != -1\n");
            abort();
        }
        
        for (int i = 0; i < t->regions_len; ++i)
        {
            if (t->regions[i].is_restrict == 0)
            {
                struct ll_node *x = t->regions[i].deps;
                while (x != NULL)
                {
                    add_ll_node_to_set(w, x->node);
                    x = x->next;
                }
            }
        }
        return 0;
    }
    
    assert(w->start != w->end);
    
    int from, to;
    get_mem_slice(t, start, end, &from, &to);
    
    for (int i = from; i <= to; ++i)
    {
        struct ll_node *x = t->regions[i].deps;
        while (x != NULL)
        {
            add_ll_node_to_set(w, x->node);
            x = x->next;
        }
    }
    return 0;
}


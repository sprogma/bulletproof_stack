#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int get_mem_slice(struct tree *t, int start, int end, int *l, int *r)
{
    /* 1. find regions */
    if (start == -1)
    {
        printf("ERROR get mem slice with start == -1\n");
        // *(int *)(NULL) = 5;
        abort();
    }
    int from = find_region(t, start);
    int to = from;
    if (end == -1)
    {
        while (to < t->regions_len && t->regions[to].is_restrict == t->regions[from].is_restrict)
        {
            to++;
        }
        to--;
        /* update end of segment */
        end = t->regions[to].end;
    }
    else
    {
        to = find_region(t, end - 1);
    }
    // printf("was [%d %d] ... [%d %d]\n", t->regions[to].start, t->regions[to].end, t->regions[from].start, t->regions[from].end);
    /* 2. split <to> on two parts */
    if (end != t->regions[to].end)
    {
        /* split region */
        insert_region(t, to);
        t->regions[to] = t->regions[to + 1];
        t->regions[to].deps = NULL;
        {
            struct ll_node *x = t->regions[to + 1].deps;
            while (x != NULL)
            {
                add_ll_node(t->regions + to, x->node);
                x = x->next;
            }
        }
        t->regions[to].end = end;
        if (t->regions[to + 1].value != NULL)
        {
            t->regions[to + 1].value += end - t->regions[to + 1].start;
        }
        t->regions[to + 1].start = end;
        // printf("[%d %d] U [%d %d]\n", t->regions[to].start, t->regions[to].end, t->regions[to + 1].start, t->regions[to + 1].end);
    }
    /* 3. split <from> on two parts */
    if (start != t->regions[from].start)
    {
        /* split region */
        insert_region(t, from);
        t->regions[from] = t->regions[from + 1];
        t->regions[from].deps = NULL;
        {
            struct ll_node *x = t->regions[from + 1].deps;
            while (x != NULL)
            {
                add_ll_node(t->regions + to, x->node);
                x = x->next;
            }
        }
        t->regions[from].end = start;
        if (t->regions[from + 1].value != NULL)
        {
            t->regions[from + 1].value += start - t->regions[from + 1].start;
        }
        t->regions[from + 1].start = start;
        // printf("[%d %d] U [%d %d]\n", t->regions[from].start, t->regions[from].end, t->regions[from + 1].start, t->regions[from + 1].end);
        from++;
        to++;
    }
    *l = from;
    *r = to;
    return 0;
}


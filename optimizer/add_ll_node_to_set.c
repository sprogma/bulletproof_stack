#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int add_ll_node_to_set(struct write *w, struct node *new_dep)
{
    struct ll_node *x = w->deps;
    while (x != NULL)
    {
        if (x->node == new_dep)
        {
            return 0;
        }
        x = x->next;
    }
    struct ll_node *new_ll_node = malloc(sizeof(*new_ll_node));
    new_ll_node->node = new_dep;
    new_ll_node->next = w->deps;
    w->deps = new_ll_node;
    return 0;
}


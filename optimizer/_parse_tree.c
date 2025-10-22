#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int parse_tree(struct tree *t)
{
    /* start main loop: parse current instruction */
    int ip = get_ip(t);
    struct node *next_node = NULL;
    while (1)
    {
        
        printf("Getting node at ip=%d\n", ip);
        struct node *n = (next_node == NULL ? get_node(t, ip) : next_node);
        if (n == NULL)
        {
            printf("End execution...\n");
            return 0;
        }

        /* this instruction can be reached */
        n->flags |= NODE_REACHED;

        /* check - if we was visited this node before, check, */
        /* is there looping */
        if (LOOP_MODEL == FULL_MATCH)
        {
            int loop = -1;
            if ((loop = is_full_looped(t)) != -1)
            {
                printf("FULL LOOP FOUND with state %d\n", loop);
                /* as this is full match, we can end current parsing */
                return 0;
            }
        }
        else
        {
            /* here we must to do some had work, */
            /* joining two states, and continuing looping */
            /* until we get full match, but this will be */
            /* faster due to mergings */
            printf("LOOP_MODEL == IP_MATCH is unsupported for now\n");
            abort();
        }
        
        /* push state ... before processing to next one */
        push_state(t);

        /* set deps of node: see on which address it depends */
        struct dependence *deps = calloc(1, sizeof(*n->deps) * 16);
        int deps_len = 0;
        extract_deps(t, n, deps, &deps_len, ip);
        load_deps_ll_nodes(t, deps, deps_len);
        update_node_deps(n, deps, deps_len);

        printf("Extracted %d operation deps: NOW total %d\n", deps_len, n->deps_len);

        for (int i = 0; i < n->deps_len; ++i)
        {
            printf("dep[%d]\n", i);
            printf("range [%d %d]\n", n->deps[i].start, n->deps[i].end);
            struct ll_node *x = n->deps[i].deps;
            while (x != NULL)
            {
                printf(">>> node %p\n", x->node);
                x = x->next;
            }
        }

        /* process machine */
        ip = process_machine(t, n, ip);
        if (ip == -1)
        {
            printf("End execution\n");
            return 0;
        }
        next_node = get_node(t, ip);
        if (next_node != NULL)
        {
            add_child(t, n, next_node);
        }
    }
    return 0;
}


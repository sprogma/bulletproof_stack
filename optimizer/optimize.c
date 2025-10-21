#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"


typedef unsigned char BYTE;


#define PUSH(node) do { \
    buffer[buffer_end++] = (node); \
    if (buffer_end == MAX_LOOP_FIND_BUFFER) buffer_end = 0; \
    assert(buffer_end != buffer_start); \
} while (0)
                     
#define POP() do {buffer_start++; if (buffer_start == MAX_LOOP_FIND_BUFFER) buffer_start = 0;} while (0)

struct min_loop_parent
{
    struct node *node, *parent;
};

int find_minimal_loop_parent(struct min_loop_parent *parents, uint32_t parents_size, struct node *node)
{
    uint32_t pos = uint32_hash(((uintptr_t)(node) >> 32) ^ (uintptr_t)(node)) % parents_size;
    for (uint32_t i = 0; i < parents_size && parents[pos].node != node && parents[pos].node != NULL; ++i)
    {
        pos++;
        if (pos == parents_size)
        { 
            pos = 0; 
        }
    }
    return pos;
}

int find_minimal_loop(struct optimizer *o, struct node *start_node, struct node **result, int *result_len)
{
    (void)o;
    
    const uint32_t parents_size = 2 * MAX_NODES;
    static struct min_loop_parent parents[2 * MAX_NODES] = {};
    static struct node *buffer[MAX_LOOP_FIND_BUFFER];
    int buffer_start = 0, buffer_end = 0;
    buffer[buffer_end++] = start_node;

    memset(parents, 0, sizeof(parents));

    // printf("start from %p\n", start_node);
    while (buffer_start != buffer_end)
    {
        struct node *curr = buffer[buffer_start];
        POP();
        // printf("NODE %p\n", curr);
    
        /* push unpushed childs */
        for (int i = 0; i < curr->childs_len; ++i)
        {
            struct node *c = curr->childs[i];
            // printf("    his child: %p\n", c);
            /* if found loop: */
            if (c == start_node)
            {
                /* restore answer, and return it */
                int pos = 0;
                result[pos++] = curr;
                // printf("Loop: end at %p\n", curr);
                while (curr != start_node)
                {
                    int prev = find_minimal_loop_parent(parents, parents_size, curr);
                    if (parents[prev].node != curr)
                    {
                        break;
                    }
                    curr = parents[prev].parent;
                    result[pos++] = curr;
                    // printf("Loop: before it was %p\n", curr);
                }
                /* reverse result buffer */
                for (int i = 0; i < pos / 2; ++i)
                {
                    struct node *tmp = result[pos - i - 1];
                    result[pos - i - 1] = result[i];
                    result[i] = tmp;
                }
                *result_len = pos;
                return 0;
            }
            int pos = find_minimal_loop_parent(parents, parents_size, c);
            if (parents[pos].node == NULL)
            {
                parents[pos].node = c;
                parents[pos].parent = curr;
                PUSH(c);
            }
        }
    }
    /* there is no loop with this instruction */
    *result_len = 0;
    return 0;
}

#undef PUSH
#undef POP


int optimize(struct optimizer *o, FILE *f)
{
    for (int node = 0; node < o->nodes_len; ++node)
    {
        struct node *n = o->nodes + node;
        if (FLAG(n->flags, NODE_CHANGE_FLOW))
        {
            struct source_line *x;
            get_source_data_line(o, n->op_address, &x);
            fprintf(f, "CODE LINE CONTROLS WORKFLOW: %d:%s\n", x->line, x->code);
        }
    }

    fprintf(f, "----------------------------------------------- notes ------------------------------------------------\n");

    /* try to find out unused nodes */
    for (int node = 0; node < o->nodes_len; ++node)
    {
        struct node *n = o->nodes + node;
        if (n->op.code == O_OUT || n->op.code == O_IN ||
            FLAG(n->flags, NODE_CHANGE_FLOW) ||  // if instruction changes IP, it is used
           !FLAG(n->flags, NODE_REACHED))       // if instruction is unreachable, there is no need to show this warning
        {
            goto find_next_unused_node;
        }
        for (int x = 0; x < o->nodes_len; ++x)
        {
            struct node *nx = o->nodes + x;

            for (int i = 0; i < nx->deps_len; ++i)
            {
                struct ll_node *t = nx->deps[i].deps;
                while (t != NULL)
                {
                    if (t->node == n)
                    {
                        /* foud */
                        goto find_next_unused_node;
                    }
                    t = t->next;
                }
            }
        }

        /* there is no node depend on this */
        struct source_line *x;
        get_source_data_line(o, n->op_address, &x);
        fprintf(f, "OPT: result of this instruction is probably unused:\n");
        fprintf(f, "     instruction %d:%s\n", x->line, x->code);

    find_next_unused_node:;
    }


    /* try to find nodes, which are unreachable */
    for (int node = 0; node < o->nodes_len; ++node)
    {
        struct node *n = o->nodes + node;
        if (!FLAG(n->flags, NODE_REACHED))
        {
            struct source_line *x;
            get_source_data_line(o, n->op_address, &x);
            fprintf(f, "OPT: this instruction is unreachable:\n");
            fprintf(f, "     instruction %d:%s\n", x->line, x->code);
            fprintf(f, "\n");
        }
    }

    /* try to find branches, which are always taken / not taken */
    for (int node = 0; node < o->nodes_len; ++node)
    {
        struct node *n = o->nodes + node;
        if (FLAG(n->flags, NODE_TAKEN) && !FLAG(n->flags, NODE_NOT_TAKEN))
        {
            struct source_line *x;
            get_source_data_line(o, n->op_address, &x);
            fprintf(f, "OPT: this conditonal instruction is always taken:\n");
            fprintf(f, "     instruction %d:%s\n", x->line, x->code);
            fprintf(f, "\n");
        }
        if (FLAG(n->flags, NODE_NOT_TAKEN) && !FLAG(n->flags, NODE_TAKEN))
        {
            struct source_line *x;
            get_source_data_line(o, n->op_address, &x);
            fprintf(f, "OPT: this conditonal instruction is always not taken:\n");
            fprintf(f, "     instruction %d:%s\n", x->line, x->code);
            fprintf(f, "\n");
        }
    }

    /* try to find instructions which are unused inside loop */
    for (int node = 0; node < o->nodes_len; ++node)
    {
        struct node *n = o->nodes + node;
        /* find minimal loop, for this instruction */
        struct node *loop[256];
        int loop_len;
        find_minimal_loop(o, n, loop, &loop_len);

        if (loop_len == 0 || 
            n->op.code == O_OUT || n->op.code == O_IN ||
            FLAG(n->flags, NODE_CHANGE_FLOW) ||  // if instruction changes IP, it is used
           !FLAG(n->flags, NODE_REACHED))        // if instruction is unreachable, there is no need to show this warning
        {
            goto find_next_loop_local_node;
        }

        for (int i = 0; i < loop_len; ++i)
        {
            struct node *nx = loop[i];
            for (int dep = 0; dep < nx->deps_len; ++dep)
            {
                struct ll_node *t = nx->deps[dep].deps;
                while (t != NULL)
                {
                    if (t->node == n)
                    {
                        /* foud */
                        goto find_next_loop_local_node;
                    }
                    t = t->next;
                }
            }
        }

        {
            struct source_line *x;
            get_source_data_line(o, n->op_address, &x);
            if (FLAG(n->flags, NODE_WRITE_TO_UNKNOWN))
            {
                fprintf(f, "OPT: [may be false] this instruction is located in some loop, and is unused inside it.\n");
                fprintf(f, "     but, this instruction writes to unknown position. It can be, that\n");
                fprintf(f, "     this instruction writes to diffrent places at each loop, so optimize\n");
                fprintf(f, "     carefuly, if this can be optimized at all.\n");
            }
            else
            {
                fprintf(f, "OPT: [probably false] this instruction is located in some loop, but is unused inside it:\n");
                fprintf(f, "     maybe you can move this instruction out from loop?\n");
            }
            fprintf(f, "     instruction %d:%s\n", x->line, x->code);
            fprintf(f, "     in loop of %d instructions [smallest possible loop].\n", loop_len);
            fprintf(f, "\n");
        }
        // for (int i = 0; i < loop_len; ++i)
        // {
        //     struct source_line *x;
        //     get_source_data_line(o, loop[i]->op_address, &x);
        //     fprintf(f, "         %d:%s\n", x->line, x->code);
        // }
        
    find_next_loop_local_node:;
    }


    /* try to find instructions for which it is unnesesary to be inside loop */
    for (int node = 0; node < o->nodes_len; ++node)
    {
        struct node *n = o->nodes + node;
        /* find minimal loop, for this instruction */
        struct node *loop[256];
        int loop_len;
        find_minimal_loop(o, n, loop, &loop_len);

        if (loop_len == 0 || 
            n->op.code == O_OUT || n->op.code == O_IN ||
            FLAG(n->flags, NODE_CHANGE_FLOW) ||  // if instruction changes IP, it is used
           !FLAG(n->flags, NODE_REACHED))        // if instruction is unreachable, there is no need to show this warning
        {
            goto find_next_loop_no_need_node;
        }

        /* 1. No instruction inside loop set same data as this instruction: */
        for (int i = 0; i < loop_len; ++i)
        {
            struct node *nx = loop[i];
            if (nx != n)
            {
                for (int set = 0; set < nx->set_len; ++set)
                {
                    struct ll_node *t = nx->set[set].deps;
                    while (t != NULL)
                    {
                        if (t->node == n)
                        {
                            /* found */
                            goto find_next_loop_no_need_node;
                        }
                        t = t->next;
                    } 
                }
            }
        }

        /* 2. This instruction don't depends on any other instruction inside loop */
        for (int dep = 0; dep < n->deps_len; ++dep)
        {
            struct ll_node *t = n->deps[dep].deps;
            while (t != NULL)
            {
                for (int i = 0; i < loop_len; ++i)
                {
                    struct node *nx = loop[i];
                    if (t->node == nx)
                    {
                        /* found */
                        goto find_next_loop_no_need_node;
                    } 
                }
                t = t->next;
            }
        }

        /* - print optimization tip */
        {
            struct source_line *x;
            get_source_data_line(o, n->op_address, &x);
            fprintf(f, "OPT: this instruction is located in loop, but it's value\n");
            fprintf(f, "     will be same on each iteration + no any instruction writes to same place,\n");
            fprintf(f, "     so, likely, you can move this instruction out from loop.\n");
            fprintf(f, "     instruction %d:%s\n", x->line, x->code);
            fprintf(f, "     in loop of %d instructions [smallest possible loop].\n", loop_len);
            fprintf(f, "\n");
        }
        // for (int i = 0; i < loop_len; ++i)
        // {
        //     struct source_line *x;
        //     get_source_data_line(o, loop[i]->op_address, &x);
        //     fprintf(f, "         %d:%s\n", x->line, x->code);
        // }
        
    find_next_loop_no_need_node:;
    }


    printf("Optimization info writed.\n");

    return 0;
}

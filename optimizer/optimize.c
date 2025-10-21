#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"


typedef unsigned char BYTE;


int optimize(struct optimizer *o, FILE *f)
{
    for (int node = 0; node < o->nodes_len; ++node)
    {
        struct node *n = o->nodes + node;
        if (n->controls_workflow)
        {
            struct source_line *x;
            get_source_data_line(o, n->op_address, &x);
            fprintf(f, "CODE LINE CONTROLS WORKFLOW: %d:%s\n", x->line, x->code);
        }   
    }

    /* try to find out unused nodes */
    for (int node = 0; node < o->nodes_len; ++node)
    {
        struct node *n = o->nodes + node;
        if (n->op.code == O_OUT || n->op.code == O_IN || n->controls_workflow)
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

//     
// 
//     /* write all nodes in json format */
//     fprintf(f, "{\"Nodes\": [");
//     for (int node = 0; node < o->nodes_len; ++node)
//     {
//         if (node != 0) { fprintf(f, ","); }
//         
//         struct node *n = o->nodes + node;
//         fprintf(f, "{");
//         {
//             /* dump node */
//             fprintf(f, "\"Key\": \"%p\",", n);
//             fprintf(f, "\"Name\": \"%s\",", n->op.name);
//             fprintf(f, "\"Address\": %d,", n->op_address);
//             fprintf(f, "\"Ptrptr\": %s,", (n->op.ptr_on_ptr ? "true" : "false"));
//             fprintf(f, "\"Opcode\": %d,", n->op.code);
//             fprintf(f, "\"Args\": [");
//             {
//                 /* dump args */
//                 for (int arg = 0; arg < n->op.nargs; ++arg)
//                 {
//                     if (arg != 0) { fprintf(f, ","); }
//                     fprintf(f, "%d", n->op.args[arg] + n->op_address);
//                 }
//             } 
//             fprintf(f, "],");
//             fprintf(f, "\"Deps\": [");
//             {
//                 /* dump deps */
//                 for (int dep = 0; dep < n->deps_len; ++dep)
//                 {
//                     if (dep != 0) { fprintf(f, ","); }
//                     fprintf(f, "{\"Start\": %d, \"End\": %d, \"Nodes\": [", n->deps[dep].start, n->deps[dep].end);
//                     {
//                         /* dump nodes */
//                         struct ll_node *x = n->deps[dep].deps;
//                         while (x != NULL)
//                         {
//                             fprintf(f, "\"%p\"", x->node);
//                             x = x->next;
//                             if (x != NULL)
//                             {
//                                 fprintf(f, ",");
//                             }
//                         }
//                     }
//                     fprintf(f, "]}");
//                 }
//             }
//             fprintf(f, "]");
//         }
//         fprintf(f, "}");
//     }
//     fprintf(f, "],\"Flow\":[");
//     for (int node = 0; node < o->nodes_len; ++node)
//     {
//         struct node *n = o->nodes + node;
//         if (node != 0 && n->childs_len > 0) { fprintf(f, ","); }
//         for (int c = 0; c < n->childs_len; ++c)
//         {
//             if (c != 0) { fprintf(f, ","); }
//             fprintf(f, "{\"From\": \"%p\", \"To\": \"%p\"}", n, n->childs[c]);
//         }
//     }
//     fprintf(f, "]}");
// 

    printf("Optimization info writed.\n");
    
    return 0;
}

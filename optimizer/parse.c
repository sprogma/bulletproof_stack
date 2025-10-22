#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int parse(struct optimizer *o)
{
    /* parse until there is no tree */
    while (o->queue_len > 0)
    {
        printf("<<<<<<<<<<<<<<<<<<<<<<<<<<<< PARSING TREE >>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n");
        if (parse_tree(o->queue + 0) != 0)
        {
            printf("error in analization of tree. exiting...\n");
            return 1;
        }
        /* remove first element */
        o->queue[0] = o->queue[--o->queue_len];
    }
    printf("All states analizated.\n");
    return 0;
}


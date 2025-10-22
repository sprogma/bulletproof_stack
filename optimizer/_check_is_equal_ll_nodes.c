#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int check_is_equal_ll_nodes(struct ll_node *la, struct ll_node *lb)
{
    /* n^2 check: for each a from la check all b from lb */
    while (la != NULL)
    {
        struct ll_node *b = lb;
        while (b != NULL && la->node != b->node)
        {
            b = b->next;
        }
        if (b == NULL)
        {
            return 0;
        }
        la = la->next;
    }
    return 1;
}


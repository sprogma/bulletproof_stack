#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int free_ll_node(struct ll_node *x)
{
    if (x == NULL)
    {
        return 0;
    }
    free_ll_node(x->next);
    free(x);
    return 0;
}


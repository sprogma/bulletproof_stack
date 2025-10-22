#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int add_child(struct tree *t, struct node *n, struct node *child)
{   
    (void)t;
    for (int i = 0; i < n->childs_len; ++i)
    {
        if (n->childs[i] == child)
        {
            return 0;
        }
    }
    n->childs[n->childs_len++] = child;
    return 0;
}


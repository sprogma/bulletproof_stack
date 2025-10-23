#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int extract_deps(struct tree *t, struct node *n, struct dependence *deps, int *deps_len, int ip)
{
    struct args_variant *variant = n->args + n->args_len;
    memset(variant, 0, sizeof(*variant));
    
    extract_deps_inner(t, n, variant, deps, deps_len, ip);
    
    for (int i = 0; i < n->args_len; ++i)
    {
        if (is_args_equal(n->args + i, variant))
        {
            goto not_new_node_arg_variant;
        }
    }
    /* not found same args */
    n->args_len++;
not_new_node_arg_variant:

    return 0;
}


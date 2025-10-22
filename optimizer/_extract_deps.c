#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int extract_deps(struct tree *t, struct node *n, struct dependence *deps, int *deps_len, int ip)
{
    extract_deps_inner(t, n, deps, deps_len, ip);
    // deps[*deps_len].start = 0;
    // deps[*deps_len].end = 4;
    // deps[*deps_len].deps = NULL;
    // (*deps_len)++;
    return 0;
}


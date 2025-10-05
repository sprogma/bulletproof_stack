#include "../api.h"
#include "../common.h"
#include "stdio.h"
#include "ctype.h"
#include "string.h"
#include "stdlib.h"



result_t parser_tree_create(struct parser_tree_t *tree)
{
    assert(tree != NULL);

    tree->parsed = 0;
    tree->root = NULL;

    PRINT_INFO("Tree initializated.");

    return 0;
}

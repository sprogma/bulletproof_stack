#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int set_entry(struct tree *t, int entry)
{
    /* set node as entry node */
    struct node *n = get_node(t, entry);
    n->entry_node = 1;
    
    set_region_value(t, 0, 4, 0, &entry);
    set_restrict(t, 0, 4, t->restrict_id++);

    t->optimizer->entry_address = entry;
    return 0;
}


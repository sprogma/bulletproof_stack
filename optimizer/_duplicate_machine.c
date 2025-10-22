#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int duplicate_machine(struct tree *t)
{
    BYTE mem[4];
    BYTE bad[4];
    get_memory(t, 0, 4, mem, bad);
    assert_not_corrupted(bad, 4, "ip is corrupted");
    int ip = *(int *)mem;
    
    printf("FORK machine to queue in index %d ------- [ip = %d]\n", t->optimizer->queue_len, ip);
    copy_tree(t, t->optimizer->queue + (t->optimizer->queue_len++));
    return 0;
}



#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int is_full_looped(struct tree *t)
{
    assert(LOOP_MODEL == FULL_MATCH);    
    for (int j = 0; j < t->optimizer->states_len; ++j)
    {
        struct tree *t2 = t->optimizer->states + j;
        int i;
        int reg1 = 0;
        int reg2 = 0;
        for (i = 0; i < TOTAL_MEM; ++i)
        {
            BYTE mem1, bad1, mem2, bad2;
            get_memory(t,  i, 1, &mem1, &bad1);
            get_memory(t2, i, 1, &mem2, &bad2);
            if (bad1 != bad2)
            {
                break;
            }
            if (mem1 != mem2)
            {
                break;
            }
            while (t->regions[reg1].end <= i)
            {
                reg1++;
            }
            while (t2->regions[reg2].end <= i)
            {
                reg2++;
            }
            if (!check_is_equal_ll_nodes(t->regions[reg1].deps, t2->regions[reg2].deps))
            {
                break;
            }
        }
        /* here, we found loop! */
        if (i == TOTAL_MEM)
        {
            return j;
        }
    }
    return -1;
}



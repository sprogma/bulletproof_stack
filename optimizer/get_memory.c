#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int get_memory(struct tree *t, int start, int size, BYTE *mem, BYTE *bad)
{ 
    /* fill data */   
    int reg = find_region(t, start);
    for (int i = start; i < start + size;)
    {
        // printf("s s=[%d %d]reg=%d/%d\n", start, size, reg, t->regions_len);
        assert(t->regions[reg].start < t->regions[reg].end);
        
        /* get region end */
        int reg_end = t->regions[reg].end;
        if (reg_end > start + size)
        {
            reg_end = start + size;
        }

        /* load memory and bad */
        if (t->regions[reg].is_zero)
        {
            memset(bad + (i - start), 0x00, reg_end - i);
            memset(mem + (i - start), 0x00, reg_end - i);
            i = reg_end;
            reg++;
        }
        else if (t->regions[reg].value == NULL)
        {
            memset(bad + (i - start), 0xFF, reg_end - i);
            // memset(mem + (i - start), 0x00, reg_end - i);
            i = reg_end;
            reg++;
        }
        else
        {
            memset(bad + (i - start), 0x00, reg_end - i);
            memcpy(mem + (i - start), t->regions[reg].value + (i - t->regions[reg].start), reg_end - i);
            i = reg_end;
            reg++;
        }
    }
    return 0;
}


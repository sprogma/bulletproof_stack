#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int is_corrupted(BYTE *bad, int size)
{
    for (int i = 0; i < size; ++i)
    {
        if (bad[i] != 0)
        {
            return 1;
        }
    }
    return 0;
}


#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int set_cmd_arg(struct tree *t, struct args_variant *args, int id, int ptr, struct dependence dep)
{
    struct mem_value *arr = (ptr ? args->ptr_on_ptr : args->args);
    int size = dep.end - dep.start;
    if (dep.start == -1 || dep.end == -1)
    {
        arr[id].mem = NULL;
        arr[id].bad = NULL;
        arr[id].size = -1;
    }
    else
    {
        void *new_mem = malloc(size);
        void *new_bad = malloc(size);
        get_memory(t, dep.start, size, new_mem, new_bad);
        arr[id].mem = new_mem;
        arr[id].bad = new_bad;
        arr[id].size = size;
    }
    return 0;
}



int is_args_equal(struct args_variant *arg1, struct args_variant *arg2)
{
    for (int t = 0; t < 2; ++t)
    {
        struct mem_value *arr1 = (t ? arg1->ptr_on_ptr : arg1->args);
        struct mem_value *arr2 = (t ? arg2->ptr_on_ptr : arg2->args);
        for (int i = 0; i < 4; ++i)
        {
            if (arr1[i].size != arr2[i].size)
            {
                return 0;
            }
            if (arr1[i].mem == NULL || arr2[i].mem == NULL || 
                arr1[i].bad == NULL || arr2[i].bad == NULL)
            {
                if (arr1[i].mem != NULL || arr2[i].mem != NULL ||
                    arr1[i].bad != NULL || arr2[i].bad != NULL)
                {
                    return 0;
                }
            }
            else
            {
                if (memcmp(arr1[i].mem, arr2[i].mem, arr1[i].size) != 0 ||
                    memcmp(arr1[i].bad, arr2[i].bad, arr1[i].size) != 0)
                {
                    return 0;
                }
            }
        }
    }
    return 1;
}

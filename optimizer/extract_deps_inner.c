
#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



#define STANDART_PTR_DEPS(CNT) for (int i = 0; i < CNT; ++i) \
                               { \
                                   deps[i].start = n->op.args[i] + ip; \
                                   deps[i].end = n->op.args[i] + ip + 4; \
                                   deps[i].deps = NULL; \
                               }
#define DEP_ON_SPAN_FROM_PTR(i, ptr, size) { \
                                    int _ptr = ptr; \
                                    int _size = size; \
                                    if (_ptr == -1) \
                                    { \
                                        deps[i].start = -1; \
                                        deps[i].end = -1; \
                                        deps[i].deps = NULL; \
                                    } \
                                    else \
                                    { \
                                        BYTE mem[4]; \
                                        BYTE bad[4]; \
                                        get_memory(t, _ptr, sizeof(mem), mem, bad); \
                                        int src = (is_corrupted(bad, 4) ? -1 : *(int *)mem); \
                                        deps[i].start = src; \
                                        deps[i].end = (src == -1 ? -1 : src + _size); \
                                        deps[i].deps = NULL; \
                                    } \
                                }




int extract_deps_inner(struct tree *t, struct node *n, struct args_variant *args, struct dependence *deps, int *deps_len, int ip)
{
    int offset = !!(n->op.constant);
    int count = n->op.nargs - offset;

    switch (n->op.code)
    {
        case O_NOP:
            *deps_len = 0;
            return 0;
        case O_LEA:
        {
            *deps_len = 0; 
            if (n->op.ptr_on_ptr)
            {
                deps[0].start = n->op.args[0] + ip;
                deps[0].end = n->op.args[0] + ip + 4;
                deps[0].deps = NULL;

                set_cmd_arg(t, args, 0, 1, deps[0]);
                *deps_len = 1;
            }
            return 0;
        }
        case O_CLEA:
        {
            int src = -1;
            if (n->op.ptr_on_ptr)
            {
                deps[0].start = n->op.args[0] + ip;
                deps[0].end = n->op.args[0] + ip + 4;
                deps[0].deps = NULL;

                deps[1].start = n->op.args[1] + ip;
                deps[1].end = n->op.args[1] + ip + 4;
                deps[1].deps = NULL;
                
                BYTE mem[4];
                BYTE bad[4];
                get_memory(t, n->op.args[0] + ip, sizeof(mem), mem, bad);
                src = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                
                deps[2].start = src;
                deps[2].end = (src == -1 ? -1 : src + 4);
                deps[2].deps = NULL;
                
                set_cmd_arg(t, args, 0, 1, deps[0]);
                set_cmd_arg(t, args, 1, 1, deps[1]);
                set_cmd_arg(t, args, 0, 0, deps[2]);
                *deps_len = 3;
            }
            else
            {
                deps[0].start = n->op.args[0] + ip;
                deps[0].end = n->op.args[0] + ip + 4;
                deps[0].deps = NULL;
                
                deps[1].start = n->op.args[1] + ip;
                deps[1].end = n->op.args[1] + ip + 4;
                deps[1].deps = NULL;
                
                set_cmd_arg(t, args, 0, 0, deps[0]);
                set_cmd_arg(t, args, 1, 0, deps[1]);
                *deps_len = 2;
            }
            return 0;
        }
        case O_MOV_CONST:
            *deps_len = 0; 
            if (n->op.ptr_on_ptr)
            {
                deps[0].start = n->op.args[1] + ip;
                deps[0].end = n->op.args[1] + ip + 4;
                deps[0].deps = NULL;
                
                set_cmd_arg(t, args, 1, 1, deps[0]);
                *deps_len = 1;
            }
            return 0;
        case O_OUT:
        {
            if (n->op.ptr_on_ptr)
            {
                /* 1. deps from all three pointers */
                deps[0].start = n->op.args[1] + ip;
                deps[0].end = n->op.args[1] + ip + 4;
                deps[0].deps = NULL;
                deps[1].start = n->op.args[2] + ip;
                deps[1].end = n->op.args[2] + ip + 4;
                deps[1].deps = NULL;
                
                /* 2. add [src, size] dep */
                int size = -1, source = -1;
                
                BYTE mem[4];
                BYTE bad[4];

                DEP_ON_SPAN_FROM_PTR(2, n->op.args[2] + ip, 4);
                
                /* 1. try to get size */
                get_memory(t, n->op.args[2] + ip, sizeof(mem), mem, bad);
                if (!is_corrupted(bad, 4))
                {
                    int ptr = *(int *)mem;
                    get_memory(t, ptr, sizeof(mem), mem, bad);
                    size = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                }

                /* 2. try to get source */
                if (size != -1)
                {
                    get_memory(t, n->op.args[1] + ip, sizeof(mem), mem, bad);
                    source = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                }

                
                deps[3].start = source;
                deps[3].end = (source == -1 || size == -1 ? -1 : source + size);
                deps[3].deps = NULL;
                
                set_cmd_arg(t, args, 1, 1, deps[0]);
                set_cmd_arg(t, args, 2, 1, deps[1]);
                set_cmd_arg(t, args, 2, 0, deps[2]);
                set_cmd_arg(t, args, 1, 0, deps[3]);
                *deps_len = 4;
            }
            else
            {
                int size = -1;
                /* 1. deps from count */
                deps[0].start = n->op.args[2] + ip;
                deps[0].end = n->op.args[2] + ip + 4;
                deps[0].deps = NULL;
                
                /* try to read count */
                BYTE mem[4];
                BYTE bad[4];
                get_memory(t, n->op.args[2] + ip, sizeof(mem), mem, bad);
                size = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                
                deps[1].start = n->op.args[1] + ip;
                deps[1].end = (size == -1 ? -1 : n->op.args[1] + ip + size);
                deps[1].deps = NULL;
                
                set_cmd_arg(t, args, 2, 0, deps[0]);
                set_cmd_arg(t, args, 1, 0, deps[1]);
                *deps_len = 2;
            }
            return 0;
        }
        case O_IN:
        {
            if (n->op.ptr_on_ptr)
            {
                /* 1. deps from all three pointers */
                deps[0].start = n->op.args[1] + ip;
                deps[0].end = n->op.args[1] + ip + 4;
                deps[0].deps = NULL;
                deps[1].start = n->op.args[2] + ip;
                deps[1].end = n->op.args[2] + ip + 4;
                deps[1].deps = NULL;

                DEP_ON_SPAN_FROM_PTR(2, n->op.args[2] + ip, 4);

                set_cmd_arg(t, args, 1, 1, deps[0]);
                set_cmd_arg(t, args, 2, 1, deps[1]);
                set_cmd_arg(t, args, 2, 0, deps[2]);
                *deps_len = 3;
            }
            else
            {
                /* 1. deps from count */
                deps[0].start = n->op.args[2] + ip;
                deps[0].end = n->op.args[2] + ip + 4;
                deps[0].deps = NULL;
                
                set_cmd_arg(t, args, 2, 0, deps[0]);
                *deps_len = 1;
            }
            return 0;
        }
        case O_ANY: /* ! ANY and ALL will work another way, in process_machine, from MOV ... */
        case O_ALL: /* ! ANY and ALL will work another way, in process_machine, from MOV ... */
        case O_LT: /* ! ANY and ALL will work another way, in process_machine, from MOV ... */
        case O_MOV:
        case O_INC:
        case O_DEC:
        case O_NEG:
        case O_INV:
        {
            if (n->op.ptr_on_ptr)
            {
                /* 1. deps from all three pointers */
                STANDART_PTR_DEPS(3)
                /* 2. add [src, size] dep */
                int size = -1, source = -1;
                
                DEP_ON_SPAN_FROM_PTR(3, n->op.args[2] + ip, 4);
                
                BYTE mem[4];
                BYTE bad[4];
                /* 1. try to get size */
                get_memory(t, n->op.args[2] + ip, sizeof(mem), mem, bad);
                if (!is_corrupted(bad, 4))
                {
                    int ptr = *(int *)mem;
                    get_memory(t, ptr, sizeof(mem), mem, bad);
                    size = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                }

                /* 2. try to get source */
                if (size != -1)
                {
                    get_memory(t, n->op.args[1] + ip, sizeof(mem), mem, bad);
                    source = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                }

                deps[4].start = source;
                deps[4].end = (source == -1 || size == -1 ? -1 : source + size);
                deps[4].deps = NULL;

                set_cmd_arg(t, args, 0, 1, deps[0]);
                set_cmd_arg(t, args, 1, 1, deps[1]);
                set_cmd_arg(t, args, 2, 1, deps[2]);
                set_cmd_arg(t, args, 2, 0, deps[3]);
                set_cmd_arg(t, args, 1, 0, deps[4]);
                *deps_len = 5;
            }
            else
            {
                int size = -1;
                /* 1. deps from count */
                deps[0].start = n->op.args[2] + ip;
                deps[0].end = n->op.args[2] + ip + 4;
                deps[0].deps = NULL;
                
                /* try to read count */
                BYTE mem[4];
                BYTE bad[4];
                get_memory(t, n->op.args[2] + ip, sizeof(mem), mem, bad);
                size = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                
                deps[1].start = n->op.args[1] + ip;
                deps[1].end = (size == -1 ? -1 : n->op.args[1] + ip + size);
                deps[1].deps = NULL;
                
                set_cmd_arg(t, args, 2, 0, deps[0]);
                set_cmd_arg(t, args, 1, 0, deps[1]);
                *deps_len = 2;
            }
            return 0;
        }
        case O_ADD:
        case O_SUB:
        case O_MUL:
        case O_DIV:
        case O_AND:
        case O_XOR:
        case O_OR:
        case O_EQ:
        {
            if (n->op.ptr_on_ptr)
            {
                /* 1. deps from all three pointers */
                STANDART_PTR_DEPS(4)
                /* 2. add [dest, size] dep */
                int size = -1, source1 = -1, source2 = -1;

                DEP_ON_SPAN_FROM_PTR(4, n->op.args[3] + ip, 4);
                
                BYTE mem[4];
                BYTE bad[4];
                
                /* 1. try to get size */
                get_memory(t, n->op.args[3] + ip, sizeof(mem), mem, bad);
                if (!is_corrupted(bad, 4))
                {
                    int ptr = *(int *)mem;
                    get_memory(t, ptr, sizeof(mem), mem, bad);
                    size = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                }

                /* 2. try to get source */
                if (size != -1)
                {
                    get_memory(t, n->op.args[1] + ip, sizeof(mem), mem, bad);
                    source1 = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                    get_memory(t, n->op.args[2] + ip, sizeof(mem), mem, bad);
                    source2 = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                }

                deps[5].start = source1;
                deps[5].end = (source1 == -1 || size == -1 ? -1 : source1 + size);
                deps[5].deps = NULL;
                
                deps[6].start = source2;
                deps[6].end = (source2 == -1 || size == -1 ? -1 : source2 + size);
                deps[6].deps = NULL;

                set_cmd_arg(t, args, 0, 1, deps[0]);
                set_cmd_arg(t, args, 1, 1, deps[1]);
                set_cmd_arg(t, args, 2, 1, deps[2]);
                set_cmd_arg(t, args, 3, 1, deps[3]);
                set_cmd_arg(t, args, 3, 0, deps[4]);
                set_cmd_arg(t, args, 1, 0, deps[5]);
                set_cmd_arg(t, args, 2, 0, deps[6]);
                *deps_len = 7;
            }
            else
            {
                int size = -1;
                /* 1. deps from count */
                deps[0].start = n->op.args[3] + ip;
                deps[0].end = n->op.args[3] + ip + 4;
                deps[0].deps = NULL;
                
                /* try to read count */
                BYTE mem[4];
                BYTE bad[4];
                get_memory(t, n->op.args[3] + ip, sizeof(mem), mem, bad);
                size = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                
                deps[1].start = n->op.args[1] + ip;
                deps[1].end = (size == -1 ? -1 : n->op.args[1] + ip + size);
                deps[1].deps = NULL;
                
                deps[2].start = n->op.args[2] + ip;
                deps[2].end = (size == -1 ? -1 : n->op.args[2] + ip + size);
                deps[2].deps = NULL;

                set_cmd_arg(t, args, 3, 0, deps[0]);
                set_cmd_arg(t, args, 1, 0, deps[1]);
                set_cmd_arg(t, args, 2, 0, deps[2]);
                *deps_len = 3;
            }
            return 0;
        }
        case O_INT:
            printf("Optimization of INT nodes are unsupported. Error\n");
            return 1;
        default:
            abort();
    }
    
    if (count <= 0)
    {
        *deps_len = 0;
        return 0;
    }
    /* else - load arguments [and their lengths] */
    for (int i = 0; i < count; ++i)
    {
        int arg = i + offset;
        deps[i].start = n->op.args[arg] + ip;
        deps[i].end = deps[i].start + 4;
    }
    return 0;
}


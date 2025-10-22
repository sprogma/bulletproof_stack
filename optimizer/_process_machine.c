#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int process_machine(struct tree *t, struct node *n, int ip)
{
    // int offset = !!(n->op.constant);
    // int count = n->op.nargs - offset;

    /* store address of next instruction */
    {
        int value = ip + n->op.size;
        set_region_value(t, 0, 4, 0, &value);
    }

    switch (n->op.code)
    {
        case O_NOP:
        case O_OUT:
            /* act like NOP */
            break;
        case O_LEA:
        {
            int dest, value;
            value = n->op.args[1] + ip;
            
            if (n->op.ptr_on_ptr)
            {
                BYTE mem[4] = {};
                BYTE bad[4] = {};
                get_memory(t, n->op.args[0] + ip, sizeof(mem), mem, bad);
                dest = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                
                printf("$LEA SET to %d value %d\n", dest, value);
            }
            else
            {
                dest = n->op.args[0] + ip;
                printf("LEA SET to %d value %d\n", dest, value);
            }
            if (dest == -1)
            {
                n->flags |= NODE_WRITE_TO_UNKNOWN;
            }
            update_write_dependence(t, n, dest, (dest == -1 ? -1 : dest + 4));
            set_region_value(t, dest, (dest == -1 ? -1 : dest + 4), 0, &value);
            clear_region_masters(t, dest, (dest == -1 ? -1 : dest + 4));
            add_region_master(t, dest, (dest == -1 ? -1 : dest + 4), n);
            BYTE mem[4] = {};
            BYTE bad[4] = {};
            get_memory(t, dest, sizeof(mem), mem, bad);
            printf("READ FROM %d value %d\n", dest, *(int *)mem);
            break;
        }
        case O_CLEA:
        {
            int key_unknown = 0;
            int key = 0;
            {
                int key_addr = -1;
                if (n->op.ptr_on_ptr)
                {
                    BYTE mem[4] = {};
                    BYTE bad[4] = {};
                    get_memory(t, n->op.args[0] + ip, sizeof(mem), mem, bad);
                    key_addr = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                }
                else
                {
                    key_addr = n->op.args[0] + ip;
                }

                if (key_addr == -1)
                {
                    key_unknown = 1;
                }
                else
                {
                    BYTE mem[4] = {};
                    BYTE bad[4] = {};
                    get_memory(t, key_addr, sizeof(mem), mem, bad);
                    if (is_corrupted(bad, 4))
                    {
                        key_unknown = 1;
                    }
                    else
                    {
                        key = *(int *)mem;
                    }
                }
            }
            /* if corrupted: copy machine state, and think that branch is taken */
            if (key_unknown)
            {
                /* new machine will assune, that node wasn't taken */
                n->flags |= NODE_NOT_TAKEN;
                /* copy machine, in state there branch isn't taken */
                /* so, as IP is already set on next position, simply */
                /* call duplicate_machine */
                duplicate_machine(t);
                /* add node child */
                int new_ip = get_ip(t);
                struct node *new_node = get_node(t, new_ip);
                if (new_node != NULL)
                {
                    add_child(t, n, new_node);
                }
                /* as that machine don't taken this branch, now we think */
                /* that this branch is taken */
                key = 1;
                printf("ASSUME BRANCH TAKEN\n");
            }
            
            /* if key isn't <false> then complete LEA command */
            if (key)
            {
                n->flags |= NODE_TAKEN;
                int dest, value;
                value = n->op.args[2] + ip;
                
                if (n->op.ptr_on_ptr)
                {
                    BYTE mem[4] = {};
                    BYTE bad[4] = {};
                    get_memory(t, n->op.args[1] + ip, sizeof(mem), mem, bad);
                    dest = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                    
                    printf("$CLEA SET to %d value %d\n", dest, value);
                }
                else
                {
                    dest = n->op.args[1] + ip;
                    printf("CLEA SET to %d value %d\n", dest, value);
                }
                if (dest == -1)
                {
                    n->flags |= NODE_WRITE_TO_UNKNOWN;
                }
                update_write_dependence(t, n, dest, (dest == -1 ? -1 : dest + 4));
                set_region_value(t, dest, (dest == -1 ? -1 : dest + 4), 0, &value);
                clear_region_masters(t, dest, (dest == -1 ? -1 : dest + 4));
                add_region_master(t, dest, (dest == -1 ? -1 : dest + 4), n);
                if (dest != -1)
                {
                    BYTE mem[4] = {};
                    BYTE bad[4] = {};
                    get_memory(t, dest, sizeof(mem), mem, bad);
                    printf("READ FROM %d value %d\n", dest, *(int *)mem);
                }
            }
            else
            {
                n->flags |= NODE_NOT_TAKEN;
            }
            break;
        }
        case O_MOV_CONST:
        {
            int dest, value;
            value = n->op.args[0];
            
            if (n->op.ptr_on_ptr)
            {
                BYTE mem[4] = {};
                BYTE bad[4] = {};
                get_memory(t, n->op.args[1] + ip, sizeof(mem), mem, bad);
                dest = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                
                printf("$MOV_CONST SET to %d value %d\n", dest, value);
            }
            else
            {
                dest = n->op.args[1] + ip;
                printf("MOV_CONST SET to %d value %d\n", dest, value);
            }

            if (dest == -1)
            {
                n->flags |= NODE_WRITE_TO_UNKNOWN;
            }
            update_write_dependence(t, n, dest, (dest == -1 ? -1 : dest + 4));
            set_region_value(t, dest, (dest == -1 ? -1 : dest + 4), 0, &value);
            clear_region_masters(t, dest, (dest == -1 ? -1 : dest + 4));
            add_region_master(t, dest, (dest == -1 ? -1 : dest + 4), n);
            break;
        }
        case O_IN:
        {
            /* simply fill all data with NULL */
            int dest, size_from;
            if (n->op.ptr_on_ptr)
            {
                BYTE mem[4] = {};
                BYTE bad[4] = {};
                
                /* get destination */
                get_memory(t, n->op.args[1] + ip, sizeof(mem), mem, bad);
                dest = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                
                /* get size_from */
                get_memory(t, n->op.args[2] + ip, sizeof(mem), mem, bad);
                size_from = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                
                printf("$IN to %d of size from %d\n", dest, size_from);
            }
            else
            {
                dest = n->op.args[1] + ip;
                size_from = n->op.args[2] + ip;
                printf("IN to %d of size from %d\n", dest, size_from);
            }

            /* try to read size */
            int size = -1;
            if (size_from != -1)
            {
                BYTE mem[4] = {};
                BYTE bad[4] = {};
                get_memory(t, size_from, sizeof(mem), mem, bad);
                size = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
            }


            if (dest == -1)
            {
            n->flags |= NODE_WRITE_TO_UNKNOWN;
            }
            update_write_dependence(t, n, dest, (dest == -1 ? -1 : dest + size));
            set_region_value(t, dest, (dest == -1 || size == -1 ? -1 : dest + size), 0, NULL);
            clear_region_masters(t, dest, (dest == -1 || size == -1 ? -1 : dest + size));
            add_region_master(t, dest, (dest == -1 || size == -1 ? -1 : dest + size), n);
            break;
        }
        case O_MOV:
        case O_INC:
        case O_DEC:
        case O_NEG:
        case O_INV:
        {
            int dest, src, size_from;
            if (n->op.ptr_on_ptr)
            {
                BYTE mem[4] = {};
                BYTE bad[4] = {};
                
                /* get destination */
                get_memory(t, n->op.args[0] + ip, sizeof(mem), mem, bad);
                dest = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                
                /* get source */
                get_memory(t, n->op.args[1] + ip, sizeof(mem), mem, bad);
                src = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                
                /* get size_from */
                get_memory(t, n->op.args[2] + ip, sizeof(mem), mem, bad);
                size_from = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                
                printf("$MOV SET to %d from %d of size from %d\n", dest, src, size_from);
            }
            else
            {
                dest = n->op.args[0] + ip;
                src = n->op.args[1] + ip;
                size_from = n->op.args[2] + ip;
                printf("MOV SET to %d from %d of size from %d\n", dest, src, size_from);
            }

            /* try to read size */
            int size = -1;
            if (size_from != -1)
            {
                BYTE mem[4] = {};
                BYTE bad[4] = {};
                get_memory(t, size_from, sizeof(mem), mem, bad);
                size = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
            }

            if (size == -1)
            {
                src = -1;
            }

            if (src == -1 || size == -1)
            {
                printf("src or size is unpredictable\n");
                if (dest == -1)
                {
                    n->flags |= NODE_WRITE_TO_UNKNOWN;
                }
                update_write_dependence(t, n, dest, (dest == -1 ? -1 : dest + size));
                set_region_value(t, dest, (dest == -1 || size == -1 ? -1 : dest + size), 0, NULL);
                clear_region_masters(t, dest, (dest == -1 || size == -1 ? -1 : dest + size));
                add_region_master(t, dest, (dest == -1 || size == -1 ? -1 : dest + size), n);
            }
            else
            {
                BYTE *mem = malloc(size);
                BYTE *bad = malloc(size);

                get_memory(t, src, size, mem, bad);
                
                /* if this is move */
                if (n->op.code == O_MOV)
                {
                    if (dest == -1)
                    {
                        n->flags |= NODE_WRITE_TO_UNKNOWN;
                        update_write_dependence(t, n, -1, -1);
                        set_region_value(t, -1, -1, 0, NULL);
                        clear_region_masters(t, -1, -1);
                        add_region_master(t, -1, -1, n);
                    }
                    else
                    {
                        update_write_dependence(t, n, dest, dest + size);
                        int prev_id = 0;
                        for (int i = 0; i <= size; ++i)
                        {
                            if (i == size || (bad[i] == 0) != (bad[i - 1] == 0))
                            {
                                /* set region */
                                if (bad[prev_id] != 0)
                                {
                                    set_region_value(t, dest + prev_id, dest + i, 0, NULL);
                                    clear_region_masters(t, dest + prev_id, dest + i);
                                    add_region_master(t, dest + prev_id, dest + i, n);
                                }
                                else
                                {
                                    set_region_value(t, dest + prev_id, dest + i, 0, mem + prev_id);
                                    clear_region_masters(t, dest + prev_id, dest + i);
                                    add_region_master(t, dest + prev_id, dest + i, n);
                                }
                                prev_id = i;
                            }
                        }    
                    }
                }
                else
                {
                    if (dest == -1)
                    {
                        n->flags |= NODE_WRITE_TO_UNKNOWN;
                    }
                    if (is_corrupted(bad, size))
                    {
                        /* so all result is corrupted */
                        update_write_dependence(t, n, dest, (dest == -1 ? -1 : dest + size));
                        set_region_value(t, dest, (dest == -1 ? -1 : dest + size), 0, NULL);
                        clear_region_masters(t, dest, (dest == -1 ? -1 : dest + size));
                        add_region_master(t, dest, (dest == -1 ? -1 : dest + size), n);
                    }
                    else
                    {
                        /* predict result */
                        printf("FOR NOW PREDICTION IS DISABLED (TODO: COPY CODE)\n");
                        // TODO: COPY CODE
                        update_write_dependence(t, n, dest, (dest == -1 ? -1 : dest + size));
                        set_region_value(t, dest, (dest == -1 ? -1 : dest + size), 0, NULL);
                        clear_region_masters(t, dest, (dest == -1 ? -1 : dest + size));
                        add_region_master(t, dest, (dest == -1 ? -1 : dest + size), n);
                    }
                }
                
                free(mem);
                free(bad);
            }
            break;
        }
        case O_ALL:
        case O_ANY:
        case O_LT:
        {
            int dest, src, size_from;
            if (n->op.ptr_on_ptr)
            {
                BYTE mem[4] = {};
                BYTE bad[4] = {};
                
                /* get destination */
                get_memory(t, n->op.args[0] + ip, sizeof(mem), mem, bad);
                dest = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                
                /* get source */
                get_memory(t, n->op.args[1] + ip, sizeof(mem), mem, bad);
                src = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                
                /* get size_from */
                get_memory(t, n->op.args[2] + ip, sizeof(mem), mem, bad);
                size_from = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                
                printf("$ALL/ANY SET to %d from %d of size from %d\n", dest, src, size_from);
            }
            else
            {
                dest = n->op.args[0] + ip;
                src = n->op.args[1] + ip;
                size_from = n->op.args[2] + ip;
                printf("ALL/ANY SET to %d from %d of size from %d\n", dest, src, size_from);
            }

            /* try to read size */
            int size = -1;
            if (size_from != -1)
            {
                BYTE mem[4] = {};
                BYTE bad[4] = {};
                get_memory(t, size_from, sizeof(mem), mem, bad);
                size = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
            }

            if (size == -1)
            {
                src = -1;
            }

            if (dest == -1 || src == -1 || size == -1)
            {
                printf("src or size is unpredictable\n");
                if (dest == -1)
                {
                    n->flags |= NODE_WRITE_TO_UNKNOWN;
                }
                update_write_dependence(t, n, dest, (dest == -1 ? -1 : dest + 4));
                set_region_value(t, dest, (dest == -1 || size == -1 ? -1 : dest + 4), 0, NULL);
                clear_region_masters(t, dest, (dest == -1 || size == -1 ? -1 : dest + 4));
                add_region_master(t, dest, (dest == -1 || size == -1 ? -1 : dest + 4), n);
            }
            else
            {
                BYTE *mem = malloc(size);
                BYTE *bad = malloc(size);

                get_memory(t, src, size, mem, bad);
                
                if (is_corrupted(bad, size))
                {
                    /* so all result is corrupted */
                    update_write_dependence(t, n, dest, dest + 4);
                    set_region_value(t, dest, dest + 4, 0, NULL);
                    clear_region_masters(t, dest, dest + 4);
                    add_region_master(t, dest, dest + 4, n);
                }
                else
                {
                    /* predict result */
                    printf("FOR NOW PREDICTION IS DISABLED (TODO: COPY CODE)\n");
                    // TODO: COPY CODE
                    update_write_dependence(t, n, dest, dest + 4);
                    set_region_value(t, dest, dest + 4, 0, NULL);
                    clear_region_masters(t, dest, dest + 4);
                    add_region_master(t, dest, dest + 4, n);
                }
                
                free(mem);
                free(bad);
            }
            break;
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
            int dest, src1, src2, size_from;
            if (n->op.ptr_on_ptr)
            {
                BYTE mem[4] = {};
                BYTE bad[4] = {};
                
                /* get destination */
                get_memory(t, n->op.args[0] + ip, sizeof(mem), mem, bad);
                dest = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                
                /* get source */
                get_memory(t, n->op.args[1] + ip, sizeof(mem), mem, bad);
                src1 = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                get_memory(t, n->op.args[2] + ip, sizeof(mem), mem, bad);
                src2 = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                
                /* get size_from */
                get_memory(t, n->op.args[3] + ip, sizeof(mem), mem, bad);
                size_from = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
                
                printf("$ADDSUB SET to %d from %d and %d of size from %d\n", dest, src1, src2, size_from);
            }
            else
            {
                dest = n->op.args[0] + ip;
                src1 = n->op.args[1] + ip;
                src2 = n->op.args[2] + ip;
                size_from = n->op.args[3] + ip;
                printf("ADDSUB SET to %d from %d and %d of size from %d\n", dest, src1, src2, size_from);
            }

            /* try to read size */
            int size = -1;
            if (size_from != -1)
            {
                BYTE mem[4] = {};
                BYTE bad[4] = {};
                get_memory(t, size_from, sizeof(mem), mem, bad);
                size = (is_corrupted(bad, 4) ? -1 : *(int *)mem);
            }

            if (size == -1)
            {
                src1 = -1;
                src2 = -1;
            }

            if (dest == -1 || src1 == -1 || src2 == -1 || size == -1)
            {
                printf("src or size is unpredictable\n");
                if (dest == -1)
                {
                    n->flags |= NODE_WRITE_TO_UNKNOWN;
                }
                update_write_dependence(t, n, dest, (dest == -1 || size == -1 ? -1 : dest + size));
                set_region_value(t, dest, (dest == -1 || size == -1 ? -1 : dest + size), 0, NULL);
                clear_region_masters(t, dest, (dest == -1 || size == -1 ? -1 : dest + size));
                add_region_master(t, dest, (dest == -1 || size == -1 ? -1 : dest + size), n);
            }
            else
            {
                BYTE *mem1 = malloc(size);
                BYTE *bad1 = malloc(size);
                BYTE *mem2 = malloc(size);
                BYTE *bad2 = malloc(size);

                get_memory(t, src1, size, mem1, bad1);
                get_memory(t, src2, size, mem2, bad2);
                
                if (is_corrupted(bad1, size) || is_corrupted(bad2, size))
                {
                    /* so all result is corrupted */
                    update_write_dependence(t, n, dest, dest + size);
                    set_region_value(t, dest, dest + size, 0, NULL);
                    clear_region_masters(t, dest, dest + size);
                    add_region_master(t, dest, dest + size, n);
                }
                else
                {
                    /* predict result */
                    printf("FOR NOW PREDICTION IS DISABLED (TODO: COPY CODE)\n");
                    // TODO: COPY CODE
                    update_write_dependence(t, n, dest, dest + size);
                    set_region_value(t, dest, dest + size, 0, NULL);
                    clear_region_masters(t, dest, dest + size);
                    add_region_master(t, dest, dest + size, n);
                }
                
                free(mem1);
                free(bad1);
                free(mem2);
                free(bad2);
            }
            break;
        }
        case O_INT:
            printf("Optimization of INT nodes are unsupported. Error\n");
            abort();
        case 0x7F:
            /* STOP_EXECUTION */
            return -1;
        default:
            abort();
    }

    int res_ip = get_ip(t);
    if (res_ip != ip + n->op.size)
    {
        n->flags |= NODE_CHANGE_FLOW;
    }
    return res_ip;
}



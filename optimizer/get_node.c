#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



struct node *get_node(struct tree *t, int ip)
{
    /* find node in parsed nodes? */
    for (int i = 0; i < t->optimizer->nodes_len; ++i)
    {
        if (t->optimizer->nodes[i].op_address == ip)
        {
            printf("This is node %p\n", t->optimizer->nodes + i);
            return t->optimizer->nodes + i;
        }
    }
    /* else - create new node without any deps and childs */
    /* try to load instruction from IP */
    BYTE opcode;
    {
        BYTE mem[1];
        BYTE bad[1];
        get_memory(t, ip, sizeof(mem), mem, bad);
        if (bad[0] != 0)
        {
            printf("Error: find maybe corrupted instruction at %d\n", ip);
            /* print info about page */
            int page = find_region(t, ip);
            printf("Page %d: is_zero: %d, value: %p, deps_base: %p, restrict: %d\n", page,
                                                                                     t->regions[page].is_zero,
                                                                                     t->regions[page].value,
                                                                                     t->regions[page].deps,
                                                                                     t->regions[page].is_restrict);
            abort();
        }
        opcode = mem[0];
        printf("Opcode value: %02X\n", mem[0]);
    }
    printf("Creaing new node starting from %d\n", ip);
    int len = decode_instruction_length(&opcode);
    printf("INSTRUCTION LENGTH: %d\n", len);
    /* read arguments, and think what can happen: */
    const struct command *cmd = NULL;
    for (int i = 0; i < (int)ARRAYLEN(native_commands); ++i)
    {
        if (native_commands[i].code == ((opcode) & (~ARG_PTR_ON_PTR)))
        {
            cmd = native_commands + i;
            break;
        }
    }

    if (cmd == NULL)
    {
        if (opcode == 0xFF)
        {
            /* this is HLT */
            return NULL;
        }
        printf("ERROR: UNKNOWN COMMAND WAS EXECUTED: %02X\n", opcode);
        abort();
    }
    printf("This is %s command with %d args\n", cmd->name, cmd->nargs);

    int this = t->optimizer->nodes_len++;
    printf("[And] This is node %p\n", t->optimizer->nodes + this);

    t->optimizer->nodes[this].entry_node = 0;
    t->optimizer->nodes[this].op_address = ip;
    t->optimizer->nodes[this].deps = calloc(1, sizeof(*t->optimizer->nodes[this].deps) * MAX_NODE_DEPS);
    t->optimizer->nodes[this].deps_len = 0;
    t->optimizer->nodes[this].set = calloc(1, sizeof(*t->optimizer->nodes[this].set) * MAX_NODE_DEPS);
    t->optimizer->nodes[this].set_len = 0;
    t->optimizer->nodes[this].childs = calloc(1, sizeof(*t->optimizer->nodes[this].childs) * MAX_CHILDS);
    t->optimizer->nodes[this].childs_len = 0;
    t->optimizer->nodes[this].args = calloc(1, sizeof(*t->optimizer->nodes[this].args) * MAX_ARG_VARIANTS);
    t->optimizer->nodes[this].args_len = 0;
    t->optimizer->nodes[this].flags = 0;
    t->optimizer->nodes[this].op.code = cmd->code;
    t->optimizer->nodes[this].op.nargs = cmd->nargs;
    t->optimizer->nodes[this].op.name = cmd->name;
    t->optimizer->nodes[this].op.size = len;
    t->optimizer->nodes[this].op.ptr_on_ptr = -!!(opcode & ARG_PTR_ON_PTR);
    t->optimizer->nodes[this].op.constant = cmd->const_first_argument;
    {
        BYTE mem[32];
        BYTE bad[32];
        get_memory(t, ip + 1, sizeof(*t->optimizer->nodes[this].op.args) * cmd->nargs, mem, bad);
        
        for (int i = 0; i < (int)sizeof(*t->optimizer->nodes[this].op.args) * cmd->nargs; ++i)
        {
            if (bad[i] != 0)
            {
                printf("Error: code data is found to be maybe corrupted. At address %d. Cant optimize this code\n", ip + 1);
                abort();
            }
        }
        memcpy(t->optimizer->nodes[this].op.args, mem, sizeof(*t->optimizer->nodes[this].op.args) * cmd->nargs);
    }

    return t->optimizer->nodes + this;
}



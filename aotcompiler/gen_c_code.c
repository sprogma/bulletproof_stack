#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include "assert.h"

#include "../optimizer/tree.h"
#include "../utils/assembler.h"
#include "aot.h"

#define PUSH_STRING(...) fprintf(f, __VA_ARGS__)


struct node *used[1024];
int          used_len;

int is_used(struct node *n)
{
    for (int i = 0; i < used_len; ++i)
    {
        if (used[i] == n)
        {
            return 1;
        }
    }
    return 0;
}

void add_used(struct node *n)
{
    if (!is_used(n))
    {
        used[used_len++] = n;
    }
}


#define FUNCTION3ARGS(fn_name) \
    if (n->op.ptr_on_ptr) \
    { \
        PUSH_STRING("    mov ecx, DWORD PTR [memory + %u]\n", n->op.args[0] + n->op_address); \
        PUSH_STRING("    lea rcx, [memory + ecx]\n"); \
        PUSH_STRING("    mov edx, DWORD PTR [memory + %u]\n", n->op.args[1] + n->op_address); \
        PUSH_STRING("    lea rdx, [memory + edx]\n"); \
        PUSH_STRING("    mov r8d, DWORD PTR [memory + %u]\n", n->op.args[2] + n->op_address); \
        PUSH_STRING("    mov r8d, DWORD PTR [memory + r8d]\n"); \
        PUSH_STRING("    call %s\n", fn_name); \
    } \
    else \
    { \
        /* TODO: optimizations */ \
        PUSH_STRING("    lea rcx, [memory + %u]\n", n->op.args[0] + n->op_address); \
        PUSH_STRING("    lea rdx, [memory + %u]\n", n->op.args[1] + n->op_address); \
        PUSH_STRING("    mov r8d, DWORD PTR [memory + %u]\n", n->op.args[2] + n->op_address); \
        PUSH_STRING("    call %s\n", fn_name); \
    }


#define FUNCTION4ARGS(fn_name) \
    if (n->op.ptr_on_ptr) \
    { \
        PUSH_STRING("    mov ecx, DWORD PTR [memory + %u]\n", n->op.args[0] + n->op_address); \
        PUSH_STRING("    lea rcx, [memory + ecx]\n"); \
        PUSH_STRING("    mov edx, DWORD PTR [memory + %u]\n", n->op.args[1] + n->op_address); \
        PUSH_STRING("    lea rdx, [memory + edx]\n"); \
        PUSH_STRING("    mov r8d, DWORD PTR [memory + %u]\n", n->op.args[3] + n->op_address); \
        PUSH_STRING("    mov r8d, DWORD PTR [memory + r8d]\n"); \
        PUSH_STRING("    call memmove\n"); \
        PUSH_STRING("    mov ecx, DWORD PTR [memory + %u]\n", n->op.args[0] + n->op_address); \
        PUSH_STRING("    lea rcx, [memory + ecx]\n"); \
        PUSH_STRING("    mov edx, DWORD PTR [memory + %u]\n", n->op.args[2] + n->op_address); \
        PUSH_STRING("    lea rdx, [memory + edx]\n"); \
        PUSH_STRING("    mov r8d, DWORD PTR [memory + %u]\n", n->op.args[3] + n->op_address); \
        PUSH_STRING("    mov r8d, DWORD PTR [memory + r8d]\n"); \
        PUSH_STRING("    call %s\n", fn_name); \
    } \
    else \
    { \
        /* TODO: optimizations */ \
        PUSH_STRING("    lea rcx, [memory + %u]\n", n->op.args[0] + n->op_address); \
        PUSH_STRING("    lea rdx, [memory + %u]\n", n->op.args[1] + n->op_address); \
        PUSH_STRING("    mov r8d, DWORD PTR [memory + %u]\n", n->op.args[3] + n->op_address); \
        PUSH_STRING("    call memmove\n"); \
        PUSH_STRING("    lea rcx, [memory + %u]\n", n->op.args[0] + n->op_address); \
        PUSH_STRING("    lea rdx, [memory + %u]\n", n->op.args[2] + n->op_address); \
        PUSH_STRING("    mov r8d, DWORD PTR [memory + %u]\n", n->op.args[3] + n->op_address); \
        PUSH_STRING("    call %s\n", fn_name); \
    }


struct node * build_node(FILE *f, struct optimizer *o, struct node *n)
{
    (void)o;

    add_used(n);

    PUSH_STRING("node_%u:\n", n->op_address);

    /* 1. if instruction can read from zero, than update it in memory to current address */
    if (FLAG(n->flags, NODE_CHANGE_FLOW))
    {
        PUSH_STRING("    mov DWORD PTR memory, %u\n", n->op_address);
    }
    else
    {
        for (int d = 0; d < n->deps_len; ++d)
        {
            if (n->deps[d].start == 0)
            {
                /* found */
                PUSH_STRING("    mov DWORD PTR memory, %u\n", n->op_address);
                break;
            }
        }
    }

    /* 2. compile instruction */
    switch (n->op.code)
    {
        case O_NOP:
            {
                PUSH_STRING("    nop\n");
            }
            break;
        case O_INT:
            {
                PUSH_STRING("    nop ; not implemented yet.\n");
                printf("ERROR: command INT not implemented in AOT compiler\n");
            }
            break;
        case O_MOV_CONST:
            {
                if (n->op.ptr_on_ptr)
                {
                    if (n->args_len == 1 && n->args[0].ptr_on_ptr[1].mem != NULL)
                    {
                        int address = *(int *)n->args[0].ptr_on_ptr[1].mem;
                        PUSH_STRING("    mov DWORD PTR [memory + %u], %u\n", address, n->op.args[0]);
                    }
                    else
                    {
                        PUSH_STRING("    mov eax, DWORD PTR [memory + %u]\n", n->op.args[1] + n->op_address);
                        PUSH_STRING("    mov DWORD PTR [memory + rax], %u\n", n->op.args[0]);
                    }
                }
                else
                {
                    PUSH_STRING("    mov DWORD PTR [memory + %d], %u\n", n->op.args[1] + n->op_address, n->op.args[0]);
                }
            }
            break;
        case O_LEA:
            {
                if (n->op.ptr_on_ptr)
                {
                    if (n->args_len == 1 && n->args[0].ptr_on_ptr[0].mem != NULL)
                    {
                        int address = *(int *)n->args[0].ptr_on_ptr[0].mem;
                        PUSH_STRING("    mov DWORD PTR [memory + %u], %u\n", address, n->op.args[1] + n->op_address);
                    }
                    else
                    {
                        PUSH_STRING("    mov eax, DWORD PTR [memory + %u]\n", n->op.args[0] + n->op_address);
                        PUSH_STRING("    mov DWORD PTR [memory + rax], %u\n", n->op.args[1] + n->op_address);
                    }
                }
                else
                {
                    PUSH_STRING("    mov DWORD PTR [memory + %d], %u\n", n->op.args[0] + n->op_address, n->op.args[1] + n->op_address);
                }
            }
            break;
        case O_MOV:
            {
                if (n->op.ptr_on_ptr)
                {
                    /* TODO: more optimizations here [more branches / variants] */
                    if (n->args_len == 1 && n->args[0].ptr_on_ptr[0].mem != NULL)
                    {
                        int ptr = *(int *)n->args[0].ptr_on_ptr[0].mem;
                        PUSH_STRING("    lea rcx, [memory + %u]\n", ptr);
                    }
                    else
                    {
                        PUSH_STRING("    mov ecx, DWORD PTR [memory + %u]\n", n->op.args[0] + n->op_address);
                        PUSH_STRING("    lea rcx, [memory + rcx]\n");
                    }
                    if (n->args_len == 1 && n->args[0].ptr_on_ptr[1].mem != NULL)
                    {
                        int ptr = *(int *)n->args[0].ptr_on_ptr[1].mem;
                        PUSH_STRING("    lea rcx, [memory + %u]\n", ptr);
                    }
                    else
                    {
                        PUSH_STRING("    mov edx, DWORD PTR [memory + %u]\n", n->op.args[1] + n->op_address);
                        PUSH_STRING("    lea rdx, [memory + rcx]\n");
                    }
                    if (n->args_len == 1 && n->args[0].ptr_on_ptr[2].mem != NULL)
                    {
                        if (n->args[0].args[2].mem != NULL)
                        {
                            int count = *(int *)n->args[0].args[2].mem;
                            PUSH_STRING("    mov r8, %u\n", count);
                        }
                        else
                        {
                            int ptr = *(int *)n->args[0].ptr_on_ptr[2].mem;
                            PUSH_STRING("    mov r8d, DWORD PTR [memory + %u]\n", ptr);
                        }
                    }
                    else
                    {
                        PUSH_STRING("    mov r8d, DWORD PTR [memory + %u]\n", n->op.args[2] + n->op_address);
                        PUSH_STRING("    mov r8d, DWORD PTR [memory + r8]\n");
                    }
                    PUSH_STRING("    call memmove\n");
                }
                else
                {
                    if (n->args_len == 1 && n->args[0].args[1].mem != NULL && n->args[0].args[2].mem != NULL)
                    {
                        int count = *(int *)n->args[0].args[2].mem;
                        if (count == 4)
                        {
                            int value = *(int *)n->args[0].args[1].mem;
                            PUSH_STRING("    mov DWORD PTR [memory + %u], %u\n", n->op.args[0] + n->op_address, value);
                        }
                        else
                        {
                            PUSH_STRING("    lea rcx, [memory + %u]\n", n->op.args[0] + n->op_address);
                            PUSH_STRING("    lea rdx, [memory + %u]\n", n->op.args[1] + n->op_address);
                            PUSH_STRING("    mov r8, %u\n", count);
                            PUSH_STRING("    call memmove\n");
                        }
                    }
                    else
                    {
                        PUSH_STRING("    lea rcx, [memory + %u]\n", n->op.args[0] + n->op_address);
                        PUSH_STRING("    lea rdx, [memory + %u]\n", n->op.args[1] + n->op_address);
                        PUSH_STRING("    mov r8d, DWORD PTR [memory + %u]\n", n->op.args[2] + n->op_address);
                        PUSH_STRING("    call memmove\n");
                    }
                }
            }
            break;
        case O_INV:
            {
                FUNCTION3ARGS("large_integer_inv")
            }
            break;
        case O_NEG:
            {
                FUNCTION3ARGS("large_integer_neg")
            }
            break;
        case O_INC:
            {
                FUNCTION3ARGS("large_integer_inc")
            }
            break;
        case O_DEC:
            {
                FUNCTION3ARGS("large_integer_dec")
            }
            break;
        case O_ALL:
            {
                FUNCTION3ARGS("large_integer_all")
            }
            break;
        case O_ANY:
            {
                FUNCTION3ARGS("large_integer_any")
            }
            break;
        case O_CLEA:
            {
                printf("GENERATING CLEA CODE!\n");
                if (n->op.ptr_on_ptr)
                {
                    PUSH_STRING("    mov eax, DWORD PTR [memory + %d]\n", n->op.args[0] + n->op_address);
                    PUSH_STRING("    mov eax, DWORD PTR [memory + eax]\n");
                    PUSH_STRING("    test eax, eax\n");
                    PUSH_STRING("    jz skip_node_%u\n", n->op_address);
                    if (n->args_len == 1 && n->args[0].ptr_on_ptr[1].mem != NULL)
                    {
                        int address = *(int *)n->args[0].ptr_on_ptr[1].mem;
                        PUSH_STRING("    mov DWORD PTR [memory + %u], %u\n", address, n->op.args[2] + n->op_address);
                    }
                    else
                    {
                        PUSH_STRING("    mov eax, DWORD PTR [memory + %u]\n", n->op.args[1] + n->op_address);
                        PUSH_STRING("    mov DWORD PTR [memory + rax], %u\n", n->op.args[2] + n->op_address);
                    }
                    PUSH_STRING("skip_node_%u:\n", n->op_address);
                }
                else
                {
                    PUSH_STRING("    mov eax, DWORD PTR [memory + %d]\n", n->op.args[0] + n->op_address);
                    PUSH_STRING("    test eax, eax\n");
                    PUSH_STRING("    jz skip_node_%u\n", n->op_address);
                    PUSH_STRING("    mov DWORD PTR [memory + %d], %u\n", n->op.args[1] + n->op_address, n->op.args[2] + n->op_address);
                    PUSH_STRING("skip_node_%u:\n", n->op_address);
                }
            }
            break;
        case O_IN:
            {
                PUSH_STRING("    nop\n");
            }
            break;
        case O_OUT:
            {
                if (n->op.ptr_on_ptr)
                {
                    PUSH_STRING("    mov ecx, DWORD PTR [memory + %u]\n", n->op.args[1] + n->op_address);
                    PUSH_STRING("    lea rcx, [memory + ecx]\n");
                    PUSH_STRING("    mov edx, DWORD PTR [memory + %u]\n", n->op.args[2] + n->op_address);
                    PUSH_STRING("    mov edx, DWORD PTR [memory + rdx]\n");
                    PUSH_STRING("    call out_memory\n");
                }
                else
                {
                    PUSH_STRING("    lea rcx, [memory + %u]\n", n->op.args[1] + n->op_address);
                    PUSH_STRING("    mov edx, DWORD PTR [memory + %u]\n", n->op.args[2] + n->op_address);
                    PUSH_STRING("    call out_memory\n");
                }
            }
            break;
        case O_EQ:
            {
                FUNCTION4ARGS("large_integer_eq");
            }
            break;
        case O_OR:
            {
                FUNCTION4ARGS("large_integer_or");
            }
            break;
        case O_AND:
            {
                FUNCTION4ARGS("large_integer_and");
            }
            break;
        case O_XOR:
            {
                FUNCTION4ARGS("large_integer_xor");
            }
            break;
        case O_ADD:
            {
                FUNCTION4ARGS("large_integer_add");
            }
            break;
        case O_SUB:
            {
                FUNCTION4ARGS("large_integer_sub");
            }
            break;
        case O_MUL:
            {
                FUNCTION4ARGS("large_integer_mul");
            }
            break;
        case O_DIV:
            {
                FUNCTION4ARGS("large_integer_div");
            }
            break;
        case O_CMOV:
            {
                PUSH_STRING("    nop\n");
                printf("NOT IMPLEMENTED: CMOV COMMAND\n");
                abort();
            }
            break;
        case O_LT:
            {
                if (n->op.ptr_on_ptr)
                {
                    PUSH_STRING("    mov ecx, DWORD PTR [memory + %u]\n", n->op.args[0] + n->op_address);
                    PUSH_STRING("    lea rcx, [memory + ecx]\n");
                    PUSH_STRING("    mov edx, DWORD PTR [memory + %u]\n", n->op.args[1] + n->op_address);
                    PUSH_STRING("    lea rdx, [memory + edx]\n");
                    PUSH_STRING("    mov r8d, DWORD PTR [memory + %u]\n", n->op.args[2] + n->op_address);
                    PUSH_STRING("    lea r8,  [memory + r8d]\n");
                    PUSH_STRING("    mov r9d, DWORD PTR [memory + %u]\n", n->op.args[3] + n->op_address);
                    PUSH_STRING("    mov r9d, DWORD PTR [memory + r9d]\n");
                    PUSH_STRING("    call large_integer_less\n");
                }
                else
                {
                    PUSH_STRING("    lea rcx, [memory + %u]\n", n->op.args[0] + n->op_address);
                    PUSH_STRING("    lea rdx, [memory + %u]\n", n->op.args[1] + n->op_address);
                    PUSH_STRING("    lea r8,  [memory + %u]\n", n->op.args[2] + n->op_address);
                    PUSH_STRING("    mov r9d, DWORD PTR [memory + %u]\n", n->op.args[3] + n->op_address);
                    PUSH_STRING("    call large_integer_less\n");
                }
            }
            break;
        case 0x7F:
            {
                /* STOP_EXECUTION */
                PUSH_STRING("    mov eax, 0\n");
                PUSH_STRING("    add rsp, 40\n");
                PUSH_STRING("    ret\n");
            }
            return NULL;
        default:
            {
                printf("UNKNOWN INSTRUCTION OPCODE %02X:\n", n->op.code);
                abort();
            }
    }

    printf("FLAG: %d %d\n", FLAG(n->flags, NODE_CHANGE_FLOW), n->childs_len);
    if (FLAG(n->flags, NODE_CHANGE_FLOW) && n->childs_len > 1)
    {
        /* read address from IP, and make corresponding jump */
        PUSH_STRING("    mov eax, DWORD PTR [memory]\n");
        for (int i = 1; i < n->childs_len; ++i)
        {
            PUSH_STRING("    cmp eax, %u\n", n->childs[i]->op_address);
            PUSH_STRING("    je node_%u\n", n->childs[i]->op_address);
        }
        return n->childs[0];
    }
    /* else - return first node */
    if (n->childs_len == 0)
    {
        return NULL;
    }
    return n->childs[0];
}


int build_program(FILE *f, struct optimizer *o)
{
    /* build program using generated graph */
    struct node *nodes[128];
    int          nodes_len;
    for (int i = 0; i < o->nodes_len; ++i)
    {
        struct node *n = o->nodes + i;
        if (n->entry_node)
        {
            nodes[nodes_len++] = n;
        }
    }
    while (nodes_len != 0)
    {
        nodes[0] = build_node(f, o, nodes[0]);
        if (is_used(nodes[0]))
        {
            PUSH_STRING("    jmp node_%u\n", nodes[0]->op_address);
            nodes[0] = nodes[--nodes_len];
        }
        if (nodes[0] == NULL)
        {
            nodes[0] = nodes[--nodes_len];
        }
    }
    return 0;
}


int gen_c_code(struct optimizer *o, const char *filename)
{
    FILE *f = fopen(filename, "w");

    char *source_image = malloc(1000 + 5 * o->source_size);

    {
        char *s = source_image;
        for (int i = 0; i < o->source_size; ++i)
        {
            s += sprintf(s, "%c0x%02x", (i == 0 ? ' ' : ','), o->source[i]);
        }
    }

    PUSH_STRING(R"asm_header(
.intel_syntax noprefix
.extern malloc
.global main

.section .data
.lcomm memory,67108864

image:
    .byte %s

.text
main:
    sub rsp, 40

    lea rcx, [memory + %u]
    lea rdx, [image]
    mov r8, %u
    call memcpy

)asm_header", source_image, o->entry_address, o->source_size);

    build_program(f, o);

    PUSH_STRING(R"asm_footer(

    mov eax, 0
    add rsp, 40
    ret
)asm_footer");

    fclose(f);
    return 0;
}

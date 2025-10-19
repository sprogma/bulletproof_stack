#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"


typedef unsigned char BYTE;


int find_region(struct tree *t, int ptr)
{
    int l = 0, r = t->regions_len;
    while (r - l > 1)
    {
        int m = (l + r) / 2;
        if (t->regions[m].start > ptr)
        {
            r = m;
        }
        else
        {
            l = m;
        }
    }
    if (!(t->regions[l].start <= ptr && t->regions[l].end > ptr))
    {
        printf("search for %d, found at %d : [%d %d]\n", ptr, l, t->regions[l].start, ptr);
        // *(int *)NULL = 5;
        assert(t->regions[l].start <= ptr && t->regions[l].end > ptr);
    }
    return l;
}

int insert_region(struct tree *t, int pos)
{
    memmove(t->regions + pos + 1, t->regions + pos, sizeof(*t->regions) * (t->regions_len - pos));
    t->regions_len++;
    return 0;
}

int get_memory(struct tree *t, int start, int size, BYTE *mem, BYTE *bad)
{ 
    /* fill data */   
    for (int i = start; i < start + size;)
    {
        int reg = find_region(t, i);
        // printf("bad? %p %d\n", t->regions[reg].value, t->regions[reg].is_zero);
        bad[i - start] = t->regions[reg].value == NULL && !t->regions[reg].is_zero;
        if (!bad[i - start])
        {
            // printf("get mem[%d]: region is zero:%d ptr:%p\n", i, t->regions[reg].is_zero, t->regions[reg].value);
            if (t->regions[reg].is_zero)
            {
                mem[i - start] = 0;
            }
            else
            {
                // printf("mem there: %02X\n", ((BYTE *)t->regions[reg].value)[i - t->regions[reg].start]);
                mem[i - start] = ((BYTE *)t->regions[reg].value)[i - t->regions[reg].start];
            }
        }
        //i = t->regions[reg].end;
        i = i + 1;
        assert(t->regions[reg].start != t->regions[reg].end);
    }
    return 0;
}

int add_ll_node(struct region *r, struct node *new_dep)
{
    struct ll_node *x = r->deps;
    while (x != NULL)
    {
        if (x->node == new_dep)
        {
            return 0;
        }
        x = x->next;
    }
    struct ll_node *new_ll_node = malloc(sizeof(*new_ll_node));
    new_ll_node->node = new_dep;
    new_ll_node->next = r->deps;
    r->deps = new_ll_node;
    return 0;
}

int add_ll_node_to_dep(struct dependence *d, struct node *new_dep)
{
    struct ll_node *x = d->deps;
    while (x != NULL)
    {
        if (x->node == new_dep)
        {
            return 0;
        }
        x = x->next;
    }
    struct ll_node *new_ll_node = malloc(sizeof(*new_ll_node));
    new_ll_node->node = new_dep;
    new_ll_node->next = d->deps;
    d->deps = new_ll_node;
    return 0;
}

int free_ll_node(struct ll_node *x)
{
    if (x == NULL)
    {
        return 0;
    }
    free_ll_node(x->next);
    free(x);
    return 0;
}

int check_is_equal_ll_nodes(struct ll_node *la, struct ll_node *lb)
{
    /* n^2 check: for each a from la check all b from lb */
    while (la != NULL)
    {
        struct ll_node *b = lb;
        while (b != NULL && la->node != b->node)
        {
            b = b->next;
        }
        if (b == NULL)
        {
            return 0;
        }
        la = la->next;
    }
    return 1;
}

int get_mem_slice(struct tree *t, int start, int end, int *l, int *r)
{
    /* 1. find regions */
    if (start == -1)
    {
        printf("ERROR get mem slice with start == -1\n");
        abort();
    }
    int from = find_region(t, start);
    int to = from;
    if (end == -1)
    {
        while (to < t->regions_len && t->regions[to].is_restrict == t->regions[from].is_restrict)
        {
            to++;
        }
        to--;
    }
    else
    {
        to = find_region(t, end - 1);
    }
    // printf("was [%d %d] ... [%d %d]\n", t->regions[to].start, t->regions[to].end, t->regions[from].start, t->regions[from].end);
    /* 2. split <to> on two parts */
    if (end != t->regions[to].end)
    {
        /* split region */
        insert_region(t, to);
        t->regions[to] = t->regions[to + 1];
        t->regions[to].deps = NULL;
        {
            struct ll_node *x = t->regions[to + 1].deps;
            while (x != NULL)
            {
                add_ll_node(t->regions + to, x->node);
                x = x->next;
            }
        }
        t->regions[to].end = end;
        if (t->regions[to + 1].value != NULL)
        {
            t->regions[to + 1].value += end - t->regions[to + 1].start;
        }
        t->regions[to + 1].start = end;
        // printf("[%d %d] U [%d %d]\n", t->regions[to].start, t->regions[to].end, t->regions[to + 1].start, t->regions[to + 1].end);
    }
    /* 3. split <from> on two parts */
    if (start != t->regions[from].start)
    {
        /* split region */
        insert_region(t, from);
        t->regions[from] = t->regions[from + 1];
        t->regions[from].deps = NULL;
        {
            struct ll_node *x = t->regions[from + 1].deps;
            while (x != NULL)
            {
                add_ll_node(t->regions + to, x->node);
                x = x->next;
            }
        }
        t->regions[from].end = start;
        if (t->regions[from + 1].value != NULL)
        {
            t->regions[from + 1].value += start - t->regions[from + 1].start;
        }
        t->regions[from + 1].start = start;
        // printf("[%d %d] U [%d %d]\n", t->regions[from].start, t->regions[from].end, t->regions[from + 1].start, t->regions[from + 1].end);
        from++;
        to++;
    }
    *l = from;
    *r = to;
    return 0;
}


int add_region_master(struct tree *t, int start, int end, struct node *master)
{
    
    if (end == -1)
    {
        printf("NOT IMPLEMENTED: add_region_master with end == -1\n");
        // abort();
        return 0;
    }
    if (start == -1)
    {
        printf("NOT IMPLEMENTED: add_region_master with start == -1\n");
        // abort();
        return 0;
    }

    
    int from, to;
    get_mem_slice(t, start, end, &from, &to);
    
    for (int i = from; i <= to; ++i)
    {
        add_ll_node(t->regions + i, master);
    }
    return 0;
}


int clear_region_masters(struct tree *t, int start, int end)
{

    if (end == -1)
    {
        return 0;
    }
    if (start == -1)
    {
        printf("NOT IMPLEMENTED: clear_region_masters with start == -1\n");
        // abort();
        return 0;
    }
    
    
    int from, to;
    get_mem_slice(t, start, end, &from, &to);
    
    for (int i = from; i <= to; ++i)
    {
        free_ll_node(t->regions[i].deps);
        t->regions[i].deps = NULL;
    }
    return 0;
}


int set_region_value(struct tree *t, int start, int end, int is_zero, void *value)
{
    if (end == -1)
    {
        printf("NOT IMPLEMENTED: set_region_value with end == -1\n");
        // abort();
        return 0;
    }
    
    if (start == -1)
    {
        printf("NOT IMPLEMENTED: set_region_value with start == -1\n");
        // abort();
        return 0;
    }
    
    int from, to;
    get_mem_slice(t, start, end, &from, &to);
    /* set data */
    if (is_zero)
    {
        for (int i = from; i <= to; ++i)
        {
            t->regions[i].is_zero = 1;
        }
    }
    else if (value == NULL)
    {
        for (int i = from; i <= to; ++i)
        {
            t->regions[i].is_zero = 0;
            t->regions[i].value = NULL;
        }
    }
    else
    {
        BYTE *ptr = malloc(end - start);
        memcpy(ptr, value, end - start);
        for (int i = from; i <= to; ++i)
        {
            printf("SET MEM reg[%d] PTR = %p VALUE = %d\n", i, ptr, *(int *)ptr);
            t->regions[i].is_zero = 0;
            t->regions[i].value = ptr;
            ptr += t->regions[i].end - t->regions[i].start;
        } 
    }

    return 0;
}


int set_restrict(struct tree *t, int start, int end, int is_restrict)
{
    int from, to;
    get_mem_slice(t, start, end, &from, &to);
    /* set data */
    for (int i = from; i <= to; ++i)
    {
        t->regions[i].is_restrict = is_restrict;
    }

    return 0;
}

int load_deps_ll_nodes(struct tree *t, struct dependence *deps, int deps_len)
{
    for (int i = 0; i < deps_len; ++i)
    {
        int from, to;
        get_mem_slice(t, deps[i].start, deps[i].end, &from, &to);
        /* copy all nodes */
        for (int j = from; j <= to; ++j)
        {
            struct ll_node *x = t->regions[j].deps;
            while (x != NULL)
            {
                add_ll_node_to_dep(deps + i, x->node);
                x = x->next;
            }
        }
    }
    return 0;
}

int assert_not_corrupted(BYTE *bad, int size, const char *message)
{
    for (int i = 0; i < size; ++i)
    {
        if (bad[i] != 0)
        {
            printf("%s\n", message);
            abort();
        }
    }
    return 0;
}


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


int load_code_image(struct tree *t, int load_address, const char *byte_file, const char *data_file)
{
    /* read file */
    FILE *f = fopen(byte_file, "rb");
    BYTE *x = malloc(1024 * 1024);
    BYTE *ptr = x;
    int c = 0;
    while ((c = fread(ptr, 1, 1024, f)) != 0)
    {
        ptr += c;
    }
    fclose(f);
    int total_read = ptr - x;
    printf("Read %d bytes\n", total_read);

    /* set regions */
    set_region_value(t, load_address, load_address + total_read, 0, x);
    FILE *d = fopen(data_file, "r");

    if (d == NULL)
    {
        printf("ERROR: cannot open file %s\n", data_file);
        return 1;
    }
    printf("loading data file\n");

    while (1)
    {
        BYTE c;
        int s, e;
        if (fscanf(d, "%c %d %d\n", &c, &s, &e) != 3)
        {
            break;
        }
        if (c == 'I')
        {
            /* this region is instruction, assume them aren't changed */
            set_restrict(t, s, e, t->restrict_id++);
        }
        if (c == 'D')
        {
            /* this is directive, also think that it doesn't changes */
            set_restrict(t, s, e, t->restrict_id++);
        }
    }

    printf("load end\n");
    
    return 0;
}

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

    t->optimizer->nodes[this].op_address = ip;
    t->optimizer->nodes[this].deps = NULL;
    t->optimizer->nodes[this].deps_len = 0;
    t->optimizer->nodes[this].childs = NULL;
    t->optimizer->nodes[this].childs_len = 0;
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


#define STANDART_PTR_DEPS(CNT) for (int i = 0; i < CNT; ++i) \
                               { \
                                   deps[i].start = n->op.args[0] + ip; \
                                   deps[i].end = n->op.args[0] + ip + 4; \
                                   deps[i].deps = NULL; \
                               }

int extract_deps_inner(struct tree *t, struct node *n, struct dependence *deps, int *deps_len, int ip)
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
                *deps_len = 2;
            }
            return 0;
            printf("Optimization of CLEA nodes are unsupported. Error\n");
            *deps_len = 1;
            return 1;
        }
        case O_MOV_CONST:
            *deps_len = 0; 
            if (n->op.ptr_on_ptr)
            {
                deps[0].start = n->op.args[1] + ip;
                deps[0].end = n->op.args[1] + ip + 4;
                deps[0].deps = NULL;
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

                deps[2].start = source;
                deps[2].end = (source == -1 || size == -1 ? -1 : source + size);
                deps[2].deps = NULL;
                
                *deps_len = 3;
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
                *deps_len = 2;
            }
            return 0;
        }
        case O_ANY: /* ! ANY and ALL will work another way, in process_machine, from MOV ... */
        case O_ALL: /* ! ANY and ALL will work another way, in process_machine, from MOV ... */
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

                deps[3].start = source;
                deps[3].end = (source == -1 || size == -1 ? -1 : source + size);
                deps[3].deps = NULL;
                
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

                deps[4].start = source1;
                deps[4].end = (source1 == -1 || size == -1 ? -1 : source1 + size);
                deps[4].deps = NULL;
                
                deps[5].start = source2;
                deps[5].end = (source2 == -1 || size == -1 ? -1 : source2 + size);
                deps[5].deps = NULL;
                
                *deps_len = 6;
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

int extract_deps(struct tree *t, struct node *n, struct dependence *deps, int *deps_len, int ip)
{
    extract_deps_inner(t, n, deps, deps_len, ip);
    deps[*deps_len].start = 0;
    deps[*deps_len].end = 4;
    deps[*deps_len].deps = NULL;
    (*deps_len)++;
    return 0;
}

int set_ip(struct tree *t, int entry)
{
    return set_region_value(t, 0, 4, 0, &entry);
}

int get_ip(struct tree *t)
{
    BYTE mem[4];
    BYTE bad[4];
    get_memory(t, 0, 4, mem, bad);
    assert_not_corrupted(bad, 4, "Error: IP is corrupted with unknown data");
    return *(int *)mem;
}

int copy_tree(struct tree *t1, struct tree *t2)
{
    *t2 = *t1;
    /* duplicate regions */
    t2->regions = calloc(1, sizeof(*t2->regions) * 128 * 1024);
    t2->regions_len = t1->regions_len;
    for (int i = 0; i < t1->regions_len; ++i)
    {
        t2->regions[i] = t1->regions[i];
        /* copy ll_nodes */
        t2->regions[i].deps = NULL;
        {
            struct ll_node *x = t1->regions[i].deps;
            while (x != NULL)
            {
                add_ll_node(t2->regions + i, x->node);
                x = x->next;
            }
        }
    }
    return 0;
}

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

int process_machine(struct tree *t, struct node *n, int ip)
{
    // int offset = !!(n->op.constant);
    // int count = n->op.nargs - offset;

    /* store address of next instruction */
    {
        int value = ip + n->op.size;
        set_region_value(t, 0, 4, 0, &value);
        clear_region_masters(t, 0, 4);
        add_region_master(t, 0, 4, n);
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
                /* copy machine, in state there branch isn't taken */
                /* so, as IP is already set on next position, simply */
                /* call duplicate_machine */
                duplicate_machine(t);
                /* as that machine don't taken this branch, now we think */
                /* that this branch is taken */
                key = 1;
                printf("ASSUME BRANCH TAKEN\n");
            }
            /* if key isn't <false> then complete LEA command */
            if (key)
            {
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
                set_region_value(t, dest, (dest == -1 ? -1 : dest + 4), 0, &value);
                clear_region_masters(t, dest, (dest == -1 ? -1 : dest + 4));
                add_region_master(t, dest, (dest == -1 ? -1 : dest + 4), n);
                BYTE mem[4] = {};
                BYTE bad[4] = {};
                get_memory(t, dest, sizeof(mem), mem, bad);
                printf("READ FROM %d value %d\n", dest, *(int *)mem);
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
            
            set_region_value(t, dest, (dest == -1 ? -1 : dest + 4), 0, &value);
            clear_region_masters(t, dest, (dest == -1 ? -1 : dest + 4));
            add_region_master(t, dest, (dest == -1 ? -1 : dest + 4), n);
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
                        set_region_value(t, -1, -1, 0, NULL);
                        clear_region_masters(t, -1, -1);
                        add_region_master(t, -1, -1, n);
                    }
                    else
                    {
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
                    if (is_corrupted(bad, size))
                    {
                        /* so all result is corrupted */
                        set_region_value(t, dest, (dest == -1 ? -1 : dest + size), 0, NULL);
                        clear_region_masters(t, dest, (dest == -1 ? -1 : dest + size));
                        add_region_master(t, dest, (dest == -1 ? -1 : dest + size), n);
                    }
                    else
                    {
                        /* predict result */
                        printf("FOR NOW PREDICTION IS DISABLED (TODO: COPY CODE)\n");
                        // TODO: COPY CODE
                        set_region_value(t, dest, dest + size, 0, NULL);
                        clear_region_masters(t, dest, dest + size);
                        add_region_master(t, dest, dest + size, n);
                    }
                }
                
                free(mem);
                free(bad);
            }
            return ip + n->op.size;
        }
        case O_ALL:
        case O_ANY:
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

            if (src == -1 || size == -1)
            {
                printf("src or size is unpredictable\n");
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
                    set_region_value(t, dest, dest + 4, 0, NULL);
                    clear_region_masters(t, dest, dest + 4);
                    add_region_master(t, dest, dest + 4, n);
                }
                else
                {
                    /* predict result */
                    printf("FOR NOW PREDICTION IS DISABLED (TODO: COPY CODE)\n");
                    // TODO: COPY CODE
                    set_region_value(t, dest, dest + 4, 0, NULL);
                    clear_region_masters(t, dest, dest + 4);
                    add_region_master(t, dest, dest + 4, n);
                }
                
                free(mem);
                free(bad);
            }
            return ip + n->op.size;
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

            if (src1 == -1 || src2 == -1 || size == -1)
            {
                printf("src or size is unpredictable\n");
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
                    set_region_value(t, dest, dest + size, 0, NULL);
                    clear_region_masters(t, dest, dest + size);
                    add_region_master(t, dest, dest + size, n);
                }
                else
                {
                    /* predict result */
                    printf("FOR NOW PREDICTION IS DISABLED (TODO: COPY CODE)\n");
                    // TODO: COPY CODE
                    set_region_value(t, dest, dest + size, 0, NULL);
                    clear_region_masters(t, dest, dest + size);
                    add_region_master(t, dest, dest + size, n);
                }
                
                free(mem1);
                free(bad1);
                free(mem2);
                free(bad2);
            }
            return ip + n->op.size;
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

    return get_ip(t);
}


int push_state(struct tree *t)
{
    BYTE mem[4];
    BYTE bad[4];
    get_memory(t, 0, 4, mem, bad);
    assert_not_corrupted(bad, 4, "ip is corrupted");
    int ip = *(int *)mem;
    printf("--------------------------------------------------------------- this is state %d [ip=%d]\n", t->optimizer->states_len, ip);
    copy_tree(t, t->optimizer->states + (t->optimizer->states_len++));
    return 0;
}


/* returns index of same node */
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

int is_looped(struct tree *t)
{
    if (LOOP_MODEL == IP_MATCH)
    {
        for (int j = 0; j < t->optimizer->states_len; ++j)
        {
            struct tree *t2 = t->optimizer->states + j;
            int i;
            for (i = 0; i < 4; ++i)
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
            }
            /* here, we found loop! */
            if (i == 4)
            {
                return j;
            }
        }
        return -1;
    }
    else
    {
        printf("Unknown loop model\n");
        abort();
    }
}


int parse_tree(struct tree *t)
{
    /* start main loop: parse current instruction */
    int ip = get_ip(t);
    while (1)
    {
        
        printf("Getting node at ip=%d\n", ip);
        struct node *n = get_node(t, ip);
        if (n == NULL)
        {
            printf("End execution...\n");
            return 0;
        }

        /* check - if we was visited this node before, check, */
        /* is there looping */
        if (LOOP_MODEL == FULL_MATCH)
        {
            int loop = -1;
            if ((loop = is_full_looped(t)) != -1)
            {
                printf("FULL LOOP FOUND with state %d\n", loop);
                /* as this is full match, we can end current parsing */
                return 0;
            }
        }
        else
        {
            /* here we must to do some had work, */
            /* joining two states, and continuing looping */
            /* until we get full match, but this will be */
            /* faster due to mergings */
            printf("LOOP_MODEL == IP_MATCH is unsupported for now\n");
            abort();
        }
        
        /* push state ... before processing to next one */
        push_state(t);

        /* set deps of node: see on which address it depends */
        n->deps = calloc(1, sizeof(*n->deps) * 16);
        extract_deps(t, n, n->deps, &n->deps_len, ip);
        load_deps_ll_nodes(t, n->deps, n->deps_len);

        printf("Extracted operation deps: total %d\n", n->deps_len);

        for (int i = 0; i < n->deps_len; ++i)
        {
            printf("dep[%d]\n", i);
            printf("range [%d %d]\n", n->deps[i].start, n->deps[i].end);
            struct ll_node *x = n->deps[i].deps;
            while (x != NULL)
            {
                printf(">>> node %p\n", x->node);
                x = x->next;
            }
        }

        /* process machine */
        ip = process_machine(t, n, ip);
        if (ip == -1)
        {
            printf("End execution\n");
            return 0;
        }
    }
    return 0;
}

int parse(struct optimizer *o)
{
    /* parse until there is no tree */
    while (o->queue_len > 0)
    {
        printf("<<<<<<<<<<<<<<<<<<<<<<<<<<<< PARSING TREE >>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n");
        if (parse_tree(o->queue + 0) != 0)
        {
            printf("error in analization of tree. exiting...\n");
            return 1;
        }
        /* remove first element */
        o->queue[0] = o->queue[--o->queue_len];
    }
    printf("All states analizated.\n");
    return 0;
}

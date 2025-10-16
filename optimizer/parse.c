#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"


size_t find_region(struct tree *t, size_t ptr)
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
    assert(t->regions[l].start <= ptr && t->regions[l].end > ptr);
    return l;
}

int insert_region(struct tree *t, size_t pos)
{
    memmove(t->regions + pos + sizeof(*t->regions), t->regions + pos, sizeof(*t->regions) * (t->regions_len - pos));
    return 0;
}

int get_memory(struct tree *t, size_t start, size_t size, char *mem, char *bad)
{ 
    /* fill data */   
    for (size_t i = start; i < start + size; ++i)
    {
        size_t reg = find_region(t, i);
        bad[i] = t->regions[reg].value == NULL && !t->regions[reg].is_zero;
        if (!bad[i])
        {
            if (t->regions[reg].is_zero)
            {
                mem[i] = 0;
            }
            else
            {
                mem[i] = ((char *)t->regions[reg].value)[i - t->regions[reg].start];
            }
        }
    }
    return 0;
}

int get_mem_slice(struct tree *t, size_t start, size_t end, size_t *l, size_t *r)
{
    /* 1. find regions */
    size_t from = find_region(t, start);
    size_t to = find_region(t, end - 1);
    /* 2. split <to> on two parts */
    if (end != t->regions[to].end)
    {
        /* split region */
        insert_region(t, to);
        t->regions[to] = t->regions[to + 1];
        t->regions[to].end = end;
        if (t->regions[to + 1].value != NULL)
        {
            t->regions[to + 1].value += end - t->regions[to + 1].start;
        }
        t->regions[to + 1].start = end;
    }
    /* 3. split <from> on two parts */
    if (start != t->regions[from].start)
    {
        /* split region */
        insert_region(t, from);
        t->regions[from] = t->regions[from + 1];
        t->regions[from].end = start;
        if (t->regions[from + 1].value != NULL)
        {
            t->regions[from + 1].value += start - t->regions[from + 1].start;
        }
        t->regions[from + 1].start = start;
        from++;
    }
    *l = from;
    *r = to;
    return 0;
}



int set_region_value(struct tree *t, size_t start, size_t end, size_t is_zero, void *value)
{
    size_t from, to;
    get_mem_slice(t, start, end, &from, &to);
    /* set data */
    if (is_zero)
    {
        for (size_t i = from; i < to; ++i)
        {
            t->regions[i].is_zero = 1;
        }
    }
    else if (value == NULL)
    {
        for (size_t i = from; i < to; ++i)
        {
            t->regions[i].is_zero = 0;
            t->regions[i].value = NULL;
        }
        
    }
    else
    {
        char *ptr = value;
        for (size_t i = from; i < to; ++i)
        {
            t->regions[i].is_zero = 0;
            t->regions[i].value = ptr;
            ptr += t->regions[i].end - t->regions[i].start;
        } 
    }

    return 0;
}


int set_restrict(struct tree *t, size_t start, size_t end, size_t is_restrict)
{
    size_t from, to;
    get_mem_slice(t, start, end, &from, &to);
    /* set data */
    for (size_t i = from; i < to; ++i)
    {
        t->regions[i].is_restrict = is_restrict;
    }

    return 0;
}


int load_code_image(struct tree *t, size_t load_address, char *byte_file, char *data_file)
{
    /* read file */
    FILE *f = fopen(byte_file, "rb");
    char *x = malloc(1024 * 1024);
    char *ptr = x;
    int c = 0;
    while ((c = fread(ptr, 1, 1024, f)) != 0)
    {
        ptr += c;
    }
    fclose(f);
    size_t total_read = ptr - x;
    printf("Read %zd bytes\n", total_read);

    /* set regions */
    set_region_value(t, load_address, load_address + total_read, 0, x);
    FILE *d = fopen(data_file, "r");

    while (1)
    {
        char c;
        size_t s, e;
        if (fscanf(d, "%c %zd %zd\n", &c, &s, &e) != 2)
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
    
    return 0;
}

struct node *get_node(struct tree *t, size_t ip)
{
    /* find node in parsed nodes? */
    for (size_t i = 0; i < t->nodes_len; ++i)
    {
        if (t->nodes[i].op_address == ip)
        {
            return t->nodes + i;
        }
    }
    /* else - create new node without any deps and childs */
    /* try to load instruction from IP */
    uint8_t opcode;
    {
        char mem[1];
        char bad[1];
        get_memory(t, ip, sizeof(mem), mem, bad);
        if (bad[0] != 0)
        {
            printf("Error: find maybe corrupted instruction at %zd\n", ip);
            abort();
        }
        opcode = mem[0];
    }
    printf("Creaing new node starting from %zd\n", ip);
    size_t len = decode_instruction_length(&opcode);
    printf("INSTRUCTION LENGTH: %zd\n", len);
    /* read arguments, and think what can happen: */
    const struct command *cmd = NULL;
    for (size_t i = 0; i < ARRAYLEN(native_commands); ++i)
    {
        if (native_commands[i].code == opcode)
        {
            cmd = native_commands + i;
            break;
        }
    }
    printf("This is %s command with %d args\n", cmd->name, cmd->nargs);

    size_t this = t->nodes_len++;

    t->nodes[this].op_address = ip;
    t->nodes[this].deps = NULL;
    t->nodes[this].childs = NULL;
    t->nodes[this].op.code = cmd->code;
    t->nodes[this].op.nargs = cmd->nargs;
    t->nodes[this].op.ptr_on_ptr = -!!(cmd->code & ARG_PTR_ON_PTR);
    t->nodes[this].op.constant = cmd->const_first_argument;
    {
        char mem[32];
        char bad[32];
        get_memory(t, ip + 1, sizeof(mem), mem, bad);
        
        for (size_t i = 0; i < ARRAYLEN(bad); ++i)
        {
            if (bad[i] != 0)
            {
                printf("Error: code data is found to be maybe corrupted. At address %zd. Cant optimize this code\n", ip + 1);
                abort();
            }
        }
        memcpy(t->nodes[this].op.args, mem, sizeof(*t->nodes[this].op.args) * cmd->nargs);
    }

    return t->nodes + this;
}


int extract_deps(struct tree *t, struct node *n, struct dependence *deps, size_t *deps_len, size_t ip)
{
    int offset = !!(n->op.constant);
    int count = n->op.nargs - offset;

    switch (n->op.code)
    {
        case O_LEA:
            if (n->op.ptr_on_ptr)
            {
                char mem[4] = {};
                char bad[4] = {};
                get_memory(t, n->op.args[1] + ip, sizeof(mem), mem, bad);
                if (*(int32_t *)bad == 0)
                {
                    deps[0].start = *(int32_t *)mem;
                    deps[0].end = *(int32_t *)mem + 4;
                    *deps_len = 1;
                }
                else
                {
                    printf("Warning, optimizer can't predict $LEA resulting position, all next optimizations may not lead to any results.\n");
                    deps[0].start = -1;
                    deps[0].end = -1;
                    *deps_len = 1;
                }
            }
            else
            {
                deps[0].start = n->op.args[1] + ip;
                deps[0].end = n->op.args[1] + ip + 4;
                *deps_len = 1; 
            }
            break;
        case O_CLEA:
            deps[0].start = n->op.args[1] + ip;
            deps[0].end = n->op.args[1] + ip + 4;
            *deps_len = 1;
            break;
        case O_MOV_CONST:
            deps[0].start = n->op.args[1] + ip;
            deps[0].end = n->op.args[1] + ip + 4;
            *deps_len = 1;
            return 0;
        case O_INT:
            printf("Optimization of INT nodes are unsupported. Error\n");
            return 1;
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


int parse(struct tree *t, size_t entry)
{
    /* start main loop: parse current instruction */
    size_t ip = entry;
    while (1)
    {
        printf("Getting node at ip=%zd\n", ip);
        struct node *n = get_node(t, ip);

        /* set deps of node: see on which address it depends */
        struct dependence deps[16];
        size_t deps_len = 0;
        extract_deps(t, n, deps, &deps_len, ip);

        printf("Extracted operation deps: total %zd\n", deps_len);
        
        break;
    }
    return 0;
}


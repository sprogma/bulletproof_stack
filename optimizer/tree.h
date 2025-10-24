#ifndef TREE
#define TREE


#define IP_MATCH 0
#define FULL_MATCH 1
#define LOOP_MODEL FULL_MATCH


#define MAX_STATES (1024 * 1024)
#define MAX_QUEUE 1024
#define TOTAL_MEM (1024 * 1024)
#define MAX_CHILDS 64
#define MAX_ARG_VARIANTS 64
#define MAX_NODE_DEPS 128
#define MAX_NODES (16 * 1024)
#define MAX_SOURCE_LINES (16 * 1024)

#define MAX_LOOP_FIND_BUFFER (32 * 1024)


typedef unsigned char BYTE;


#include "stdio.h"
#include "inttypes.h"


#define FLAG(storage, flag) (((storage) & (flag)) == (flag))


struct ll_node
{
    struct node *node;
    struct ll_node *next;
};

struct mem_value
{
    BYTE *mem; /* if mem == NULL, then this memory value is unknown */
    BYTE *bad;
    int size;
};

struct args_variant
{
    struct mem_value ptr_on_ptr[4];
    struct mem_value args[4];
};

struct operation
{
    int8_t code;
    const char *name;
    int ptr_on_ptr;
    /* if this instruction uses constant first argument */
    int constant;
    int nargs;
    int size;
    /* args are absolute pointers on labels */
    int32_t args[4];
};

struct dependence
{
    int start; /* if start = -1, then this dependence is absolute (from all memory) */
    int end; /* if end == -1, then this dependence is of unknown length, so it can be of any length, but from "start" */
    struct ll_node *deps;
};

struct write
{
    int start; /* if start = -1, then this dependence is absolute (from all memory) */
    int end; /* if end == -1, then this dependence is of unknown length, so it can be of any length, but from "start" */
    struct ll_node *deps; /* nodes, which we overwrited */
};

enum
{
    NODE_REACHED = 0x1,
    NODE_CHANGE_FLOW = 0x2,
    NODE_TAKEN = 0x4,
    NODE_NOT_TAKEN = 0x8,
    NODE_WRITE_TO_UNKNOWN = 0x10,
};

struct node
{
    int entry_node;
    int op_address;
    struct dependence *deps;
    int                deps_len;
    struct write *set;
    int           set_len;
    struct operation op;
    struct node **childs;
    int           childs_len;
    struct args_variant *args; /* diffrent values which we writed */
    int                  args_len;
    uint64_t flags;
};

struct region
{
    int start;
    int end;
    int is_restrict;
    int is_zero; /* if this == 1, then this region is zeroed out */
    const void *value; /* NULL if polluted */
    struct ll_node *deps;
};

struct tree
{
    struct optimizer *optimizer;
    struct region *regions;
    int            regions_len;
    int restrict_id;
};

enum source_line_type
{
    SOURCE_LINE_COMMAND,
    SOURCE_LINE_DATA,
};

struct source_line
{
    int start;
    int end;
    enum source_line_type type;
    int line;
    char *code;
};

struct optimizer
{
    int entry_address;
    BYTE *source;
    int   source_size;
    struct tree states[MAX_STATES];
    int         states_len;
    struct tree queue[MAX_QUEUE];
    int         queue_len;
    struct node *nodes;
    int          nodes_len;
    struct source_line *lines;
    uint32_t            lines_buff;
};

int find_region(struct tree *t, int ptr);

int insert_region(struct tree *t, int pos);

int get_memory(struct tree *t, int start, int size, BYTE *mem, BYTE *bad);

int add_ll_node(struct region *r, struct node *new_dep);

int add_ll_node_to_dep(struct dependence *d, struct node *new_dep);

int add_ll_node_to_set(struct write *w, struct node *new_dep);

int free_ll_node(struct ll_node *x);

int check_is_equal_ll_nodes(struct ll_node *la, struct ll_node *lb);

int get_mem_slice(struct tree *t, int start, int end, int *l, int *r);

int update_write_dependence(struct tree *t, struct node *n, int start, int end);

int add_region_master(struct tree *t, int start, int end, struct node *master);

int clear_region_masters(struct tree *t, int start, int end);

int set_region_value(struct tree *t, int start, int end, int is_zero, void *value);

int set_restrict(struct tree *t, int start, int end, int is_restrict);

int load_deps_ll_nodes(struct tree *t, struct dependence *deps, int deps_len);

int assert_not_corrupted(BYTE *bad, int size, const char *message);

int is_corrupted(BYTE *bad, int size);

uint32_t uint32_hash(uint32_t key);

int add_source_data_line(struct optimizer *o, char type, int s, int e, int line, const char *code);

int get_source_data_line(struct optimizer *o, int start, struct source_line **result);

struct node *get_node(struct tree *t, int ip);

int load_code_image(struct tree *t, int load_address, const char *byte_file, const char *data_file);

int extract_deps_inner(struct tree *t, struct node *n, struct args_variant *args, struct dependence *deps, int *deps_len, int ip);

int extract_deps(struct tree *t, struct node *n, struct dependence *deps, int *deps_len, int ip);

int set_entry(struct tree *t, int entry);

int get_ip(struct tree *t);

int copy_tree(struct tree *t1, struct tree *t2);

int duplicate_machine(struct tree *t);

int add_child(struct tree *t, struct node *n, struct node *child);

int process_machine(struct tree *t, struct node *n, int ip);

int update_node_deps(struct node *n, struct dependence *deps, int deps_len);

int push_state(struct tree *t);

int is_full_looped(struct tree *t);

int parse_tree(struct tree *t);

int parse(struct optimizer *o);

int set_cmd_arg(struct tree *t, struct args_variant *args, int id, int ptr, struct dependence dep);

int is_args_equal(struct args_variant *arg1, struct args_variant *arg2);


int gen_profile(struct optimizer *o, const char *out_file);

int optimize(struct optimizer *o, FILE *f);

#endif

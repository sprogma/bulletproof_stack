#ifndef TREE
#define TREE


#define IP_MATCH 0
#define FULL_MATCH 1
#define LOOP_MODEL FULL_MATCH


#define MAX_STATES (1024 * 1024)
#define MAX_QUEUE 1024
#define TOTAL_MEM (1024 * 1024)


#include "inttypes.h"


struct operation
{
    int8_t code;
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

struct node
{
    int op_address;
    struct node *deps;
    struct operation op;
    struct node *childs;
};

struct ll_node
{
    struct node *node;
    struct ll_node *next;
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

struct optimizer
{
    struct tree states[MAX_STATES];
    int         states_len;
    struct tree queue[MAX_QUEUE];
    int         queue_len;
    struct node *nodes;
    int          nodes_len;
};


int find_region(struct tree *t, int ptr);

int insert_region(struct tree *t, int pos);

int set_region_value(struct tree *t, int start, int end, int is_zero, void *value);

int load_code_image(struct tree *t, int load_address, const char *byte_file, const char *data_file);

int set_ip(struct tree *t, int entry);

int parse(struct optimizer *o);


#endif

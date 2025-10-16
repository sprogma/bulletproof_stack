#ifndef TREE
#define TREE


#include "inttypes.h"


struct operation
{
    int8_t code;
    size_t ptr_on_ptr;
    /* if this instruction uses constant first argument */
    size_t constant;
    size_t nargs;
    /* args are absolute pointers on labels */
    size_t args[4];
};

struct dependence
{
    int64_t start; /* if start = -1, then this dependence is absolute (from all memory) */
    int64_t end; /* if end == -1, then this dependence is of unknown length, so it can be of any length, but from "start" */
};

struct node
{
    size_t op_address;
    struct node *deps;
    struct operation op;
    struct node *childs;
};

struct region
{
    size_t start;
    size_t end;
    size_t is_restrict;
    size_t is_zero; /* if this == 1, then this region is zeroed out */
    void *value; /* NULL if polluted */
};

struct tree
{
    struct region *regions;
    size_t         regions_len;
    struct node *nodes;
    size_t       nodes_len;
    size_t restrict_id;
};


size_t find_region(struct tree *t, size_t ptr);

int insert_region(struct tree *t, size_t pos);

int set_region_value(struct tree *t, size_t start, size_t end, size_t is_zero, void *value);

int load_code_image(struct tree *t, size_t load_address, char *byte_file, char *data_file);

int parse(struct tree *t, size_t entry);


#endif

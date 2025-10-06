#ifndef COMPILER
#define COMPILER


#include "../parser/api.h"
#include "stddef.h"


#define MAX_STRUCTURES 128
#define MAX_VARIABLES 128
#define MAX_FUNCTIONS 128
#define MAX_ARGUMENTS 128
#define MAX_FIELDS 128
#define MAX_TYPES 128



/*

    SPUC ABI v1

    structures are stored packed.

    to call function by label create such memory structure before label:
    
        <arguments>
        <place for return value>
        <return address>
        label points here: .
        
    after call, read return value from <place for return value>
    <place for return value> may be zero size
    <arguments> may be zero size too.
    
*/


struct structure_t;


enum types
{
    TYPE_BYTE,
    TYPE_INT,
    TYPE_PTR,
    TYPE_STRUCT,
};


struct type_t
{
    char *keyword;
    char *name;
    enum types type;
    union {
        struct type_t *point_on;
        struct structure_t *structure;
    } data;     /* if TYPE_PTR: pointer on subtype,
                   if TYPE_STRUCT: pointer on structure_t */
};


struct variable_t
{
    char *label;
    char *name;
    struct type_t *type;
};


struct function_t
{
    char *label;
    struct type_t *ret;
    struct type_t *args[MAX_ARGUMENTS];
    size_t        args_len;
};


struct structure_field_t
{
    size_t offset;
    struct type_t *type;
    char *name;
};


struct structure_t
{
    char *name;
    struct structure_field_t fields[MAX_FIELDS];
    size_t                   fields_len;
    size_t size;
};


struct function_compile_time_t
{
    struct variable_t locals[MAX_VARIABLES];
    size_t            locals_len;
};


struct code_buffer_t
{
    char  *buffer;
    size_t len;
    size_t alloc;
};


struct compiler_instance_t
{
    struct code_buffer_t *code;
    struct code_buffer_t *vars;
    
    size_t unique_id;

    struct structure_t structures[MAX_STRUCTURES];
    size_t             structures_len;

    struct type_t types[MAX_TYPES];
    size_t        types_len;

    struct function_t functions[MAX_FUNCTIONS];
    size_t            functions_len;
};



result_t compile(struct parser_tree_t *tree, char **resulting_code);


result_t reserve_buffer(struct code_buffer_t *b, size_t size);


#endif

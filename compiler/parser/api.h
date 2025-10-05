#ifndef PARSER
#define PARSER


#include "common.h"



struct parser_tree_node_t
{
    struct parser_identifer_t *identifer;
    size_t      variant;
    /* [start-end) is half-interval.*/
    size_t start, end;
    /* next tree */
    struct parser_tree_node_t **childs;
    struct parser_tree_node_t *parent;
};


struct parser_tree_t
{
    const char *source;
    struct parser_tree_node_t *root;
    uint8_t parsed;
};


enum parser_identifer_variant_atom_type_t
{
    PARSER_ATOM_IDENTIFER,
    PARSER_ATOM_LITERAL,
    PARSER_ATOM_SPACES,
    PARSER_ATOM_C_STRING_LITERAL,
    PARSER_ATOM_C_NAME,
    PARSER_ATOM_C_INT,
    PARSER_ATOM_C_FLOAT,
};


struct parser_identifer_variant_atom_t
{
    enum parser_identifer_variant_atom_type_t type;
    union {
        char *literal;
        struct parser_identifer_t *identifer;
    } value;
};


struct parser_identifer_variant_t
{
    struct parser_identifer_variant_atom_t *atoms;
    size_t                                  atoms_length;
    size_t                                  vars_length;
};


struct parser_identifer_t
{
    char *identifer;
    struct parser_identifer_variant_t *variants;
    size_t                             variants_length;
};


struct parser_instance_options_t
{
    uint8_t compress_spaces;
};


struct parser_instance_t
{
    struct parser_instance_options_t options;
    struct parser_identifer_t *identifers;
    size_t                     identifers_length;
};




result_t parser_instance_create_from_file(struct parser_instance_t *instance, const char *grammar_file);
result_t parser_instance_print_grammar(struct parser_instance_t *instance);
result_t parser_instance_destroy(struct parser_instance_t *instance);
result_t parser_tree_create(struct parser_tree_t *tree);
result_t parser_tree_destroy(struct parser_tree_t *tree);
result_t parser_instance_parse_tree(struct parser_instance_t *instance, struct parser_tree_t *tree, const char *source_code);

#endif

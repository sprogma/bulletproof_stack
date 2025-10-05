#include "../api.h"
#include "../common.h"
#include "parse_tree_allocator.h"
#include "stdio.h"
#include "ctype.h"
#include "string.h"
#include "stdlib.h"


static char * compress_spaces(char *code)
{
    assert(code != NULL);
    
    while (isspace(*code)) { code++; }
    
    char *s = code, *start = code;
    while (*code)
    {
        if (!isspace(*code) || (s > start && !isspace(s[-1])))
        {
            *s++ = *code;
            if (isspace(s[-1]))
            {
                s[-1] = ' ';
            }
        }
        code++;
    }
    while (s > start && isspace(s[-1])) { s--; }
    *s = 0;
    
    return start;
}


static result_t remove_node(struct allocator_t *allocator, struct parser_tree_node_t *node)
{
    assert(allocator != NULL);

    if (node == NULL)
    {
        return 0;
    }

    for (size_t i = 0; i < node->identifer->variants[node->variant].vars_length; ++i)
    {    
        if (node->childs[i])
        {
            HANDLE_ERROR(remove_node(allocator, node->childs[i]));
        }
    }
    
    free(node->childs);
    allocator_destroy_node(allocator, node);
    
    return 0;
}


static result_t cut_subtree(struct allocator_t *allocator, struct parser_tree_node_t *node)
{
    assert(allocator != NULL);
    assert(node != NULL);
        
    for (size_t i = 0; i < node->identifer->variants[node->variant].vars_length; ++i)
    {
        if (node->childs[i])
        {
            HANDLE_ERROR(remove_node(allocator, node->childs[i]));
        }
        node->childs[i] = NULL;
    }
    return 0;
}



static result_t parse_recursive(struct parser_instance_t *instance, 
                                struct parser_tree_t *tree,
                                struct allocator_t *allocator,
                                struct parser_identifer_t *identifer, 
                                char *code, 
                                char *code_end, 
                                struct parser_tree_node_t **ret_node, 
                                char **token_end);


static result_t parse_recursive_atom(struct parser_instance_t *instance,
                                     struct parser_tree_t *tree,
                                     struct allocator_t *allocator,
                                     struct parser_identifer_variant_atom_t *atom, 
                                     size_t child_id, 
                                     struct parser_tree_node_t *node, 
                                     char *code, 
                                     char *code_end, 
                                     char **token_end)
{
    assert(instance != NULL);
    assert(tree != NULL);
    assert(allocator != NULL);
    assert(atom != NULL);
    assert(node != NULL);
    assert(code != NULL);
    assert(code_end != NULL);
    assert(token_end != NULL);

    switch (atom->type)
    {
        case PARSER_ATOM_IDENTIFER:
            {
                struct parser_tree_node_t *new_node;
                char *new_parsed = NULL;
                
                HANDLE_ERROR(parse_recursive(instance, tree, allocator, atom->value.identifer, code, code_end, &new_node, &new_parsed));

                if (new_parsed == NULL)
                {
                    PRINT_INFO("Atom identifer not matched.");
                    *token_end = NULL;
                    return 0;
                }
                
                PRINT_INFO("Atom identifer matched.");
                
                node->childs[child_id] = new_node;
                *token_end = new_parsed;
                return 0;
            }
        case PARSER_ATOM_LITERAL:
            {
                char *parsed = code;
                char *s = atom->value.literal;
                while (*s)
                {
                    if (*s != *parsed)
                    {
                        PRINT_INFO("Atom <%s> at %p not matched in char <%c> != <%c>", atom->value.literal, atom, *s, *parsed);
                        *token_end = NULL;
                        return 0;
                    }
                    s++;
                    parsed++;
                }
                
                *token_end = parsed;
                PRINT_INFO("Atom <%s> matched", atom->value.literal);
                return 0;
            }
        case PARSER_ATOM_SPACES:
            {
                char *parsed = code;
                while (isspace(*parsed))
                {
                    parsed++;
                }
                *token_end = parsed;
                PRINT_INFO("Atom SPACES matched");
                return 0;
            }
        case PARSER_ATOM_C_STRING_LITERAL:
            {
                char *parsed = code;
                if (*parsed != '"' && *parsed != '\'')
                {
                    PRINT_INFO("Atom <%s> at %p not matched C_STRING_LITERAL in char <%c> != \" or \'", atom->value.literal, atom, *parsed);
                    *token_end = NULL;
                    return 0;
                }
                char quote = *parsed;
                parsed++; /* skip quote */
                while (parsed < code_end && (*parsed != quote || parsed[-1] == '\\'))
                {
                    parsed++;
                }
                parsed++; /* skip quote */
                *token_end = parsed;
                PRINT_INFO("Atom C_STRING_LITERAL matched");
                return 0;
            }
        case PARSER_ATOM_C_NAME:
            {                
                char *parsed = code;
                if (isalpha(*parsed) || *parsed == '$' || *parsed == '_')
                {
                    parsed++;
                    while (isalpha(*parsed) || *parsed == '$' || *parsed == '_' || isdigit(*parsed))
                    {
                        parsed++;
                    }
                }
                if (parsed == code)
                {
                    PRINT_INFO("Atom <%s> at %p not matched C_NAME : bad character: %c", atom->value.literal, atom, *parsed);
                    *token_end = NULL;
                    return 0;
                }
                *token_end = parsed;
                PRINT_INFO("Atom C_NAME matched");
                return 0;
            }
        case PARSER_ATOM_C_INT:
            {                
                char *parsed = code;
                int sign = 0;
                if (*parsed == '+' || *parsed == '-')
                {
                    sign = 1;
                    parsed++;
                }
                if (parsed[0] == '0' && parsed[1] == 'x')
                {
                    parsed += 2;
                    while (isdigit(*parsed) || ('A' <= *parsed && *parsed <= 'F') || ('a' <= *parsed && *parsed <= 'f'))
                    {
                        parsed++;
                    }
                }
                else
                {
                    while (isdigit(*parsed))
                    {
                        parsed++;
                    }
                }
                if (parsed == code + sign)
                {
                    PRINT_INFO("Atom <%s> at %p not matched C_INT : bad character: %c", atom->value.literal, atom, *parsed);
                    *token_end = NULL;
                    return 0;
                }
                *token_end = parsed;
                PRINT_INFO("Atom C_INT matched");
                return 0;
            }
        case PARSER_ATOM_C_FLOAT:
            {
                PRINT_WARNING("ATOM TYPE C_FLOAT IS NOT SUPPORTED FOR NOW");
                *token_end = NULL;
                return 0;
            }
        default:
            PRINT_ERROR("Unknown atom type");
            return 1;
    }
}


                                        
static result_t parse_recursive_variant(struct parser_instance_t *instance, 
                                        struct parser_tree_t *tree,
                                        struct allocator_t *allocator,
                                        struct parser_identifer_variant_t *variant, 
                                        struct parser_tree_node_t *node, 
                                        char *code, 
                                        char *code_end, 
                                        char **token_end)
{
    assert(instance != NULL);
    assert(tree != NULL);
    assert(allocator != NULL);
    assert(variant != NULL);
    assert(node != NULL);
    assert(code != NULL);
    assert(code_end != NULL);
    assert(token_end != NULL);

    
    char *end = code;

    node->start = code - tree->source;

    size_t child_id = 0;
    
    for (size_t a = 0; a < variant->atoms_length; ++a)
    {
        PRINT_INFO("Before end=%p.", end);
        parse_recursive_atom(instance, tree, allocator, variant->atoms + a, child_id, node, end, code_end, &end);
        PRINT_INFO("After end=%p.", end);
        if (end == NULL)
        {
            PRINT_INFO("Not matched.");
            *token_end = NULL;
            return 0;
        }
        child_id += (variant->atoms[a].type == PARSER_ATOM_IDENTIFER);
    }

    node->end = end - tree->source;
    *token_end = end;
    
    return 0;
}



static result_t parse_recursive(struct parser_instance_t *instance,
                                struct parser_tree_t *tree,
                                struct allocator_t *allocator,
                                struct parser_identifer_t *identifer, 
                                char *code, 
                                char *code_end, 
                                struct parser_tree_node_t **ret_node, 
                                char **token_end)
{
    assert(instance != NULL);
    assert(tree != NULL);
    assert(allocator != NULL);
    assert(identifer != NULL);
    assert(code != NULL);
    assert(code_end != NULL);
    assert(ret_node != NULL);
    assert(token_end != NULL);

    PRINT_INFO("Match <%s> with <%s>[%p] [total %d variants]", identifer->identifer, code, code, (int)identifer->variants_length);

    /* try to compose identifer with code */
    char *max_parsed_end = NULL;
    struct parser_tree_node_t *max_parsed_node = NULL;
    for (size_t v = 0; v < identifer->variants_length; ++v)
    {
        PRINT_INFO("Test variant %d", (int)v);
        
        struct parser_tree_node_t *node = NULL;
        allocator_create_node(allocator, &node);
        node->identifer = identifer;
        node->variant = v;
        if (identifer->variants[v].vars_length != 0)
        {
            void *new_ptr = calloc(1, sizeof(*node->childs) * identifer->variants[v].vars_length);
            if (new_ptr == NULL)
            {
                PRINT_ERROR("No more memory");
                return 1;
            }
            memset(new_ptr, 0, sizeof(*node->childs) * identifer->variants[v].vars_length);
            node->childs = new_ptr;
        }
        
        char *parsed_end = NULL;
        PRINT_INFO("testing %d...", (int)v);
        HANDLE_ERROR(parse_recursive_variant(instance, tree, allocator, identifer->variants + v, node, code, code_end, &parsed_end));

        if (parsed_end > max_parsed_end)
        {
            /* ok, replace old node with new node */
            HANDLE_ERROR(remove_node(allocator, max_parsed_node));
            
            max_parsed_end = parsed_end;
            max_parsed_node = node;
            
            if (parsed_end == code_end)
            {
                PRINT_INFO("Parsed. Break");
                break;
            }
        }
        else
        {
            HANDLE_ERROR(remove_node(allocator, node));
        }
    }

    PRINT_INFO("Ended <%s> match at <%p>", identifer->identifer, max_parsed_end);
    *token_end = max_parsed_end;
    *ret_node = max_parsed_node;
    
    return 0;
}



result_t parser_instance_parse_tree(struct parser_instance_t *instance, struct parser_tree_t *tree, const char *source_code)
{
    assert(instance != NULL);
    assert(tree != NULL);

    struct allocator_t allocator = {};


    PRINT_INFO("Starting parser.");
    

    HANDLE_ERROR(allocator_create(&allocator));
    
    char *code = strdup(source_code);
    
    tree->source = code;
    
    HANDLE_ERROR(allocator_create_node(&allocator, &tree->root));

    /* parse source code */
    char *code_end = code + strlen(code);
    char *token_end = NULL;
    HANDLE_ERROR(parse_recursive(instance, tree, &allocator, instance->identifers + 0, code, code_end, &tree->root, &token_end));

    if (token_end < code_end)
    {
        PRINT_ERROR("Error: all source code not match Grammar starting rule. parsed first %d symbols.", (int)(token_end - code));
        HANDLE_ERROR(allocator_destroy(&allocator));
        free(code);
        return 1;
    }
    
    tree->parsed = 1; 
    
    HANDLE_ERROR(allocator_destroy(&allocator));
    PRINT_INFO("Parsing completed.");

    return 0;
}

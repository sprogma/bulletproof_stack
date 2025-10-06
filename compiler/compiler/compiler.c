#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include "assert.h"
#include "ctype.h"

#include "../parser/api.h"
#include "../parser/common.h"
#include "compiler.h"



#define ASSERT_NODE(node, text) do{if(strcmp((node)->identifer->identifer,(text))!=0){PRINT_ERROR("Found <%s> node instead of <%s> at line %d", (node)->identifer->identifer, (text), __LINE__); return 1;}}while(0)



static char *get_node_text(struct parser_tree_t *tree, struct parser_tree_node_t *node)
{
    assert(tree != NULL);
    assert(node != NULL);

    char *text = malloc(node->end - node->start + 1);
    memcpy(text, tree->source + node->start, node->end - node->start);
    text[node->end - node->start] = 0;
    return text;
}


static char *get_node_text_no_spaces(struct parser_tree_t *tree, struct parser_tree_node_t *node)
{
    assert(tree != NULL);
    assert(node != NULL);

    size_t start = node->start;
    size_t end = node->end;

    while (start < end && isspace(tree->source[start])) { start++; }
    while (start < end && isspace(tree->source[end - 1])) { end--; }

    char *text = malloc(end - start + 1);
    memcpy(text, tree->source + start, end - start);
    text[end - start] = 0;

    return text;
}

static struct type_t *get_type(struct compiler_instance_t *c, char *keyword, char *name)
{
    assert(c != NULL);
    assert(keyword != NULL);
    assert(name != NULL);

    for (size_t i = 0; i < c->types_len; ++i)
    {
        if (strcmp(c->types[i].keyword, keyword) == 0 && strcmp(c->types[i].name, name) == 0)
        {
            return c->types + i;
        }
    }

    return NULL;
}


static result_t get_type_node(struct compiler_instance_t *c, 
                              struct parser_tree_t *tree, 
                              struct parser_tree_node_t *node, 
                              struct type_t **result)
{
    assert(c != NULL);
    assert(tree != NULL);
    ASSERT_NODE(node, "type");

    struct type_t *return_type = NULL;
    
    if (node->variant == 0)
    {
        /* struct/union/enum + name */
        struct parser_tree_node_t *keyword_node = node->childs[0];
        ASSERT_NODE(keyword_node, "struct_keywords");

        struct parser_tree_node_t *name_node = node->childs[1];
        ASSERT_NODE(name_node, "name");

        char *keyword = get_node_text_no_spaces(tree, keyword_node);
        char *name = get_node_text_no_spaces(tree, name_node);

        return_type = get_type(c, keyword, name);

        free(keyword);
        free(name);
    }
    else if (node->variant == 1)
    {
        /* name */
        struct parser_tree_node_t *name_node = node->childs[0];
        ASSERT_NODE(name_node, "name");

        char *name = get_node_text_no_spaces(tree, name_node);

        return_type = get_type(c, "", name);

        free(name);
    }
    else
    {
        PRINT_ERROR("Unknown <type> node variant");
        return 1;
    }

    *result = return_type;
    return 0;
}


static result_t get_function(struct compiler_instance_t *c,
                               struct parser_tree_t *tree,
                               struct parser_tree_node_t *expression_node,
                               struct function_t **result)
{
    assert(c != NULL);
    ASSERT_NODE(expression_node, "expression_name");

    if (expression_node->variant == 0)
    {
        PRINT_ERROR("Unsupported variant of expression_name: %d", expression_node->variant);
        *result = NULL;
        return 1;
    }
    else if (expression_node->variant == 1)
    {
        PRINT_ERROR("Unsupported variant of expression_name: %d", expression_node->variant);
        *result = NULL;
        return 1;
    }
    else if (expression_node->variant == 2)
    {
        struct function_t *variable = NULL;
        char *name = get_node_text_no_spaces(tree, expression_node);
        for (size_t i = 0; i < c->functions_len; ++i)
        {
            if (strcmp(name, c->functions[i].label) == 0)
            {
                variable = c->functions + i;
                break;
            }
        }
        if (variable == NULL)
        {
            PRINT_ERROR("Cannot find variable <%s>", name);
            for (size_t i = 0; i < c->functions_len; ++i)
            {
                printf("func> %s\n", c->functions[i].label);
            }
            if (c->functions_len == 0)
            {
                printf("There is no functions at all!\n");
            }
            
            free(name);
            
            *result = NULL;
            return 1;
        }
        
        free(name);

        *result = variable;
        return 0;
    }
    else
    {
        PRINT_ERROR("Unknown variant of expression_name: %d", expression_node->variant);
        *result = NULL;
        return 1;
    }
    PRINT_ERROR("This error is mostly impossible, in get_function function type maching was wrong");
    *result = NULL;
    return 1;
}


static result_t get_variable(struct compiler_instance_t *c,
                               struct parser_tree_t *tree,
                               struct function_t *f,
                               struct function_compile_time_t *fc,
                               struct parser_tree_node_t *lvalue_node,
                               struct variable_t **result)
{
    assert(c != NULL);
    assert(f != NULL);
    assert(fc != NULL);
    ASSERT_NODE(lvalue_node, "lvalue_term");

    /* find variable to set */
    if (lvalue_node->variant == 0)
    {
        struct parser_tree_node_t *name_node = lvalue_node->childs[0];
        ASSERT_NODE(name_node, "expression_name");

        if (name_node->variant == 0)
        {
            PRINT_ERROR("Unsupported variant of expression_name: %d", name_node->variant);
            *result = NULL;
            return 1;
        }
        else if (name_node->variant == 1)
        {
            PRINT_ERROR("Unsupported variant of expression_name: %d", name_node->variant);
            *result = NULL;
            return 1;
        }
        else if (name_node->variant == 2)
        {
            struct variable_t *variable = NULL;
            char *name = get_node_text_no_spaces(tree, name_node);
            for (size_t i = 0; i < fc->locals_len; ++i)
            {
                if (strcmp(name, fc->locals[i].name) == 0)
                {
                    variable = fc->locals + i;
                    break;
                }
            }
            if (variable == NULL)
            {
                PRINT_ERROR("Cannot find variable <%s>", name);
                for (size_t i = 0; i < fc->locals_len; ++i)
                {
                    printf("var> %s\n", fc->locals[i].name);
                }
                if (fc->locals_len == 0)
                {
                    printf("There is no variables at all!\n");
                }
                free(name);
                *result = NULL;
                return 1;
            }
            free(name);

            *result = variable;
            return 0;
        }
        else
        {
            PRINT_ERROR("Unknown variant of expression_name: %d", name_node->variant);
            *result = NULL;
            return 1;
        }
    }
    else
    {
        PRINT_ERROR("Not implemented: set expression to lvalue_node for this variant: %d", lvalue_node->variant);
        *result = NULL;
        return 1;
    }

    PRINT_ERROR("This error is mostly impossible, in get_variable function type maching was wrong");
    *result = NULL;
    return 1;
}

static size_t get_type_size(struct compiler_instance_t *c, struct type_t *type)
{
    assert(c != NULL);
    assert(type != NULL);

    switch (type->type)
    {
        case TYPE_BYTE:
            return 1;
        case TYPE_INT:
            return 4;
        case TYPE_PTR:
            return 4;
        case TYPE_STRUCT:
            return type->data.structure->size;
    }

    PRINT_ERROR("Unknown variable type enum value");
    return 0;
}


result_t register_structure_field(struct compiler_instance_t *c,
                            struct parser_tree_t *tree,
                            struct structure_t *s,
                            size_t *field_offset,
                            struct parser_tree_node_t *type_node,
                            struct parser_tree_node_t *mods_node)
{
    ASSERT_NODE(type_node, "type");
    ASSERT_NODE(mods_node, "variable_declaration_mods");

    struct type_t *field_type = NULL;

    if (type_node->variant == 0)
    {
        /* struct/union/enum + name */
        struct parser_tree_node_t *keyword_node = type_node->childs[0];
        ASSERT_NODE(keyword_node, "struct_keywords");

        struct parser_tree_node_t *name_node = type_node->childs[1];
        ASSERT_NODE(name_node, "name");

        char *keyword = get_node_text_no_spaces(tree, keyword_node);
        char *name = get_node_text_no_spaces(tree, name_node);

        field_type = get_type(c, keyword, name);

        free(keyword);
        free(name);
    }
    else if (type_node->variant == 1)
    {
        /* name */
        struct parser_tree_node_t *name_node = type_node->childs[0];
        ASSERT_NODE(name_node, "name");

        char *name = get_node_text_no_spaces(tree, name_node);

        field_type = get_type(c, "", name);

        free(name);
    }
    else
    {
        PRINT_ERROR("Unknown <type> node variant");
        return 1;
    }

    if (field_type == NULL)
    {
        char *text = get_node_text_no_spaces(tree, type_node);
        PRINT_ERROR("Unknown type: %s", text);
        free(text);
        return 1;
    }

    PRINT_INFO("field type: %p : %s %s", field_type, field_type->keyword, field_type->name);

    /* decode mods_node */
    if (mods_node->variant != 5)
    {
        PRINT_ERROR("For now, any pointer/array fields are unsupported");
        return 1;
    }

    struct parser_tree_node_t *variable_name_node = mods_node->childs[0];
    ASSERT_NODE(variable_name_node, "variable_name");

    char *field_name = get_node_text_no_spaces(tree, variable_name_node);

    PRINT_INFO("field name: %s", field_name);

    s->fields[s->fields_len++] = (struct structure_field_t){
        .offset = *field_offset,
        .type = field_type,
        .name = field_name
    };
    PRINT_INFO("field set at position %d!", (int)*field_offset);

    *field_offset += get_type_size(c, field_type);

    return 0;
}



result_t register_structure(struct compiler_instance_t *c, struct parser_tree_t *tree, struct parser_tree_node_t *node)
{
    ASSERT_NODE(node, "structure");

    struct parser_tree_node_t *struct_name_node = node->childs[1];
    ASSERT_NODE(struct_name_node, "name");

    char *name = get_node_text_no_spaces(tree, struct_name_node);

    struct parser_tree_node_t *fields_node = node->childs[2];
    ASSERT_NODE(fields_node, "structure_field_many");

    PRINT_INFO("structure <%s>", name);

    /* create structure header */
    struct structure_t *this = &c->structures[c->structures_len++];
    this->name = name;
    this->fields_len = 0;

    size_t total_offset = 0;

    while (fields_node != NULL)
    {
        struct parser_tree_node_t *structure_field_node = fields_node->childs[0];
        ASSERT_NODE(structure_field_node, "structure_field");

        struct parser_tree_node_t *variables_node = structure_field_node->childs[0];
        ASSERT_NODE(variables_node, "variable_declaration");

        struct parser_tree_node_t *type_node = variables_node->childs[0];
        ASSERT_NODE(type_node, "type");

        struct parser_tree_node_t *name_node = variables_node->childs[1];
        ASSERT_NODE(name_node, "variable_declaration_mods_many");

        while (name_node != NULL)
        {
            struct parser_tree_node_t *mods_node = name_node->childs[0];
            ASSERT_NODE(mods_node, "variable_declaration_mods");

            HANDLE_ERROR(register_structure_field(c, tree, this, &total_offset, type_node, mods_node));

            if (name_node->variant == 0)
            {
                name_node = name_node->childs[1];
            }
            else
            {
                name_node = NULL;
            }
        }

        if (fields_node->variant == 0)
        {
            fields_node = fields_node->childs[1];
            ASSERT_NODE(fields_node, "structure_field_many");
        }
        else
        {
            fields_node = NULL;
        }
    }

    this->size = total_offset;

    return 0;
}





result_t compile_expression(struct compiler_instance_t *c,
                                     struct parser_tree_t *tree,
                                     struct function_t *f,
                                     struct function_compile_time_t *fc,
                                     struct parser_tree_node_t *node,
                                     char *result_label,
                                     struct type_t *result_type);





result_t compile_expr_term_expression(struct compiler_instance_t *c,
                                    struct parser_tree_t *tree,
                                    struct function_t *f,
                                    struct function_compile_time_t *fc,
                                    struct parser_tree_node_t *node,
                                    char *result_label,
                                    struct type_t *result_type)
{
    ASSERT_NODE(node, "expr_term");

    if (node->variant == 0)
    {
        struct parser_tree_node_t *node_int = node->childs[0];
        ASSERT_NODE(node_int, "int");

        char *text = get_node_text_no_spaces(tree, node_int);
        int64_t number = atoll(text);
        free(text);

        reserve_buffer(c->code, c->code->len + 128);
        c->code->len += sprintf(c->code->buffer + c->code->len, "MOV_CONST %d, %s\n", (int)number, result_label);
        return 0;
    }
    else if (node->variant == 1)
    {
        PRINT_ERROR("Not implemented: <float term> for now");
        return 1;
    }
    else if (node->variant == 2)
    {
        PRINT_ERROR("Not implemented: <string term> for now");
        return 1;
    }
    else if (node->variant == 3)
    {
        struct parser_tree_node_t *fn_call_node = node->childs[0];
        ASSERT_NODE(fn_call_node, "fn_call");

        struct parser_tree_node_t *name = fn_call_node->childs[0];
        ASSERT_NODE(name, "expression_name");

        struct parser_tree_node_t *args = fn_call_node->childs[1];
        ASSERT_NODE(args, "fn_call_arg_many");


        struct function_t *function = NULL;
        HANDLE_ERROR(get_function(c, tree, name, &function));

        if (function == NULL)
        {
            PRINT_ERROR("Not found function");
            return 1;
        }

        int arg_id = 0;

        while (args != NULL)
        {
            if (args->variant == 0)
            {   
                struct parser_tree_node_t *expr = args->childs[0];
                ASSERT_NODE(expr, "expression");
                
                args = args->childs[1];
                ASSERT_NODE(args, "fn_call_arg_many");

                char *label = calloc(1, 128);
                sprintf(label, "%s - %d", function->label, 4 + (int)get_type_size(c, f->ret) + (arg_id + 1) * 4);
                HANDLE_ERROR(compile_expression(c, tree, f, fc, expr, label, get_type(c, "", "int")));
                free(label);
                arg_id++;
            }
            else if (args->variant == 1)
            {
                struct parser_tree_node_t *expr = args->childs[0];
                ASSERT_NODE(expr, "expression");

                char *label = calloc(1, 128);
                sprintf(label, "%s - %d", function->label, 4 + (int)get_type_size(c, f->ret) + (arg_id + 1) * 4);
                HANDLE_ERROR(compile_expression(c, tree, f, fc, expr, label, get_type(c, "", "int")));
                free(label);
                arg_id++;

                args = NULL;
            }
            else if (args->variant == 2)
            {
                args = NULL;
            }
            else
            {
                PRINT_ERROR("Unknown fn_call_arg_many variant: %d", args->variant);
                return 1;
            }
        }
        
        /* 1. need to cast? */
        /* TODO: cast */

        char *call_label = calloc(1, 128);
        sprintf(call_label, "_local%zd", c->unique_id++);

        reserve_buffer(c->code, c->code->len + 128);
        c->code->len += sprintf(c->code->buffer + c->code->len, "LEA %s - 4, %s\n", function->label, call_label);
        c->code->len += sprintf(c->code->buffer + c->code->len, "$LEA %s, %s\n", "_zero", function->label);
        c->code->len += sprintf(c->code->buffer + c->code->len, "%s:\n", call_label);
        c->code->len += sprintf(c->code->buffer + c->code->len, "MOV %s, %s - %zd, %s\n", result_label, function->label, 4 + get_type_size(c, function->ret), "_size4");
        
        return 0;
    }
    else if (node->variant == 4)
    {
        struct parser_tree_node_t *lvalue_node = node->childs[0];
        ASSERT_NODE(lvalue_node, "lvalue_term");

        struct variable_t *var = NULL;
        HANDLE_ERROR(get_variable(c, tree, f, fc, lvalue_node, &var));

        /* 1. need to cast? */
        /* TODO: cast */

        reserve_buffer(c->code, c->code->len + 128);
        c->code->len += sprintf(c->code->buffer + c->code->len, "MOV %s, %s, %s\n", result_label, var->label, "_size4");

        return 0;
    }
    else if (node->variant == 5)
    {
        /* cmp_expr */
        struct parser_tree_node_t *expr_node = node->childs[0];
        ASSERT_NODE(expr_node, "expression");

        HANDLE_ERROR(compile_expression(c, tree, f, fc, expr_node, result_label, result_type));
    }
    else
    {
        PRINT_ERROR("Unknown node variant");
        return 1;
    }

    return 0;
}


result_t compile_mul_expression(struct compiler_instance_t *c,
                                    struct parser_tree_t *tree,
                                    struct function_t *f,
                                    struct function_compile_time_t *fc,
                                    struct parser_tree_node_t *node,
                                    char *result_label,
                                    struct type_t *result_type)
{
    ASSERT_NODE(node, "mul_expr");

    if (node->variant == 0)
    {
        struct parser_tree_node_t *node_1 = node->childs[0];
        struct parser_tree_node_t *node_op = node->childs[1];
        struct parser_tree_node_t *node_2 = node->childs[2];
        ASSERT_NODE(node_1, "expr_term");
        ASSERT_NODE(node_op, "expr_op_mul");
        ASSERT_NODE(node_2, "mul_expr");

        /* create local storage */
        char *local_label = calloc(1, 128);
        sprintf(local_label, "_local%zd", c->unique_id++);

        reserve_buffer(c->vars, c->vars->len + 128);
        c->vars->len += sprintf(c->vars->buffer + c->vars->len, "%s:\n", local_label);
        c->vars->len += sprintf(c->vars->buffer + c->vars->len, ".dd 0\n");


        /* build first and last childs */
        HANDLE_ERROR(compile_expr_term_expression(c, tree, f, fc, node_1, result_label, result_type));
        HANDLE_ERROR(compile_mul_expression(c, tree, f, fc, node_2, local_label, result_type));

        /* add multiplication */
        if (node_op->variant == 0)
        {
            reserve_buffer(c->code, c->code->len + 128);
            c->code->len += sprintf(c->code->buffer + c->code->len, "MUL %s, %s, %s, %s\n", result_label, result_label, local_label, "_size4");
        }
        else if (node_op->variant == 1)
        {
            reserve_buffer(c->code, c->code->len + 128);
            c->code->len += sprintf(c->code->buffer + c->code->len, "DIV %s, %s, %s, %s\n", result_label, result_label, local_label, "_size4");
        }
        else
        {
            PRINT_ERROR("Unknown add operator variant");
            return 1;
        }

        free(local_label);

        return 0;
    }
    else if (node->variant == 1)
    {
        /* cmp_expr */
        struct parser_tree_node_t *expr_node = node->childs[0];
        ASSERT_NODE(expr_node, "expr_term");

        HANDLE_ERROR(compile_expr_term_expression(c, tree, f, fc, expr_node, result_label, result_type));
    }
    else
    {
        PRINT_ERROR("Unknown node variant");
        return 1;
    }

    return 0;
}

result_t compile_block(struct compiler_instance_t *c,
                       struct parser_tree_t *tree,
                       struct function_t *f,
                       struct function_compile_time_t *fc,
                       struct parser_tree_node_t *node);

result_t compile_add_expression(struct compiler_instance_t *c,
                                    struct parser_tree_t *tree,
                                    struct function_t *f,
                                    struct function_compile_time_t *fc,
                                    struct parser_tree_node_t *node,
                                    char *result_label,
                                    struct type_t *result_type)
{
    ASSERT_NODE(node, "add_expr");

    if (node->variant == 0)
    {
        struct parser_tree_node_t *node_1 = node->childs[0];
        struct parser_tree_node_t *node_op = node->childs[1];
        struct parser_tree_node_t *node_2 = node->childs[2];
        ASSERT_NODE(node_1, "mul_expr");
        ASSERT_NODE(node_op, "expr_op_add");
        ASSERT_NODE(node_2, "add_expr");

        /* create local storage */
        char *local_label = calloc(1, 128);
        sprintf(local_label, "_local%zd", c->unique_id++);

        reserve_buffer(c->vars, c->vars->len + 128);
        c->vars->len += sprintf(c->vars->buffer + c->vars->len, "%s:\n", local_label);
        c->vars->len += sprintf(c->vars->buffer + c->vars->len, ".dd 0\n");


        /* build first and last childs */
        HANDLE_ERROR(compile_mul_expression(c, tree, f, fc, node_1, result_label, result_type));
        HANDLE_ERROR(compile_add_expression(c, tree, f, fc, node_2, local_label, result_type));

        /* add addition */
        if (node_op->variant == 0)
        {
            reserve_buffer(c->code, c->code->len + 128);
            c->code->len += sprintf(c->code->buffer + c->code->len, "ADD %s, %s, %s, %s\n", result_label, result_label, local_label, "_size4");
        }
        else if (node_op->variant == 1)
        {
            reserve_buffer(c->code, c->code->len + 128);
            c->code->len += sprintf(c->code->buffer + c->code->len, "SUB %s, %s, %s, %s\n", result_label, result_label, local_label, "_size4");
        }
        else
        {
            PRINT_ERROR("Unknown add operator variant");
            return 1;
        }

        free(local_label);

        return 0;
    }
    else if (node->variant == 1)
    {
        /* cmp_expr */
        struct parser_tree_node_t *expr_node = node->childs[0];
        ASSERT_NODE(expr_node, "mul_expr");

        HANDLE_ERROR(compile_mul_expression(c, tree, f, fc, expr_node, result_label, result_type));
    }
    else
    {
        PRINT_ERROR("Unknown node variant");
        return 1;
    }

    return 0;
}


result_t compile_compare_expression(struct compiler_instance_t *c,
                                    struct parser_tree_t *tree,
                                    struct function_t *f,
                                    struct function_compile_time_t *fc,
                                    struct parser_tree_node_t *node,
                                    char *result_label,
                                    struct type_t *result_type)
{
    ASSERT_NODE(node, "cmp_expr");

    if (node->variant == 0)
    {
        struct parser_tree_node_t *node_1 = node->childs[0];
        struct parser_tree_node_t *node_op = node->childs[1];
        struct parser_tree_node_t *node_2 = node->childs[2];
        ASSERT_NODE(node_1, "add_expr");
        ASSERT_NODE(node_op, "expr_op_cmp");
        ASSERT_NODE(node_2, "cmp_expr");

        /* create local storage */
        char *local_label = calloc(1, 128);
        sprintf(local_label, "_local%zd", c->unique_id++);

        reserve_buffer(c->vars, c->vars->len + 128);
        c->vars->len += sprintf(c->vars->buffer + c->vars->len, "%s:\n", local_label);
        c->vars->len += sprintf(c->vars->buffer + c->vars->len, ".dd 0\n");


        /* build first and last childs */
        HANDLE_ERROR(compile_add_expression(c, tree, f, fc, node_1, result_label, result_type));
        HANDLE_ERROR(compile_compare_expression(c, tree, f, fc, node_2, local_label, result_type));

        /* comparsion */
        if (node_op->variant == 0)
        {
            /* == */
            reserve_buffer(c->code, c->code->len + 128);
            c->code->len += sprintf(c->code->buffer + c->code->len, "EQ %s, %s, %s, %s\n", result_label, result_label, local_label, "_size4");
            c->code->len += sprintf(c->code->buffer + c->code->len, "ALL %s, %s, %s\n", result_label, result_label, "_size4");
        }
        else if (node_op->variant == 1)
        {
            /* != */
            reserve_buffer(c->code, c->code->len + 128);
            c->code->len += sprintf(c->code->buffer + c->code->len, "EQ %s, %s, %s, %s\n", result_label, result_label, local_label, "_size4");
            c->code->len += sprintf(c->code->buffer + c->code->len, "ALL %s, %s, %s\n", result_label, result_label, "_size4");
            c->code->len += sprintf(c->code->buffer + c->code->len, "INV %s, %s, %s\n", result_label, result_label, "_size4");
        }
        else
        {
            /* other */
            PRINT_ERROR("All other comparsions other than == and != isn't supported for now.");
            return 1;
        }

        free(local_label);

        return 0;
    }
    else if (node->variant == 1)
    {
        /* cmp_expr */
        struct parser_tree_node_t *expr_node = node->childs[0];
        ASSERT_NODE(expr_node, "add_expr");

        HANDLE_ERROR(compile_add_expression(c, tree, f, fc, expr_node, result_label, result_type));
    }
    else
    {
        PRINT_ERROR("Unknown node variant");
        return 1;
    }

    return 0;
}


result_t compile_logical_expression(struct compiler_instance_t *c,
                                    struct parser_tree_t *tree,
                                    struct function_t *f,
                                    struct function_compile_time_t *fc,
                                    struct parser_tree_node_t *node,
                                    char *result_label,
                                    struct type_t *result_type)
{
    ASSERT_NODE(node, "logic_expr");

    if (node->variant == 0)
    {
        PRINT_ERROR("Not implemented: <logical expression> for now");
        return 1;
    }
    else if (node->variant == 1)
    {
        /* cmp_expr */
        struct parser_tree_node_t *expr_node = node->childs[0];
        ASSERT_NODE(expr_node, "cmp_expr");

        HANDLE_ERROR(compile_compare_expression(c, tree, f, fc, expr_node, result_label, result_type));
    }
    else
    {
        PRINT_ERROR("Unknown node variant");
        return 1;
    }

    return 0;
}



result_t compile_expression(struct compiler_instance_t *c,
                                     struct parser_tree_t *tree,
                                     struct function_t *f,
                                     struct function_compile_time_t *fc,
                                     struct parser_tree_node_t *node,
                                     char *result_label,
                                     struct type_t *result_type)
{
    ASSERT_NODE(node, "expression");

    if (node->variant == 0)
    {
        struct parser_tree_node_t *set_expr = node->childs[0];
        ASSERT_NODE(set_expr, "set_expr");
        /* store result into given variable */
        struct parser_tree_node_t *lvalue_node = set_expr->childs[0];
        ASSERT_NODE(lvalue_node, "lvalue_term");

        struct parser_tree_node_t *expr_node = set_expr->childs[1];
        ASSERT_NODE(expr_node, "expression");

        struct variable_t *variable = NULL;

        HANDLE_ERROR(get_variable(c, tree, f, fc, lvalue_node, &variable));

        HANDLE_ERROR(compile_expression(c, tree, f, fc, expr_node, variable->label, variable->type));

        return 0;
    }
    else if (node->variant == 1)
    {
        if (result_label == NULL || result_type == NULL)
        {
            PRINT_ERROR("Compile expression without destination label, but not <set> expression. [Result of operation isn't used]");
            return 1;
        }

        /* logical expresssion */
        struct parser_tree_node_t *expr_node = node->childs[0];
        ASSERT_NODE(expr_node, "logic_expr");

        HANDLE_ERROR(compile_logical_expression(c, tree, f, fc, expr_node, result_label, result_type));
    }
    else
    {
        PRINT_ERROR("Unknown node variant");
        return 1;
    }

    return 0;
}


result_t register_function_variable_with_label(struct compiler_instance_t *c,
                                    struct parser_tree_t *tree,
                                    struct function_t *f,
                                    struct function_compile_time_t *fc,
                                    struct parser_tree_node_t *type_node,
                                    struct parser_tree_node_t *mods_node,
                                    char *label)
{
    (void)f;
    ASSERT_NODE(type_node, "type");
    ASSERT_NODE(mods_node, "variable_declaration_mods");

    struct type_t *variable_type = NULL;

    if (type_node->variant == 0)
    {
        /* struct/union/enum + name */
        struct parser_tree_node_t *keyword_node = type_node->childs[0];
        ASSERT_NODE(keyword_node, "struct_keywords");

        struct parser_tree_node_t *name_node = type_node->childs[1];
        ASSERT_NODE(name_node, "name");

        char *keyword = get_node_text_no_spaces(tree, keyword_node);
        char *name = get_node_text_no_spaces(tree, name_node);

        variable_type = get_type(c, keyword, name);

        free(keyword);
        free(name);
    }
    else if (type_node->variant == 1)
    {
        /* name */
        struct parser_tree_node_t *name_node = type_node->childs[0];
        ASSERT_NODE(name_node, "name");

        char *name = get_node_text_no_spaces(tree, name_node);

        variable_type = get_type(c, "", name);

        free(name);
    }
    else
    {
        PRINT_ERROR("Unknown <type> node variant");
        return 1;
    }

    if (variable_type == NULL)
    {
        char *text = get_node_text_no_spaces(tree, type_node);
        PRINT_ERROR("Unknown type: %s\n", text);
        free(text);
        return 1;
    }


    PRINT_INFO("varaible type: %p : %s %s", variable_type, variable_type->keyword, variable_type->name);

    /* decode mods_node */
    if (mods_node->variant != 5)
    {
        PRINT_ERROR("For now, any pointer/array variables are unsupported\n");
        return 1;
    }

    struct parser_tree_node_t *variable_name_node = mods_node->childs[0];
    ASSERT_NODE(variable_name_node, "variable_name");

    char *variable_name = get_node_text_no_spaces(tree, variable_name_node);

    PRINT_INFO("varaible name: %s", variable_name);

    char *label_name = strdup(label);

    fc->locals[fc->locals_len++] = (struct variable_t) {
        .label = label_name,
        .name = variable_name,
        .type = variable_type,
    };

    PRINT_INFO("variable <%s> created!", variable_name);

    return 0;
}


result_t register_function_variable(struct compiler_instance_t *c,
                                    struct parser_tree_t *tree,
                                    struct function_t *f,
                                    struct function_compile_time_t *fc,
                                    struct parser_tree_node_t *type_node,
                                    struct parser_tree_node_t *mods_node)
{
    ASSERT_NODE(type_node, "type");
    ASSERT_NODE(mods_node, "variable_declaration_mods");

    struct type_t *variable_type = NULL;

    if (type_node->variant == 0)
    {
        /* struct/union/enum + name */
        struct parser_tree_node_t *keyword_node = type_node->childs[0];
        ASSERT_NODE(keyword_node, "struct_keywords");

        struct parser_tree_node_t *name_node = type_node->childs[1];
        ASSERT_NODE(name_node, "name");

        char *keyword = get_node_text_no_spaces(tree, keyword_node);
        char *name = get_node_text_no_spaces(tree, name_node);

        variable_type = get_type(c, keyword, name);

        free(keyword);
        free(name);
    }
    else if (type_node->variant == 1)
    {
        /* name */
        struct parser_tree_node_t *name_node = type_node->childs[0];
        ASSERT_NODE(name_node, "name");

        char *name = get_node_text_no_spaces(tree, name_node);

        variable_type = get_type(c, "", name);

        free(name);
    }
    else
    {
        PRINT_ERROR("Unknown <type> node variant");
        return 1;
    }

    if (variable_type == NULL)
    {
        char *text = get_node_text_no_spaces(tree, type_node);
        PRINT_ERROR("Unknown type: %s\n", text);
        free(text);
        return 1;
    }


    PRINT_INFO("varaible type: %p : %s %s", variable_type, variable_type->keyword, variable_type->name);

    /* decode mods_node */
    if (mods_node->variant != 5)
    {
        PRINT_ERROR("For now, any pointer/array variables are unsupported\n");
        return 1;
    }

    struct parser_tree_node_t *variable_name_node = mods_node->childs[0];
    ASSERT_NODE(variable_name_node, "variable_name");

    char *variable_name = get_node_text_no_spaces(tree, variable_name_node);

    PRINT_INFO("varaible name: %s", variable_name);

    char *label_name = calloc(1, 64);
    sprintf(label_name, "_%s_%s", f->label, variable_name);

    reserve_buffer(c->vars, c->vars->len + 128);
    c->vars->len += sprintf(c->vars->buffer + c->vars->len, "%s:\n", label_name);
    c->vars->len += sprintf(c->vars->buffer + c->vars->len, ".dd 0\n");

    fc->locals[fc->locals_len++] = (struct variable_t) {
        .label = label_name,
        .name = variable_name,
        .type = variable_type,
    };

    PRINT_INFO("variable <%s> created!", variable_name);

    return 0;
}


result_t compile_function_statement(struct compiler_instance_t *c,
                                    struct parser_tree_t *tree,
                                    struct function_t *f,
                                    struct function_compile_time_t *fc,
                                    struct parser_tree_node_t *node)
{

    if (node->variant == 0)
    {
        PRINT_INFO("empty statement");
        return 0;
    }
    else if (node->variant == 1)
    {
        struct parser_tree_node_t *ret = node->childs[0];
        ASSERT_NODE(ret, "return_stmt");

        struct parser_tree_node_t *expr = ret->childs[0];
        ASSERT_NODE(expr, "expression");

        PRINT_INFO("return statement");

        /* need to calculate "expression" */
        char *ret_label = calloc(1, 128);
        sprintf(ret_label, "%s - %zd", f->label, 4 + get_type_size(c, f->ret));

        HANDLE_ERROR(compile_expression(c, tree, f, fc, expr, ret_label, f->ret));

        char *local_tmp1 = calloc(1, 128);
        char *local_tmp2 = calloc(1, 128);
        sprintf(local_tmp1, "_local%zd", c->unique_id++);
        sprintf(local_tmp2, "_local%zd", c->unique_id++);

        reserve_buffer(c->vars, c->vars->len + 128);
        c->vars->len += sprintf(c->vars->buffer + c->vars->len, "%s:\n", local_tmp1);
        c->vars->len += sprintf(c->vars->buffer + c->vars->len, ".dd 0\n");
        c->vars->len += sprintf(c->vars->buffer + c->vars->len, "%s:\n", local_tmp2);
        c->vars->len += sprintf(c->vars->buffer + c->vars->len, ".dd 0\n");
                
        reserve_buffer(c->code, c->code->len + 128);
        c->code->len += sprintf(c->code->buffer + c->code->len, "LEA %s, %s\n", local_tmp1, "_size4");
        c->code->len += sprintf(c->code->buffer + c->code->len, "LEA %s, %s - 4\n", local_tmp2, f->label);
        c->code->len += sprintf(c->code->buffer + c->code->len, "$MOV %s, %s, %s\n", "_zero", local_tmp2, local_tmp1);

        free(ret_label);

        return 0;
    }
    else if (node->variant == 2)
    {
        struct parser_tree_node_t *ifelse = node->childs[0];
        ASSERT_NODE(ifelse, "if_stmt");

        struct parser_tree_node_t *expr_node = ifelse->childs[0];
        ASSERT_NODE(expr_node, "expression");

        struct parser_tree_node_t *if_block = ifelse->childs[1];
        ASSERT_NODE(if_block, "block");

        struct parser_tree_node_t *else_node = ifelse->childs[2];
        ASSERT_NODE(else_node, "else_stmt");

        struct parser_tree_node_t *else_block = NULL;

        char *if_label = calloc(1, 128);
        char *end_label = calloc(1, 128);
        char *expr_label = calloc(1, 128);
        char *expr_label_ptr = calloc(1, 128);
        sprintf(if_label, "_local%zd", c->unique_id++);
        sprintf(end_label, "_local%zd", c->unique_id++);
        sprintf(expr_label, "_local%zd", c->unique_id++);
        sprintf(expr_label_ptr, "_local%zd", c->unique_id++);

        if (else_node->variant == 0)
        {
            else_block = else_node->childs[0];
            ASSERT_NODE(else_block, "block");
        }

        PRINT_INFO("if-else statement");


        /* create local storage */
        reserve_buffer(c->vars, c->vars->len + 128);
        c->vars->len += sprintf(c->vars->buffer + c->vars->len, "%s:\n", expr_label);
        c->vars->len += sprintf(c->vars->buffer + c->vars->len, ".dd 0\n");
        c->vars->len += sprintf(c->vars->buffer + c->vars->len, "%s:\n", expr_label_ptr);
        c->vars->len += sprintf(c->vars->buffer + c->vars->len, ".dd 0\n");

        /* calculate "expression into local label" */

        struct type_t *boolean = get_type(c, "", "int");
        if (boolean == NULL)
        {
            PRINT_ERROR("Error: not found type <int> [need by compiler system]");
            return 1;
        }
        HANDLE_ERROR(compile_expression(c, tree, f, fc, expr_node, expr_label, boolean));

        /* make branching */
        reserve_buffer(c->code, c->code->len + 128);
        c->code->len += sprintf(c->code->buffer + c->code->len, "LEA %s, %s\n", expr_label_ptr, expr_label);
        c->code->len += sprintf(c->code->buffer + c->code->len, "$CLEA %s, _zero, %s \n", expr_label_ptr, if_label);
        if (else_block != NULL)
        {
            HANDLE_ERROR(compile_block(c, tree, f, fc, else_block));
        }
        reserve_buffer(c->code, c->code->len + 128);
        c->code->len += sprintf(c->code->buffer + c->code->len, "$LEA _zero, %s \n", end_label);
        c->code->len += sprintf(c->code->buffer + c->code->len, "%s:\n", if_label);

        HANDLE_ERROR(compile_block(c, tree, f, fc, if_block));

        reserve_buffer(c->code, c->code->len + 128);
        c->code->len += sprintf(c->code->buffer + c->code->len, "%s:\n", end_label);

        free(if_label);
        free(end_label);
        free(expr_label);
        free(expr_label_ptr);

        return 0;
    }
    else if (node->variant == 3)
    {
        struct parser_tree_node_t *whilestmt = node->childs[0];
        ASSERT_NODE(whilestmt, "while_stmt");

        struct parser_tree_node_t *expr_node = whilestmt->childs[0];
        ASSERT_NODE(expr_node, "expression");

        struct parser_tree_node_t *body_node = whilestmt->childs[1];
        ASSERT_NODE(body_node, "block");

        char *end_label = calloc(1, 128);
        char *begin_label = calloc(1, 128);
        char *check_label = calloc(1, 128);
        char *expr_label = calloc(1, 128);
        char *expr_label_ptr = calloc(1, 128);
        sprintf(end_label, "_local%zd", c->unique_id++);
        sprintf(begin_label, "_local%zd", c->unique_id++);
        sprintf(check_label, "_local%zd", c->unique_id++);
        sprintf(expr_label, "_local%zd", c->unique_id++);
        sprintf(expr_label_ptr, "_local%zd", c->unique_id++);

        PRINT_INFO("while statement");

        /* create local storage */
        reserve_buffer(c->vars, c->vars->len + 128);
        c->vars->len += sprintf(c->vars->buffer + c->vars->len, "%s:\n", expr_label);
        c->vars->len += sprintf(c->vars->buffer + c->vars->len, ".dd 0\n");
        c->vars->len += sprintf(c->vars->buffer + c->vars->len, "%s:\n", expr_label_ptr);
        c->vars->len += sprintf(c->vars->buffer + c->vars->len, ".dd 0\n");
        
        reserve_buffer(c->code, c->code->len + 128);
        c->code->len += sprintf(c->code->buffer + c->code->len, "LEA %s, %s\n", expr_label_ptr, expr_label);

        /* calculate "expression into local label" */
        
        reserve_buffer(c->code, c->code->len + 256);
        c->code->len += sprintf(c->code->buffer + c->code->len, "%s:\n", check_label);
        
        struct type_t *boolean = get_type(c, "", "int");
        if (boolean == NULL)
        {
            PRINT_ERROR("Error: not found type <int> [need by compiler system]");
            return 1;
        }
        HANDLE_ERROR(compile_expression(c, tree, f, fc, expr_node, expr_label, boolean));

        /* check clause */
        reserve_buffer(c->code, c->code->len + 256);
        c->code->len += sprintf(c->code->buffer + c->code->len, "$CLEA %s, _zero, %s \n", expr_label_ptr, begin_label);
        c->code->len += sprintf(c->code->buffer + c->code->len, "$LEA _zero, %s\n", end_label);
        c->code->len += sprintf(c->code->buffer + c->code->len, "%s:\n", begin_label);

        HANDLE_ERROR(compile_block(c, tree, f, fc, body_node));

        reserve_buffer(c->code, c->code->len + 128);
        c->code->len += sprintf(c->code->buffer + c->code->len, "$LEA _zero, %s \n", check_label);
        c->code->len += sprintf(c->code->buffer + c->code->len, "%s:\n", end_label);

        free(end_label);
        free(begin_label);
        free(expr_label);
        free(expr_label_ptr);

        return 0;
    }
    else if (node->variant == 4)
    {
        /* for each declared variable: register it */
        struct parser_tree_node_t *declaration = node->childs[0];
        ASSERT_NODE(declaration, "variable_declaration");

        struct parser_tree_node_t *type_node = declaration->childs[0];
        ASSERT_NODE(type_node, "type");

        struct parser_tree_node_t *mods_node = declaration->childs[1];
        ASSERT_NODE(mods_node, "variable_declaration_mods_many");

        while (mods_node != NULL)
        {
            struct parser_tree_node_t *one_mods = mods_node->childs[0];
            ASSERT_NODE(one_mods, "variable_declaration_mods");

            HANDLE_ERROR(register_function_variable(c, tree, f, fc, type_node, one_mods));

            if (mods_node->variant == 0)
            {
                mods_node = mods_node->childs[1];
            }
            else
            {
                mods_node = NULL;
            }
        }

        return 0;
    }
    else if (node->variant == 5)
    {
        /* simple expression statement */
        struct parser_tree_node_t *expr_node = node->childs[0];
        ASSERT_NODE(expr_node, "expression");

        compile_expression(c, tree, f, fc, expr_node, NULL, NULL);

        return 0;
    }
    else
    {
        PRINT_ERROR("Unknown statement variant: %d", node->variant);
        return 1;
    }

    return 0;
}



result_t compile_block(struct compiler_instance_t *c,
                       struct parser_tree_t *tree,
                       struct function_t *f,
                       struct function_compile_time_t *fc,
                       struct parser_tree_node_t *node)
{
    struct parser_tree_node_t *body_statements = NULL;

    if (strcmp(node->identifer->identifer, "block") == 0)
    {
        if (node->variant == 0)
        {
            node = node->childs[0];
            ASSERT_NODE(node, "fn_block");
        }
        else if (node->variant == 1)
        {
            struct parser_tree_node_t *statement = node->childs[0];
            ASSERT_NODE(node, "statement");

            HANDLE_ERROR(compile_function_statement(c, tree, f, fc, statement));
            return 0;
        }
        else
        {
            PRINT_ERROR("Error: unknown block variant: %d", node->variant);
            return 1;
        }
    }

    if (strcmp(node->identifer->identifer, "fn_block") == 0)
    {
        if (node->variant == 0)
        {
            body_statements = node->childs[0];
        }
        else if (node->variant == 1)
        {
            reserve_buffer(c->code, c->code->len + 128);
            c->code->len += sprintf(c->code->buffer + c->code->len, "NOP\n");
            return 0;
        }
        else
        {
            PRINT_ERROR("Error: unknown fn_block variant: %d", node->variant);
            return 1;
        }
    }

    if (body_statements == NULL)
    {
        PRINT_ERROR("Error: compile_block have unsupported node type: %s", node->identifer->identifer);
        return 1;
    }

    /* if this is many_statements [case with one statement was handled in upper code] */

    ASSERT_NODE(body_statements, "many_statements");

    while (body_statements != NULL)
    {
        if (body_statements->variant == 0)
        {
            struct parser_tree_node_t *statement = body_statements->childs[0];
            ASSERT_NODE(statement, "statement");

            /* build statement */
            HANDLE_ERROR(compile_function_statement(c, tree, f, fc, statement));

            body_statements = body_statements->childs[1];
            ASSERT_NODE(body_statements, "many_statements");
        }
        else
        {
            body_statements = NULL;
        }
   }

   return 0;
}


result_t compile_function(struct compiler_instance_t *c, struct parser_tree_t *tree, struct parser_tree_node_t *node)
{
    assert(c != NULL);
    assert(tree != NULL);
    assert(node != NULL);

    ASSERT_NODE(node, "function");

    PRINT_INFO("function!");

    struct function_t *f = &c->functions[c->functions_len++];
    struct function_compile_time_t fc = {};

    struct parser_tree_node_t *declaration = node->childs[0];
    ASSERT_NODE(declaration, "variable_declaration");

    struct parser_tree_node_t *body = node->childs[1];
    ASSERT_NODE(body, "fn_block");

    struct parser_tree_node_t *function_args = NULL;

    /* read return type */
    {

        struct parser_tree_node_t *type_node = declaration->childs[0];
        ASSERT_NODE(type_node, "type");

        struct parser_tree_node_t *many_mods_node = declaration->childs[1];
        ASSERT_NODE(many_mods_node, "variable_declaration_mods_many");

        struct parser_tree_node_t *mods_node = many_mods_node->childs[0];
        ASSERT_NODE(mods_node, "variable_declaration_mods");


        struct type_t *return_type = NULL;
        HANDLE_ERROR(get_type_node(c, tree, type_node, &return_type));

        if (return_type == NULL)
        {
            char *text = get_node_text_no_spaces(tree, type_node);
            PRINT_ERROR("Unknown type: %s\n", text);
            free(text);
            return 1;
        }

        PRINT_INFO("return type: %p : %s %s", return_type, return_type->keyword, return_type->name);

        /* decode mods_node */
        if (mods_node->variant != 3)
        {
            PRINT_ERROR("Function declaration is of wrong type\n");
            return 1;
        }

        struct parser_tree_node_t *function_mods_node = mods_node->childs[0];
        ASSERT_NODE(function_mods_node, "variable_declaration_mods_fn");

        function_args = mods_node->childs[1];
        ASSERT_NODE(function_args, "declaration_fn_args_many");

        if (function_mods_node->variant != 1)
        {
            PRINT_ERROR("Function mods node must have 1st variant (others are unsupported for now)");
            return 1;
        }

        struct parser_tree_node_t *variable_name_node = function_mods_node->childs[0];
        ASSERT_NODE(variable_name_node, "variable_name");

        char *function_name = get_node_text_no_spaces(tree, variable_name_node);

        PRINT_INFO("function name: %s", function_name);

        f->ret = return_type;
        f->label = function_name;
    }

    if (function_args == NULL)
    {
        PRINT_ERROR("Error: [unreachable] function_args is NULL.");
        return 1;
    }

    /* fill local variables table */
    {
        ASSERT_NODE(function_args, "declaration_fn_args_many");

        int count = 0;

        reserve_buffer(c->code, c->code->len + 256);
        c->code->len += sprintf(c->code->buffer + c->code->len, "; arguments\n");
        {
            struct parser_tree_node_t *args = function_args;
            while (args != NULL)
            {
                if (args->variant == 0)
                {
                    struct parser_tree_node_t *expr = args->childs[0];
                    ASSERT_NODE(expr, "fn_variable_declaration");
                    
                    args = args->childs[1];
                    ASSERT_NODE(args, "declaration_fn_args_many");

                    struct parser_tree_node_t *type_node = expr->childs[0];
                    ASSERT_NODE(type_node, "type");
                    struct parser_tree_node_t *mods_node = expr->childs[1];
                    ASSERT_NODE(mods_node, "variable_declaration_mods");

                    char *label = calloc(1, 128);
                    sprintf(label, "%s - %d", f->label, 4 + (int)get_type_size(c, f->ret) + (count + 1) * 4);
                    
                    reserve_buffer(c->code, c->code->len + 256);
                    c->code->len += sprintf(c->code->buffer + c->code->len, ".dd 0xBEBEBEBE\n");
                     
                    HANDLE_ERROR(register_function_variable_with_label(c, tree, f, &fc, type_node, mods_node, label));
                    
                    free(label);
                    
                    count++;
                }
                else if (args->variant == 1)
                {
                    struct parser_tree_node_t *expr = args->childs[0];
                    ASSERT_NODE(expr, "fn_variable_declaration");
                    
                    args = NULL;

                    struct parser_tree_node_t *type_node = expr->childs[0];
                    ASSERT_NODE(type_node, "type");
                    struct parser_tree_node_t *mods_node = expr->childs[1];
                    ASSERT_NODE(mods_node, "variable_declaration_mods");

                    char *label = calloc(1, 128);
                    sprintf(label, "%s - %d", f->label, 4 + (int)get_type_size(c, f->ret) + (count + 1) * 4);

                    reserve_buffer(c->code, c->code->len + 256);
                    c->code->len += sprintf(c->code->buffer + c->code->len, ".dd 0xBEBEBEBE\n");
                     
                    HANDLE_ERROR(register_function_variable_with_label(c, tree, f, &fc, type_node, mods_node, label));

                    free(label);
                    
                    count++;
                }
                else if (args->variant == 2)
                {
                    args = NULL;
                }
                else
                {
                    PRINT_ERROR("Unknown declaration_fn_args_many variant: %d", args->variant);
                }
            }
        }

        /* using count  */
        // TODO: no arguments for now.
        // f->locals
    }

    reserve_buffer(c->code, c->code->len + 512);
    if (f->ret != NULL)
    {
        c->code->len += sprintf(c->code->buffer + c->code->len, "; return value\n");
        c->code->len += sprintf(c->code->buffer + c->code->len, ".dd 0xBEBEBEBE\n");
    }
    c->code->len += sprintf(c->code->buffer + c->code->len, "; return address\n");
    c->code->len += sprintf(c->code->buffer + c->code->len, ".dd 0xBEBEBEBE\n");
    c->code->len += sprintf(c->code->buffer + c->code->len, "%s:\n", f->label);

    HANDLE_ERROR(compile_block(c, tree, f, &fc, body));

    return 0;
}


result_t compile_global_scope_stmt(struct compiler_instance_t *c, struct parser_tree_t *tree, struct parser_tree_node_t *node)
{
    PRINT_INFO("node %p:");
    if (node->variant == 0)
    {
        struct parser_tree_node_t *child = node->childs[0];
        ASSERT_NODE(child, "structure");

        HANDLE_ERROR(register_structure(c, tree, child));
        return 0;
    }
    else if (node->variant == 1)
    {
        struct parser_tree_node_t *child = node->childs[0];
        ASSERT_NODE(child, "function");

        HANDLE_ERROR(compile_function(c, tree, child));
        return 0;
    }
    else if (node->variant == 2)
    {
        struct parser_tree_node_t *decl = node->childs[0];
        ASSERT_NODE(decl, "variable_declaration");
        
        struct parser_tree_node_t *type_node = decl->childs[0];
        ASSERT_NODE(type_node, "type");
        
        struct parser_tree_node_t *mods_node = decl->childs[1];
        ASSERT_NODE(mods_node, "variable_declaration_mods_many");
        
        /* check, if this is function declaration, then add this function to list */
        if (mods_node->variant == 1)
        {
            struct parser_tree_node_t *one_mods = mods_node->childs[0];
            ASSERT_NODE(one_mods, "variable_declaration_mods");

            if (one_mods->variant == 3)
            {
                struct parser_tree_node_t *fn_decl = one_mods->childs[0];
                ASSERT_NODE(fn_decl, "variable_declaration_mods_fn");
                
                struct parser_tree_node_t *fn_args = one_mods->childs[1];
                ASSERT_NODE(fn_args, "declaration_fn_args_many");

                (void)fn_args;

                if (fn_decl->variant == 1)
                {
                    struct parser_tree_node_t *fn_name = fn_decl->childs[0];
                    ASSERT_NODE(fn_name, "variable_name");

                    char *name = get_node_text_no_spaces(tree, fn_name);
                    
                    struct function_t *f = &c->functions[c->functions_len++];
                    f->label = name;

                    struct type_t *return_type = NULL;
                    HANDLE_ERROR(get_type_node(c, tree, type_node, &return_type));
                    
                    f->ret = return_type;

                    if (return_type == NULL)
                    {
                        char *text = get_node_text_no_spaces(tree, type_node);
                        PRINT_ERROR("Unknown type: %s\n", text);
                        free(text);
                        return 1;
                    }
                        
                    PRINT_INFO("Find function <%s> declaration.", f->label);
                    
                    return 0;
                }
            }
        }
        PRINT_INFO("global variable!");
        PRINT_ERROR("Global variables isn't supported for now.");
        return 1;
    }
    else
    {
        PRINT_ERROR("Unknown global_scope_stmt variant");
        return 1;
    }

    return 0;
}



result_t compile(struct parser_tree_t *tree, char **resulting_code)
{
    assert(tree != NULL);

    struct compiler_instance_t c = {};

    c.code = calloc(1, sizeof(*c.code));
    c.vars = calloc(1, sizeof(*c.vars));

    /* fill type table */
    c.types[c.types_len++] = (struct type_t){
        .keyword = strdup(""),
        .name = strdup("byte"),
        .type = TYPE_BYTE,
        .data = {}
    };

    c.types[c.types_len++] = (struct type_t){
        .keyword = strdup(""),
        .name = strdup("int"),
        .type = TYPE_INT,
        .data = {}
    };

    /* build node */
    struct parser_tree_node_t *current = tree->root;

    if (current == NULL)
    {
        PRINT_ERROR("Empty tree given");
        return 1;
    }

    ASSERT_NODE(current, "E");
    current = current->childs[0];

    while (current)
    {
        ASSERT_NODE(current, "global_scope_stmt_many");
        if (current->variant == 1)
        {
            current = NULL;
        }
        else
        {
            PRINT_INFO("from: %p", current);
            HANDLE_ERROR(compile_global_scope_stmt(&c, tree, current->childs[0]));
            current = current->childs[1];
            PRINT_INFO("new: %p", current);
        }
    }

    /* add temporary variables */
    reserve_buffer(c.vars, c.vars->len + 1024);
    c.vars->len += sprintf(c.vars->buffer + c.vars->len, "_size4:\n");
    c.vars->len += sprintf(c.vars->buffer + c.vars->len, ".dd 4\n");
    c.vars->len += sprintf(c.vars->buffer + c.vars->len, "_size1:\n");
    c.vars->len += sprintf(c.vars->buffer + c.vars->len, ".dd 1\n");
    c.vars->len += sprintf(c.vars->buffer + c.vars->len, "_zero:\n");
    c.vars->len += sprintf(c.vars->buffer + c.vars->len, ".dd 0\n");

    *resulting_code = calloc(1, c.code->len + c.vars->len + 1);
    memcpy(*resulting_code,               c.code->buffer, c.code->len);
    memcpy(*resulting_code + c.code->len, c.vars->buffer, c.vars->len);

    free(c.code);
    free(c.vars);

    return 0;
}

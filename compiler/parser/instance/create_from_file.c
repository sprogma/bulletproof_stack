#include "../api.h"
#include "../common.h"
#include "stdio.h"
#include "ctype.h"
#include "string.h"
#include "stdlib.h"


static int istoken(int ch)
{
    return isalpha(ch) || ch == '_';
}


static result_t read_parser_option(struct parser_instance_t *instance, FILE *pipe_to_read)
{
    assert(instance != NULL);
    assert(pipe_to_read != NULL);

    char option[512];
    fgets(option, sizeof(option) - 1, pipe_to_read);

    int x = strlen(option);
    
    if (option[x - 1] == '\n')
    {
        ungetc('\n', pipe_to_read);
    }
    
    while (x - 1 >= 0 && isspace(option[x - 1]))
    {
        --x;
    }
    /* trim spaces from right */
    option[x] = 0;

    if (strcmp(option, "compress_spaces") == 0)
    {
        PRINT_INFO("Enable option compress_spaces");
        PRINT_WARNING("option compress_spaces is obsolete");
        instance->options.compress_spaces = 1;
    }
    else
    {
        PRINT_WARNING("Unknown option: %s", option);
    }

    return 0;
}


static result_t read_comment(struct parser_instance_t *instance, FILE *pipe_to_read)
{
    assert(instance != NULL);
    assert(pipe_to_read != NULL);

    while (getc(pipe_to_read) != '\n') { }
    ungetc('\n', pipe_to_read);

    return 0;
}


static result_t add_grammar_rule_variant(struct parser_instance_t *instance, 
                                         struct parser_identifer_t *identifer, 
                                         struct parser_identifer_variant_t *variant, 
                                         const char **line_ptr)
{
    assert(instance != NULL);
    assert(identifer != NULL);
    assert(variant != NULL);
    assert(line_ptr != NULL);
    assert(*line_ptr != NULL);

    const char *line = *line_ptr;

    while (isspace(*line)) { line++; }

    /* calculate count of atoms */
    size_t atoms_count = (line[0] != '\"');
    {
        uint8_t state = 0;
        for (int i = 0; line[i] && line[i] != '|'; ++i)
        {
            if (state == 0)
            {
                /* parsing tokens */
                if (line[i] == '\"')
                {
                    state = 1;
                    atoms_count++;
                }
                else if (isspace(line[i]) && istoken(line[i + 1]))
                {
                    atoms_count++;
                }
            }
            else
            {
                /* parsing literals */
                if (line[i] == '\"' && line[i - 1] != '\\')
                {
                    state = 0;
                }
            }
        }
    }

    PRINT_INFO("Find %d atoms in variant", atoms_count);

    /* allocate buffer */
    variant->atoms_length = atoms_count;
    variant->atoms = calloc(1, sizeof(*variant->atoms) * variant->atoms_length);

    size_t variable_atoms_count = 0;
    /* parse atoms */
    for (size_t i = 0; i < variant->atoms_length; ++i)
    {
        while (isspace(*line)) { line++; }
        if (*line == '\"')
        {
            /* skip first quote */
            line++;
            /* string literal */
            const char *start = line;
            while (*line && (line[1] != '\"' || *line == '\\'))
            {
                line++;
            }
            if (!*line)
            {
                PRINT_ERROR("Not closed string literal");
                return 1;
            }
            line++;
            PRINT_INFO("Atom Literal <%.*s>", line - start, start);
            variant->atoms[i].type = PARSER_ATOM_LITERAL;

            char *literal = calloc(1, line - start + 1);
            memcpy(literal, start, line - start);
            
            variant->atoms[i].value.literal = literal;
            
            line++;
        }
        else if (istoken(*line))
        {
            /* identifer */
            const char *start = line;
            while (istoken(*line))
            {
                line++;
            }

            if (strncmp(start, "S", line - start) == 0)
            {
                PRINT_INFO("Atom Special Identifer: SPACES <%.*s>", line - start, start);
                variant->atoms[i].type = PARSER_ATOM_SPACES;

                variant->atoms[i].value.literal = NULL;
            }
            else if (strncmp(start, "CSTRING", line - start) == 0)
            {
                PRINT_INFO("Atom Special Identifer: C_STRING_LITERAL <%.*s>", line - start, start);
                variant->atoms[i].type = PARSER_ATOM_C_STRING_LITERAL;

                variant->atoms[i].value.literal = NULL;
            }
            else if (strncmp(start, "CNAME", line - start) == 0)
            {
                PRINT_INFO("Atom Special Identifer: C_NAME <%.*s>", line - start, start);
                variant->atoms[i].type = PARSER_ATOM_C_NAME;

                variant->atoms[i].value.literal = NULL;
            }
            else if (strncmp(start, "CINT", line - start) == 0)
            {
                PRINT_INFO("Atom Special Identifer: C_INT <%.*s>", line - start, start);
                variant->atoms[i].type = PARSER_ATOM_C_INT;

                variant->atoms[i].value.literal = NULL;
            }
            else if (strncmp(start, "CFLOAT", line - start) == 0)
            {
                PRINT_INFO("Atom Special Identifer: C_FLOAT <%.*s>", line - start, start);
                variant->atoms[i].type = PARSER_ATOM_C_FLOAT;

                variant->atoms[i].value.literal = NULL;
            }
            else
            {
                PRINT_INFO("Atom Identifer <%.*s>", line - start, start);
                variant->atoms[i].type = PARSER_ATOM_IDENTIFER;

                char *literal = calloc(1, line - start + 1);
                memcpy(literal, start, line - start);

                variant->atoms[i].value.literal = literal;
                variable_atoms_count++;
            }
        }
        else
        {
            PRINT_ERROR("Find symbol %c as atom", *line);
            return 1;
        }
    }
    while (isspace(*line)) { line++; }
    if (*line != '|' && *line)
    {
        PRINT_ERROR("After parsing all atoms find symbol %c", *line);
        return 1;
    }
    line++;

    variant->vars_length = variable_atoms_count;
    
    *line_ptr = line;

    return 0;
}


static result_t add_grammar_rule(struct parser_instance_t *instance, struct parser_identifer_t *identifer, const char *line)
{
    assert(instance != NULL);
    assert(identifer != NULL);
    assert(line != NULL);
    
    while (isspace(*line))
    {
        line++;
    }
    
    /* read identifer name */

    int name_end = 0;
    while (istoken(line[name_end]))
    {
        name_end++;
    }
    char *name = calloc(1, name_end + 1);
    memcpy(name, line, name_end);
    name[name_end] = 0;
    identifer->identifer = name;

    line += name_end;

    PRINT_INFO("Read name = '%s'", identifer->identifer);

    /* read := */
    while (isspace(*line)) { line++; }
    if (*line++ != ':')
    {
        PRINT_ERROR("Not found := after name. located %c character", line[-1]);
        return 1;
    }
    if (*line++ != '=')
    {
        PRINT_ERROR("Not found := after name. located :%c symbol", line[-1]);
        return 1;
    }
    
    /* calculate number of variants */
    size_t variants_count = 1;
    {
        uint8_t state = 0;
        for (int i = 0; line[i]; ++i)
        {
            if (state == 0)
            {
                /* parsing tokens */
                if (line[i] == '\"')
                {
                    state = 1;
                }
                else if (line[i] == '|')
                {
                    variants_count++;
                }
            }
            else
            {
                /* parsing literals */
                if (line[i] == '\"' && line[i - 1] != '\\')
                {
                    state = 0;
                }
            }
        }
    }

    /* read variants */
    PRINT_INFO("Find %d variants of identifer", variants_count);

    identifer->variants_length = variants_count;
    identifer->variants = calloc(1, sizeof(*identifer->variants) * identifer->variants_length);

    for (size_t i = 0; i < identifer->variants_length; ++i)
    {    
        while (isspace(*line)) { line++; }
        HANDLE_ERROR(add_grammar_rule_variant(instance, identifer, identifer->variants + i, &line));
    }
    
    while (isspace(*line)) { line++; }
    if (*line)
    {
        PRINT_ERROR("After parsing all variants find symbol %c", *line);
        return 1;
    }

    return 0;
}



static result_t resolve_identifer(struct parser_instance_t *instance, struct parser_identifer_t **resolve_identifer)
{   
    char *name = *(char **)resolve_identifer;

    for (size_t d = 0; d < instance->identifers_length; ++d)
    {
        struct parser_identifer_t *identifer = instance->identifers + d;
        if (strcmp(identifer->identifer, name) == 0)
        {
            *resolve_identifer = identifer;
            return 0;
        }
    }

    PRINT_ERROR("Cannot find identifer with name <%s>", name);
    return 1;
}

static result_t resolve_identifer_links(struct parser_instance_t *instance)
{
    assert(instance != NULL);
    

    for (size_t d = 0; d < instance->identifers_length; ++d)
    {
        struct parser_identifer_t *identifer = instance->identifers + d;
        for (size_t v = 0; v < identifer->variants_length; ++v)
        {
            struct parser_identifer_variant_t *variant = identifer->variants + v;
            for (size_t a = 0; a < variant->atoms_length; ++a)
            {
                struct parser_identifer_variant_atom_t *atom = variant->atoms + a;
                switch (atom->type)
                {
                    case PARSER_ATOM_IDENTIFER:
                        /* resolve identifer */
                        {
                            char *name = (char *)atom->value.identifer;
                            HANDLE_ERROR(resolve_identifer(instance, &atom->value.identifer));
                            free(name);
                        }
                        break;
                    case PARSER_ATOM_LITERAL:
                    case PARSER_ATOM_SPACES:
                    case PARSER_ATOM_C_STRING_LITERAL:
                    case PARSER_ATOM_C_NAME:
                    case PARSER_ATOM_C_INT:
                    case PARSER_ATOM_C_FLOAT:
                    default:
                        break;
                }
            }
        }
    }

    return 0;
}



static result_t load_grammar_file(struct parser_instance_t *instance, const char *grammar_file)
{
    assert(instance != NULL);
    assert(grammar_file != NULL);

    FILE *file = fopen(grammar_file, "r");
    if (file == NULL)
    {
        PRINT_ERROR("File <%s> not found", grammar_file);
        return 1;
    }

    /* first iteration: read options and count identifers */
    int identifer_count = 0;
    {
        int ch = 0;
        while (!feof(file) && !ferror(file))
        {
            /* here, next not read char is first char of new line. */
            while (isblank(ch = getc(file))) { }
            /*  */
            switch (ch)
            {
                case '\n':
                    break;
                case '!':
                    HANDLE_ERROR(read_parser_option(instance, file));
                    break;
                case '#':
                    HANDLE_ERROR(read_comment(instance, file));
                    break;
                case EOF:
                    break;
                default:
                    if (istoken(ch) || ch == '_')
                    {
                        identifer_count++;
                    }
            }
            while (ch != '\n' && !feof(file) && !ferror(file))
            {
                ch = getc(file);
            }
        }

        PRINT_INFO("Read %d identifers", identifer_count);
    }

    /* allocate buffer for identifers */
    instance->identifers_length = identifer_count;
    instance->identifers = calloc(1, sizeof(*instance->identifers) * instance->identifers_length);
    rewind(file);

    /* read grammar */
    {
        size_t identifer_id = 0;
        
        while (!feof(file) && !ferror(file))
        {
            size_t s_size = 1024, len = 0;
            char *s = calloc(1, s_size), *fgets_result = NULL;
            while ((fgets_result = fgets(s, s_size, file)) != NULL)
            {
                len = strlen(s);
                if (len == 0 || s[len - 1] != '\n')
                {
                    s_size += 1024;
                    char *new_s = realloc(s, s_size);
                    if (new_s == NULL)
                    {
                        return 1;
                    }
                    s = new_s;
                    continue;
                }
                s[len - 1] = 0;
                break;
            }

            if (fgets_result != NULL)
            {
                int i = 0;
                while (isspace(s[i++])) {}
                if (istoken(*s))
                {
                    PRINT_INFO("Read grammar line <%s>", s);
                    HANDLE_ERROR(add_grammar_rule(instance, instance->identifers + identifer_id,  s));
                    identifer_id++;
                }
            }
        }
    }


    /* resolve identifer links */

    HANDLE_ERROR(resolve_identifer_links(instance));
    

    fclose(file);

    return 0;
}



result_t parser_instance_create_from_file(struct parser_instance_t *instance, const char *grammar_file)
{
    assert(instance != NULL);
    assert(grammar_file != NULL);

    HANDLE_ERROR(load_grammar_file(instance, grammar_file));

    return 0;
}

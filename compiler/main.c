#include "stdio.h"
#include "time.h"
#include "malloc.h"
#include "fcntl.h"
#include "sys/stat.h"

#include "parser/api.h"
#include "compiler/compiler.h"


void print(int indent, const char *text, struct parser_tree_node_t *node)
{
    #define INDENT for (int z = 0; z < indent; ++z) putchar(' ');
    
    INDENT printf("identifer: %s of %d\n", node->identifer->identifer, (int)node->variant);
    if (node->end != node->start)
    {
        INDENT printf("value: <%.*s>\n", (int)(node->end - node->start), text + node->start);
    }
    else
    {
        INDENT printf("value: empty node\n");
    }
    for (size_t i = 0; i < node->identifer->variants[node->variant].vars_length; ++i)
    {
        INDENT printf("child %d:\n", (int)i);
        print(indent + 4, text, node->childs[i]);
    }
}


char *read_file(char *filename)
{
    struct stat file_stat;
    int f = open(filename, O_RDONLY);
    if (fstat(f, &file_stat) != 0)
    {
        fprintf(stderr, "cannot open file %s\n", filename);
        return NULL;
    }
    
    char *buffer = calloc(1, file_stat.st_size + 1);
    size_t buffer_len = read(f, buffer, file_stat.st_size); 
    buffer[buffer_len] = '\0';
    
    return buffer;
}


int main(int argc, char **argv)
{
    if (argc != 3)
    {
        fprintf(stderr, "Error: compiler must be called with 2 files: source and destination.\n");
        return 1;
    }

    char *source = read_file(argv[1]);
    if (source == NULL)
    {
        fprintf(stderr, "Error: Cannot read source code.\n");
        return 1;
    }

    struct parser_instance_t instance;
    struct parser_tree_t tree;
    if (parser_instance_create_from_file(&instance, "compiler/test_grammar4.gram") != 0)
    {
        fprintf(stderr, "Error: Cannot read grammar file. <compiler/test_grammar4.gram>\n");
        return 1;
    }
    if (parser_instance_print_grammar(&instance) != 0)
    {
        fprintf(stderr, "Error: Cannot print grammar.\n");
        return 1;
    }
    
    clock_t begin = clock();

    if (parser_instance_parse_tree(&instance, &tree, source) != 0)
    {
        fprintf(stderr, "Error: Parsing failed [syntax error].\n");
        return 1;
    }

    clock_t end = clock();
    double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
    
    /* print tree */
    #ifdef PRINT_TREE
        print(0, tree.source, tree.root);
    #endif

    printf("Parsing took %lf seconds\n", time_spent);
    
    /* compile */
    char *result = NULL;
    if (compile(&tree, &result) != 0 || result == NULL)
    {
        fprintf(stderr, "Error: Compilation failed [compilation error].\n");
        return 1;
    }
    
    fprintf(stderr, "compiled!.\n");

    FILE *f = fopen(argv[2], "w");
    if (f == NULL)
    {
        fprintf(stderr, "Error: Cannot open output file.\n");
        return 1;
    }
    fputs(result, f);
    fclose(f);

    fprintf(stderr, "File <%s> writed.\n", argv[2]);
    
    return 0;
}

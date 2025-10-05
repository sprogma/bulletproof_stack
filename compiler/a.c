#include "stdio.h"
#include "time.h"

#include "parser/api.h"
#include "compiler/compiler.h"

// const char *source_code = "x+x+x+x"; test_grammar2.gram
// const char *source_code = "x * x + x+ ( x + x * x * ( x + x ) ) * x"; test_grammar2.gram
// const char *source_code = R"code(
// aa aaaa(  )  {   "u\"uu";   abc41; $1;  "ooo";}
// )code";
// const char *source_code = R"code(
// int (*(*a[5])(int, char *x))[5], bb {;}
// )code";

// struct s
// {
//     int a, b;
//     int c;
// };

const char *source_code = R"code(
int main()
{
    int a, s;
    a = 5;
    s = 1;
    while (a != 0)
    {
        s = s * a;
        a = a - 1;
    }
    return s;
}
)code";

// const char *source_code = R"code(
// int main()
// {
//     int a = 5;
//     int s = 0;
//     while (a > 0)
//     {
//         s = s + a;
//         a = a - 1;
//     }
//     return s;
// }
// )code";


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


int main()
{
    struct parser_instance_t instance;
    struct parser_tree_t tree;
    result_t res = 0;
    res |= parser_instance_create_from_file(&instance, "test_grammar4.gram");
    res |= parser_instance_print_grammar(&instance);
    
    clock_t begin = clock();

    res |= parser_instance_parse_tree(&instance, &tree, source_code);

    clock_t end = clock();
    double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
    
    /* print tree */
    print(0, tree.source, tree.root);

    printf("Parsing took %lf seconds\n", time_spent);

    if (res)
    {
        printf("Parsing failed with code %d\n", (int)res);
        return res;
    }
    
    /* compile */
    res |= compile(&tree);
    
    return res;
}

#include "../api.h"
#include "../common.h"
#include "stdio.h"
#include "ctype.h"
#include "string.h"
#include "stdlib.h"


result_t parser_instance_print_grammar(struct parser_instance_t *instance)
{
    assert(instance != NULL);

    printf("Parser Instance at %p\n", instance);
    printf("Contains %d identifers.\n", (int)instance->identifers_length);
    for (size_t d = 0; d < instance->identifers_length; ++d)
    {
        struct parser_identifer_t *identifer = instance->identifers + d;
        printf("    Identifer %d:\n", (int)d);
        printf("        Token: <%s>\n", identifer->identifer);
        printf("        It has %d variants:\n", (int)identifer->variants_length);
        for (size_t v = 0; v < identifer->variants_length; ++v)
        {
            struct parser_identifer_variant_t *variant = identifer->variants + v;
            printf("        Variant %d:\n", (int)v);
            printf("            It has %d atoms:\n", (int)variant->atoms_length);
            for (size_t a = 0; a < variant->atoms_length; ++a)
            {
                struct parser_identifer_variant_atom_t *atom = variant->atoms + a;
                printf("                Atom %d:\n", (int)a);
                switch (atom->type)
                {
                    case PARSER_ATOM_IDENTIFER:
                        printf("                    Identifer %p:\n", atom->value.identifer);
                        if (atom->value.identifer != NULL)
                        {
                            printf("                        Token <%s>\n", atom->value.identifer->identifer);
                        }
                        break;
                    case PARSER_ATOM_LITERAL:
                        printf("                    Literal <%s>\n", atom->value.literal);
                        break;
                    case PARSER_ATOM_SPACES:
                        printf("                    Specital Itendifer <SPACES>\n");
                        break;
                    default:
                        printf("                    Unknown constrution [error]\n");
                        break;
                }
            }
        }
    }

    return 0;
}

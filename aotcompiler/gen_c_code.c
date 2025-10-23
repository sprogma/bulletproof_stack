#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include "assert.h"

#include "../optimizer/tree.h"
#include "aot.h"

#define PUSH_STRING(f, string) fwrite(string, 1, sizeof(string), f)


int build_program(FILE *f, struct optimizer *o)
{
    for (int i = 0; i < o->nodes_len; ++i)
    {
        printf("NOT IMPLEMENTED ERROR\n");
    }
    return 0;
}


int gen_c_code(struct optimizer *o, const char *filename)
{
    FILE *f = fopen(filename, "w");
    PUSH_STRING(f, "char mem[64*1024*1024]; int main(){");
    build_program(f, o);
    PUSH_STRING(f, "}");
    fclose(f);
    return 0;
}

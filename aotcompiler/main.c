#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include "assert.h"

#include "../optimizer/tree.h"
#include "aot.h"

int main()
{
    struct optimizer *o = malloc(sizeof(*o));
    o->states_len = 0;
    o->queue_len = 0;
    o->nodes = calloc(1, sizeof(*o->nodes) * MAX_NODES);
    o->nodes_len = 0;
    o->lines_buff = MAX_SOURCE_LINES * 2;
    o->lines = calloc(1, sizeof(*o->lines) * o->lines_buff);
    
    struct tree *t = o->queue + 0;
    o->queue_len = 1;

    t->regions = calloc(1, sizeof(*t->regions) * 128 * 1024);
    t->regions_len = 0;
    t->restrict_id = 1;
    t->optimizer = o;

    t->regions_len = 1;
    t->regions[0].start = 0;
    t->regions[0].end = TOTAL_MEM;
    t->regions[0].is_zero = 0;
    t->regions[0].value = NULL;
    t->regions[0].is_restrict = 0;

    printf("loading image...\n");
    load_code_image(t, 0x4000, "a.bc", "result.dat");
    set_entry(t, 0x4000);
    
    printf("parsing...\n");
    parse(o);

    printf("generating S cource code.\n");

    gen_c_code(o, "res.S");
    
    printf("source code generated.\n");
    printf("build it using:\n");
    printf("gcc %s -masm=intel -c -o a.o\n", "res.S");
    printf("gcc %s -c -o b.o\n", "aotcompiler/runtime.c");
    printf("gcc a.o b.o -o a.exe\n");


    return 0;
}

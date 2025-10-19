#include "stdio.h"
#include "stdlib.h"

#include "tree.h"

int main()
{
    struct optimizer *o = malloc(sizeof(*o));
    o->states_len = 0;
    o->queue_len = 0;
    o->nodes = calloc(1, sizeof(*o->nodes) * 64 * 1024);
    o->nodes_len = 0;
    
    struct tree *t = o->queue + 0;
    o->queue_len = 1;

    t->regions = calloc(1, sizeof(*t->regions) * 128 * 1024);
    t->regions_len = 0;
    t->restrict_id = 1;
    t->optimizer = o;

    t->regions_len = 1;
    t->regions[0].start = 0;
    t->regions[0].end = TOTAL_MEM;
    t->regions[0].is_zero = 1;
    t->regions[0].value = NULL;
    t->regions[0].is_restrict = 0;

    printf("loading image...\n");
    load_code_image(t, 0x4000, "a.bc", "result.dat");
    set_ip(t, 0x4000);
    
    printf("parsing...\n");
    parse(o);

    /* generate profile file */
    gen_profile(o, "res.prof");

    return 0;
}

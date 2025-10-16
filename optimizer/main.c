#include "stdio.h"
#include "stdlib.h"

#include "tree.h"

int main()
{
    struct tree *t = malloc(sizeof(*t));

    t->regions = calloc(1, sizeof(*t->regions) * 1024 * 1024);
    t->regions_len = 0;
    t->nodes = calloc(1, sizeof(*t->nodes) * 1024 * 1024);
    t->nodes_len = 0;
    t->restrict_id = 1;

    t->regions_len = 1;
    t->regions[0].start = 0;
    t->regions[0].end = 64 * 1024 * 1024;
    t->regions[0].is_zero = 1;
    t->regions[0].value = NULL;
    t->regions[0].is_restrict = 0;

    printf("loading image...\n");
    load_code_image(t, 0x4000, "a.bc", "result.dat");
    printf("parsing...\n");
    parse(t, 0x4000);

    return 0;
}

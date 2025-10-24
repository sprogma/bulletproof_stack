#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "string.h"
#include "assert.h"
#include "stdlib.h"

#include "../utils/assembler.h"
#include "tree.h"



int load_code_image(struct tree *t, int load_address, const char *byte_file, const char *data_file)
{
    
    /* read file */
    FILE *f = fopen(byte_file, "rb");
    BYTE *x = malloc(1024 * 1024);
    BYTE *ptr = x;
    int c = 0;
    while ((c = fread(ptr, 1, 1024, f)) != 0)
    {
        ptr += c;
    }
    fclose(f);
    int total_read = ptr - x;
    printf("Read %d bytes\n", total_read);
    
    /* no free neded, becouse saved data in optimizer->source */
    t->optimizer->source = x;
    t->optimizer->source_size = total_read;

    /* set regions */
    set_region_value(t, load_address, load_address + total_read, 0, x);
    FILE *d = fopen(data_file, "r");

    if (d == NULL)
    {
        printf("ERROR: cannot open file %s\n", data_file);
        return 1;
    }
    printf("loading data file\n");

    while (1)
    {
        int line = 0;
        char code[256] = {};
        BYTE c;
        int s, e;
        if (fscanf(d, "%c %d %d %d:%[^\n]\n", &c, &s, &e, &line, code) != 5)
        {
            if (!feof(d))
            {
                printf("ERROR: data file is in wrong format.\n");
                abort();
            }
            break;
        }

        s += load_address;
        e += load_address;
        
        /* insert command to command mappings */
        add_source_data_line(t->optimizer, c, s, e, line, code);
        
        if (c == 'I')
        {
            /* this region is instruction, assume them aren't changed */
            set_restrict(t, s, e, t->restrict_id++);
            
            /* create node in cache */
            get_node(t, s);
        }
        if (c == 'D')
        {
            /* this is directive, also think that it doesn't changes */
            set_restrict(t, s, e, t->restrict_id++);
        }
    }

    printf("load end\n");
    
    return 0;
}



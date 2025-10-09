#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "assert.h"
#include "malloc.h"
#include "string.h"
#include "stdlib.h"
#include "ctype.h"


#include "./assembler_internal.h"


result_t add_label(struct compilation_table *table, char *name, int64_t len, int32_t offset)
{
    for (int64_t i = 0; i < table->labels_len; ++i)
    {
        if (strcmp(table->labels[i].name, name) == 0)
        {
            PRINT_ERROR("Redefenition of label <%s>", name);
            return 1;
        }
    }

    /* allocate additional memory */
    if (table->labels_len >= table->labels_alloc)
    {
        table->labels_alloc = 2 * table->labels_alloc + !(table->labels_alloc);
        void *new_ptr = realloc(table->labels, sizeof(*table->labels) * table->labels_alloc);
        if (new_ptr == NULL) { PRINT_ERROR("out of memory"); return 1; }
        table->labels = new_ptr;
    }

    int64_t id = table->labels_len++;
    table->labels[id] = (struct label){name, len, offset};
    PRINT_INFO("register label <%*.*s> with offset: %08x", (int)len, (int)len, name, offset);

    return 0;
}

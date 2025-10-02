#ifndef ASSEMBLER
#define ASSEMBLER


#include "stddef.h"
#include "inttypes.h"
#include "specs.h"


typedef unsigned char    BYTE;
typedef uint16_t         WORD;
typedef uint32_t         DWORD;


struct output_buffer
{
    BYTE *buffer;
    ssize_t len;
    ssize_t alloc;
};


struct label
{
    const char *name;
    size_t name_len;
    size_t position;
};


struct compilation_table
{
    struct label *labels;
    size_t        labels_len;
    size_t        labels_alloc;
};



/*
 * reads file as lines array.
 */
int read_file(const char *filename, char ***lines, ssize_t *lines_len);


/*
 * get instruction length from line
 */
ssize_t decode_instruction_length(BYTE *line);

/*
 * compile program into buffer out
 */
 int build_program(char **lines, ssize_t lines_len, struct output_buffer *out);




#endif

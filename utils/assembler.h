#ifndef ASSEMBLER
#define ASSEMBLER


#include "stddef.h"
#include "inttypes.h"
#include "specs.h"


#ifndef NOT_DEFINE_INTEGER_TYPES
    typedef unsigned char    BYTE;
    typedef uint16_t         WORD;
    typedef uint32_t         DWORD;
#endif


struct output_buffer
{
    BYTE *buffer;
    ssize_t len;
    ssize_t alloc;
};


struct label
{
    const char *name;
    ssize_t name_len;
    int32_t position;
};


struct compilation_table
{
    struct label *labels;
    ssize_t        labels_len;
    ssize_t        labels_alloc;
};

struct spu
{
    BYTE *mem;
    size_t mem_size;
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


/*
 * C++ vector-like byte array structure
 */
int reserve_output_buffer(struct output_buffer *b, ssize_t size);


#endif

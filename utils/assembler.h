#ifndef ASSEMBLER
#define ASSEMBLER


#include "stddef.h"
#include "inttypes.h"
#include "specs.h"

#include "../logger/logger.h"


#define ARRAYLEN(array) (sizeof(array) / sizeof(*(array)))
static inline void *OR(void *a, void *b) { return (a ? a : b); }


#ifndef NOT_DEFINE_INTEGER_TYPES
    typedef unsigned char    BYTE;
    typedef uint16_t         WORD;
    typedef uint32_t         DWORD;
#endif


struct output_buffer
{
    union {
        char *text;
        BYTE *buffer;
    };
    int64_t len;
    int64_t alloc;
};


struct label
{
    const char *name;
    int64_t name_len;
    int32_t position;
};


struct compilation_table
{
    struct label *labels;
    int64_t        labels_len;
    int64_t        labels_alloc;
};


/*
 * write text into file
 */
result_t write_file(const char *filename, char *buffer, int64_t size);

/*
 * reads file as lines array.
 */
result_t read_file(const char *filename, char ***lines, int64_t *lines_len);

/*
 * reads binary file as array.
 */
result_t read_binary_file(const char *filename, BYTE **buffer, int64_t *buffer_len);


/*
 * get instruction length from line
 */
/* located in helping_functions.c */
int64_t decode_instruction_length(BYTE *line);

/*
 * decompile program into buffer out
 */
result_t decode_program(BYTE *code, int64_t code_len, struct output_buffer *out);


/*
 * C++ vector-like byte array structure
 */
result_t reserve_output_buffer(struct output_buffer *b, int64_t size);

/*
 * Printf into output buffer
 */
result_t print_buffer(struct output_buffer *b, char *format_string, ...);

/*
 * Add text to buffer end
 */
result_t copy_to_end(struct output_buffer *b, void *data, size_t size);


/* helping functions */
int64_t decode_instruction_length(BYTE *line);
int isstartkey(int c);
int iskey(int c);
int is_all_digits(char *s, char *e);
char *skip_leading_spaces(char *s);
void str_trim(char **p_s, char **p_e);
result_t parse_integer(char *s, char *e, int32_t *result);


#endif

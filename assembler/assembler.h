#ifndef ASSEMBLER
#define ASSEMBLER


#include "stddef.h"


#define MAX_INSTRUCTION_LENGTH 128


struct output_buffer
{
    char *buffer;
    ssize_t len;
    ssize_t alloc;
};



/*
 * reads file as lines array.
 */
int read_file(const char *filename, char ***lines, ssize_t *lines_len);

/*
 * encode instruction stored in line into buffer b
 */
int encode_instruction(char *line, char *destination, ssize_t *bytes_written);




#endif

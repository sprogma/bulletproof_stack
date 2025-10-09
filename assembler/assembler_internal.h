#ifndef ASSEBMLER_INTERNAL
#define ASSEBMLER_INTERNAL


#include "../utils/assembler.h"


/*
 * compile program into buffer out
 */
result_t build_program(char **lines, int64_t lines_len, struct output_buffer *out);


result_t add_label(struct compilation_table *table, char *name, int64_t len, int32_t offset);


result_t calculate_offsets(struct compilation_table *table, int64_t position, char *args, char *args_end, int64_t nargs, int32_t *offsets_length);


result_t encode_directive(struct compilation_table *table, char *line, int64_t position, struct output_buffer *dst, int64_t *result_length);


result_t encode_command(struct compilation_table *table, char *line, int64_t position, struct output_buffer *dst, int64_t *result_length);

#endif


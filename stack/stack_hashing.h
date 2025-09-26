#ifndef STACK_HASHING
#define STACK_HASHING


#include "inttypes.h"

#include "stack.h"
#include "stack_config.h"
#include "stack_macro_args.h"


uint64_t calculate_hash(STACK_COMMON_ARGS, void *data, size_t length);

uint64_t calculate_header_hash(STACK_COMMON_ARGS, struct stack_t *s);

uint64_t calculate_content_hash(STACK_COMMON_ARGS, struct stack_t *s);

enum stack_error_code stack_update_hashes(STACK_COMMON_ARGS, struct stack_t *s);

#endif

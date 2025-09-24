#ifndef STACK_H
#define STACK_H

#include "malloc.h"
#include "inttypes.h"
#include "stddef.h"


enum stack_error_code
{
    stack_code_ok = 0,
    stack_unknown_error,
    stack_pop_empty_error,
    stack_no_memory_error,
    stack_validation_error,
};

static inline const char *stack_get_error_string(enum stack_error_code err)
{
    switch (err)
    {
        case stack_code_ok:
            return "stack_code_ok";
        case stack_unknown_error:
            return "stack_unknown_error";
        case stack_pop_empty_error:
            return "stack_pop_empty_error";
        case stack_no_memory_error:
            return "stack_no_memory_error";
        case stack_validation_error:
            return "stack_validation_error";
        default:
            return "ERROR: UNKNOWN CODE";
    }
}


typedef int stack_value_t;
struct hash_t
{
    /* must be first field in structure */
    uint64_t header;
    /* other fields */
    uint64_t content;
};


struct stack_t
{
    /* must be first field in structure */
    struct hash_t hash;
    /* other fields */
    stack_value_t *data;
    ssize_t data_len;
    ssize_t data_alloc;
};


enum stack_error_code stack_init(struct stack_t *s) __attribute__((warn_unused_result));
enum stack_error_code stack_destroy(struct stack_t *s) __attribute__((warn_unused_result));
enum stack_error_code stack_push(struct stack_t *s, int value) __attribute__((warn_unused_result));
enum stack_error_code stack_pop(struct stack_t *s, stack_value_t *pValue) __attribute__((warn_unused_result));


#endif

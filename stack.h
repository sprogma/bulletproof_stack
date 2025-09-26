#ifndef STACK_H
#define STACK_H

#include "malloc.h"
#include "inttypes.h"
#include "stddef.h"


#ifdef _WIN32
    #include "WinDef.h"
    typedef DWORD stack_thread_type_t;
#else
    #include "pthread.h"
    typedef pthread_t stack_thread_type_t;
#endif

enum stack_error_code
{
    stack_code_ok = 0,
    stack_unknown_error,
    stack_pop_empty_error,
    stack_no_memory_error,
    stack_invalid_memory_error,
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
        case stack_invalid_memory_error:
            return "stack_invalid_memory_error";
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
    stack_thread_type_t creator_thread;
};

#define STACK_COMMON_ARGS const char *file_name, const char *func_name, const int line
#define STACK_COMMON_ARGS_SET_VALUES __FILE__, __FUNCTION__, __LINE__

enum stack_error_code stack_fn_init(STACK_COMMON_ARGS, struct stack_t *s) __attribute__((warn_unused_result));
enum stack_error_code stack_fn_destroy(STACK_COMMON_ARGS, struct stack_t *s) __attribute__((warn_unused_result));
enum stack_error_code stack_fn_get_size(STACK_COMMON_ARGS, struct stack_t *s, ssize_t *size) __attribute__((warn_unused_result));
enum stack_error_code stack_fn_push(STACK_COMMON_ARGS, struct stack_t *s, int value) __attribute__((warn_unused_result));
enum stack_error_code stack_fn_pop(STACK_COMMON_ARGS, struct stack_t *s, stack_value_t *pValue) __attribute__((warn_unused_result));

#define stack_init(s) stack_fn_init(STACK_COMMON_ARGS_SET_VALUES, s)
#define stack_destroy(s) stack_fn_destroy(STACK_COMMON_ARGS_SET_VALUES, s)
#define stack_get_size(s, out) stack_fn_get_size(STACK_COMMON_ARGS_SET_VALUES, s, out)
#define stack_push(s, in) stack_fn_push(STACK_COMMON_ARGS_SET_VALUES, s, in)
#define stack_pop(s, out) stack_fn_pop(STACK_COMMON_ARGS_SET_VALUES, s, out)

#endif

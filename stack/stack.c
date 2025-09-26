#ifdef _WIN32
    #define __USE_MINGW_ANSI_STDIO 1
#endif
#include "stdio.h"
#include "stdlib.h"
#include "inttypes.h"
#include "string.h"

#include "stack_macro_args.h"
#include "stack_memory_checks.h"

#ifdef _WIN32
    #include "Windows.h"
    #define stack_GetCurrentThreadId() GetCurrentThreadId()
#else
    #include "pthread.h"
    #define stack_GetCurrentThreadId pthread_self()
#endif


uint64_t calculate_hash(STACK_COMMON_ARGS, void *data, size_t length)
{
    if (data == NULL || length == 0) return 0;
    ASSERT_ADDRESS_READ(data, length, "hash calculation [DATA ACCESS]");
    char *ptr_data = data;
    uint64_t hash = 0x0123456789ABCDEFULL;
    for (size_t i = 0; i < length; ++i)
    {
        hash *= 1000000009; /* 1000000007 / 998244353 */
        hash += 1 + *ptr_data++;
    }
    return hash;
}


uint64_t calculate_header_hash(STACK_COMMON_ARGS, struct stack_t *s)
{
    if (s == NULL) return 0;
    return calculate_hash(COMMON_ARGS_VALUE, (char *)s + sizeof(uint64_t), sizeof(*s) - sizeof(uint64_t));
}

uint64_t calculate_content_hash(STACK_COMMON_ARGS, struct stack_t *s)
{
    if (s == NULL) return 0;
    #ifdef STACK_HASH_ALL_ALLOCATED_CONTENT
        return calculate_hash(COMMON_ARGS_VALUE, s->data, sizeof(*s->data) * s->data_alloc);
    #else
        ssize_t end_length = STACK_MAX_HASHING_CONTENT_LENGTH >> 1;
        ssize_t begin_length = STACK_MAX_HASHING_CONTENT_LENGTH - end_length;
        if (end_length + begin_length < s->data_len)
        {
            return calculate_hash(COMMON_ARGS_VALUE, s->data,                            sizeof(*s->data) * begin_length) ^ 
                   calculate_hash(COMMON_ARGS_VALUE, s->data + s->data_len - end_length, sizeof(*s->data) * end_length);
        }
        return calculate_hash(COMMON_ARGS_VALUE, s->data, sizeof(*s->data) * s->data_len);
    #endif
}


enum stack_error_code stack_update_hashes(STACK_COMMON_ARGS, struct stack_t *s)
{
    /* 1. compute content hash */
    s->hash.content = calculate_content_hash(COMMON_ARGS_VALUE, s);
    /* 2. compute header hash, becouse it depends on content hash value */
    s->hash.header = calculate_header_hash(COMMON_ARGS_VALUE, s);
    return stack_code_ok;
}





enum stack_error_code stack_fn_init(STACK_COMMON_ARGS, struct stack_t *s)
{
    if (s == NULL)
    {
        STACK_DEBUG_PRINT("Error at %s:%s:%d\n", __FILE__, __FUNCTION__, __LINE__);
        STACK_DEBUG_PRINT("!> given stack pointer is NULL\n");
        return stack_validation_error;
    }
    ASSERT_ADDRESS_READWRITE(s, sizeof(*s), "stack pointer at creation [HEADER ACCESS]");
    // printf("Assert completed");
    if (s->data_len != 0 || 
        s->data_alloc != 0 || 
        s->data != 0 || 
        s->hash.header != 0 || 
        s->hash.content != 0)
    {
        STACK_DEBUG_PRINT("Error at %s:%s:%d\n", __FILE__, __FUNCTION__, __LINE__);
        STACK_DEBUG_PRINT("!> given stack's content is not filled with zeros\n");
        STACK_DEBUG_PRINT("stack [%p] : \n", s);
        STACK_DEBUG_PRINT("{\n");
        STACK_DEBUG_PRINT("    hash:       [header: %llx content: %llx]\n", s->hash.header, s->hash.content);
        STACK_DEBUG_PRINT("    data:       %p\n", s->data);
        STACK_DEBUG_PRINT("    data_len:   %016zd\n", s->data_len);
        STACK_DEBUG_PRINT("    data_alloc: %016zd\n", s->data_alloc);
        STACK_DEBUG_PRINT("}\n");
        return stack_validation_error;
    }
    s->data_len = 0;
    s->data_alloc = 16;
    s->data = calloc(1, sizeof(*s->data) * s->data_alloc);
    s->creator_thread = stack_GetCurrentThreadId();
    if (s->data == NULL)
    {
        return stack_no_memory_error;
    }
    ASSERT_ADDRESS_READWRITE(s->data, s->data_alloc * sizeof(*s->data), "initialization after calloc at creation [DATA ACCESS]");
    #ifdef STACK_FILL_RANDOM_AFTER_ALLOCATION
    {
        ssize_t total_size = (ssize_t)sizeof(*s->data) * s->data_alloc;
        for (ssize_t i = 0; i < total_size; ++i)
        {
            ((char *)s->data)[i] = rand() | 0x88;
        } 
    }
    #endif
    stack_update_hashes(COMMON_ARGS_VALUE, s);
    STACK_VERIFY(s);
    return stack_code_ok;
}


enum stack_error_code stack_fn_destroy(STACK_COMMON_ARGS, struct stack_t *s)
{
    STACK_VERIFY(s);
    ASSERT_ADDRESS_READWRITE(s, sizeof(*s), "destruction [HEADER ACCESS]");
    ASSERT_ADDRESS_READWRITE(s->data, s->data_alloc * sizeof(*s->data), "destruction [DATA ACCESS]");
    free(s->data);
    s->data = NULL;
    s->data_len = -1;
    s->data_alloc = -1;
    stack_update_hashes(COMMON_ARGS_VALUE, s);
    s->hash.header ^= 0x5555555555555555LL;
    return stack_code_ok;
}


enum stack_error_code stack_fn_get_size(STACK_COMMON_ARGS, struct stack_t *s, ssize_t *size)
{
    STACK_VERIFY(s);
    ASSERT_ADDRESS_READ(s, sizeof(*s), "getting size [HEADER ACCESS]");
    if (size != NULL)
    {
        *size = s->data_len;
    }
    STACK_VERIFY(s);
    return stack_code_ok;
}


enum stack_error_code stack_fn_push(STACK_COMMON_ARGS, struct stack_t *s, stack_value_t value)
{
    STACK_VERIFY(s);
    ASSERT_ADDRESS_READWRITE(s, sizeof(*s), "push [HEADER ACCESS]");
    ASSERT_ADDRESS_READWRITE(s->data, s->data_alloc * sizeof(*s->data), "push [DATA ACCESS]");
    if (s->data_len == s->data_alloc)
    {
        s->data_alloc = 2 * s->data_alloc + !(s->data_alloc);
        stack_value_t *ptr = realloc(s->data, sizeof(*s->data) * s->data_alloc);
        if (ptr == NULL)
        {
            return stack_no_memory_error;
        }
        s->data = ptr;
        #ifdef STACK_FILL_RANDOM_AFTER_ALLOCATION
        {
            ssize_t begin_size = (ssize_t)sizeof(*s->data) * s->data_len;
            ssize_t total_size = (ssize_t)sizeof(*s->data) * s->data_alloc;
            for (ssize_t i = begin_size; i < total_size; ++i)
            {
                ((char *)s->data)[i] = rand() | 0x88;
            } 
        }
        #endif
        ASSERT_ADDRESS_READWRITE(s->data, s->data_alloc * sizeof(*s->data), "push after reallocation [DATA ACCESS]");
    }
    s->data[s->data_len++] = value;
    stack_update_hashes(COMMON_ARGS_VALUE, s);
    STACK_VERIFY(s);
    return stack_code_ok;
}


enum stack_error_code stack_fn_pop(STACK_COMMON_ARGS, struct stack_t *s, stack_value_t *pValue)
{
    STACK_VERIFY(s);
    if (s->data_len == 0)
    {
        return stack_pop_empty_error;
    }
    if (pValue != NULL)
    {
        *pValue = s->data[--s->data_len];
    }
    else
    {
        s->data_len--;
    }
    stack_update_hashes(COMMON_ARGS_VALUE, s);    
    STACK_VERIFY(s);
    return stack_code_ok;
}

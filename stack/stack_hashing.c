#include "stdlib.h"

#include "stack.h"
#include "stack_hashing.h"
#include "stack_memory_checks.h"


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




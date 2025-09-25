#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "stdlib.h"
#include "assert.h"
#include "stack.h"



#ifdef _WIN32
    #include "Windows.h"
    #define stack_GetCurrentThreadId() GetCurrentThreadId()
#else
    #include "pthread.h"
    #define stack_GetCurrentThreadId pthread_self()
#endif

#ifndef NDEBUG

    /* will strongly slower code on big arrays */
    #define STACK_HASH_ALL_ALLOCATED_CONTENT
    
    /* will for a bit slower code on big arrays */
    #define STACK_FILL_RANDOM_AFTER_ALLOCATION

    #define STACK_MAX_HASHING_CONTENT_LENGTH 1024
    
    #define STACK_MAX_PRINT_CONTENT_LENGTH 64
    
    #define STACK_DEBUG_PRINT(...) fprintf(stderr, __VA_ARGS__)
    
    #define CHECK(f) do{int error_code = 0; if ((error_code = (f)) != 0) { return error_code; }}while(0)
    
#else

    #define STACK_MAX_HASHING_CONTENT_LENGTH 0
    
    #define STACK_MAX_PRINT_CONTENT_LENGTH 0

    #define STACK_DEBUG_PRINT(...)
    
    #define CHECK(f)
    
#endif


uint64_t calculate_hash(void *data, size_t length)
{
    if (data == NULL || length == 0) return 0;
    char *ptr_data = data;
    uint64_t hash = 0x0123456789ABCDEFULL;
    for (size_t i = 0; i < length; ++i)
    {
        hash *= 998244353;
        hash += 1 + *ptr_data++;
    }
    return hash;
}


uint64_t calculate_header_hash(struct stack_t *s)
{
    if (s == NULL) return 0;
    return calculate_hash((char *)s + sizeof(uint64_t), sizeof(*s) - sizeof(uint64_t));
}

uint64_t calculate_content_hash(struct stack_t *s)
{
    if (s == NULL) return 0;
    #ifdef STACK_HASH_ALL_ALLOCATED_CONTENT
        return calculate_hash(s->data, sizeof(*s->data) * s->data_alloc);
    #else
        ssize_t end_length = STACK_MAX_HASHING_CONTENT_LENGTH >> 1;
        ssize_t begin_length = STACK_MAX_HASHING_CONTENT_LENGTH - end_length;
        if (end_length + begin_length < s->data_len)
        {
            return calculate_hash(s->data,                            sizeof(*s->data) * begin_length) ^ 
                   calculate_hash(s->data + s->data_len - end_length, sizeof(*s->data) * end_length);
        }
        return calculate_hash(s->data, sizeof(*s->data) * s->data_len);
    #endif
}


enum stack_error_code stack_update_hashes(struct stack_t *s)
{
    /* 1. compute content hash */
    s->hash.content = calculate_content_hash(s);
    /* 2. compute header hash, becouse it depends on content hash value */
    s->hash.header = calculate_header_hash(s);
    return stack_code_ok;
}


enum stack_error_code stack_print_elements(struct stack_t *s, ssize_t first, ssize_t last)
{
    ssize_t element = 0;

    STACK_DEBUG_PRINT("stack data content:\n");
    for (ssize_t i = 0; i < first && element < s->data_len; ++i, ++element)
    {
        STACK_DEBUG_PRINT("    data[%zd] %d\n", element, s->data[element]);
    }
    if (element < s->data_len - last)
    {
        STACK_DEBUG_PRINT("    data[%zd..%zd] = ...\n", element, s->data_len - last - 1);
        element = s->data_len - last;
    }
    for (ssize_t i = 0; i < last && element < s->data_len; ++i, ++element)
    {
        STACK_DEBUG_PRINT("    data[%zd] %d\n", element, s->data[element]);
    }
}


#define STACK_VALIDATE(s) CHECK(stack_validate(__FILE__, __FUNCTION__, __LINE__, s))
enum stack_error_code stack_validate(const char *file, const char *func, int line, struct stack_t *s)
{
    /* 1. easy check - if stack is null */
    if (s == NULL)
    {
        STACK_DEBUG_PRINT("Error at %s:%s:%d\n", file, func, line);
        STACK_DEBUG_PRINT("!> given stack is null\n");
        STACK_DEBUG_PRINT("stack [%p]\n", s);
        return stack_validation_error;
    }

    /* 2. check header hash */
    uint64_t real_header_hash = calculate_header_hash(s);
    if (real_header_hash != s->hash.header)
    {
        STACK_DEBUG_PRINT("Error at %s:%s:%d\n", file, func, line);
        STACK_DEBUG_PRINT("!> given stack's header was moditified outside\n");
        STACK_DEBUG_PRINT("!> found %llx instead of %llx\n", s->hash.header, real_header_hash);
        STACK_DEBUG_PRINT("stack [%p] : \n", s);
        STACK_DEBUG_PRINT("{\n");
        STACK_DEBUG_PRINT("    hash:       [header: %016llx content: %016llx] [SPOILED?]\n", s->hash.header, s->hash.content);
        STACK_DEBUG_PRINT("    data:       %p  [SPOILED?]\n", s->data);
        STACK_DEBUG_PRINT("    data_len:   %016zd  [SPOILED?]\n", s->data_len);
        STACK_DEBUG_PRINT("    data_alloc: %016zd  [SPOILED?]\n", s->data_alloc);
        STACK_DEBUG_PRINT("}\n");
        return stack_validation_error;
    }

    /* 3. check caller thread */
    stack_thread_type_t current_thread = stack_GetCurrentThreadId();
    if (s->creator_thread != current_thread)
    {
        STACK_DEBUG_PRINT("Error at %s:%s:%d\n", file, func, line);
        STACK_DEBUG_PRINT("!> use of stack from another thread \n");
        STACK_DEBUG_PRINT("!> This stack doesn't support multithreaded usage.\n");
        #ifdef _WIN32
            STACK_DEBUG_PRINT("!> stack was created in %lu thread.\n", s->creator_thread);
            STACK_DEBUG_PRINT("!> but now used from    %lu thread.\n", current_thread);
        #endif
        STACK_DEBUG_PRINT("stack [%p] : \n", s);
        STACK_DEBUG_PRINT("{\n");
        STACK_DEBUG_PRINT("    hash:       [header: %llx content: %llx] [CORRECT]\n", s->hash.header, s->hash.content);
        STACK_DEBUG_PRINT("    data:       %p\n", s->data);
        STACK_DEBUG_PRINT("    data_len:   %016zd\n", s->data_len);
        STACK_DEBUG_PRINT("    data_alloc: %016zd\n", s->data_alloc);
        STACK_DEBUG_PRINT("}\n");
        return stack_validation_error;
    }
    
    /* 3. check header fields on normal data */
    if (s->data == NULL && s->data_alloc != 0)
    {
        STACK_DEBUG_PRINT("Error at %s:%s:%d\n", file, func, line);
        STACK_DEBUG_PRINT("!> given stack's data is NULL\n");
        STACK_DEBUG_PRINT("stack [%p] : \n", s);
        STACK_DEBUG_PRINT("{\n");
        STACK_DEBUG_PRINT("    hash:       [header: %llx content: %llx] [CORRECT]\n", s->hash.header, s->hash.content);
        STACK_DEBUG_PRINT("    data:       %p\n", s->data);
        STACK_DEBUG_PRINT("    data_len:   %016zd\n", s->data_len);
        STACK_DEBUG_PRINT("    data_alloc: %016zd\n", s->data_alloc);
        STACK_DEBUG_PRINT("}\n");
        return stack_validation_error;
    }    
    if (s->data_alloc < 0)
    {
        STACK_DEBUG_PRINT("Error at %s:%s:%d\n", file, func, line);
        STACK_DEBUG_PRINT("!> given stack's data_alloc is less than zero\n");
        STACK_DEBUG_PRINT("stack [%p] : \n", s);
        STACK_DEBUG_PRINT("{\n");
        STACK_DEBUG_PRINT("    hash:       [header: %llx content: %llx] [CORRECT]\n", s->hash.header, s->hash.content);
        STACK_DEBUG_PRINT("    data:       %p\n", s->data);
        STACK_DEBUG_PRINT("    data_len:   %016zd\n", s->data_len);
        STACK_DEBUG_PRINT("    data_alloc: %016zd  [ < 0 ]\n", s->data_alloc);
        STACK_DEBUG_PRINT("}\n");
        return stack_validation_error;
    }
    if (s->data_len < 0)
    {
        STACK_DEBUG_PRINT("Error at %s:%s:%d\n", file, func, line);
        STACK_DEBUG_PRINT("!> given stack's data_len is less than zero\n");
        STACK_DEBUG_PRINT("stack [%p] : \n", s);
        STACK_DEBUG_PRINT("{\n");
        STACK_DEBUG_PRINT("    hash:       [header: %llx content: %llx] [CORRECT]\n", s->hash.header, s->hash.content);
        STACK_DEBUG_PRINT("    data:       %p\n", s->data);
        STACK_DEBUG_PRINT("    data_len:   %016zd  [ < 0 ]\n", s->data_len);
        STACK_DEBUG_PRINT("    data_alloc: %016zd\n", s->data_alloc);
        STACK_DEBUG_PRINT("}\n");
        return stack_validation_error;
    }
    if (s->data_len > s->data_alloc)
    {
        STACK_DEBUG_PRINT("Error at %s:%s:%d\n", file, func, line);
        STACK_DEBUG_PRINT("!> given stack's data_len is greated than data_alloc\n");
        STACK_DEBUG_PRINT("stack [%p] : \n", s);
        STACK_DEBUG_PRINT("{\n");
        STACK_DEBUG_PRINT("    hash:       [header: %llx content: %llx] [CORRECT]\n", s->hash.header, s->hash.content);
        STACK_DEBUG_PRINT("    data:       %p\n", s->data);
        STACK_DEBUG_PRINT("    data_len:   %016zd  [ > %016zd ]\n", s->data_len, s->data_alloc);
        STACK_DEBUG_PRINT("    data_alloc: %016zd  [ < %016zd ]\n", s->data_alloc, s->data_len);
        STACK_DEBUG_PRINT("}\n");
        return stack_validation_error;
    }

    /* 4. check content hash */
    uint64_t real_content_hash = calculate_content_hash(s);
    if (real_content_hash != s->hash.content)
    {
        STACK_DEBUG_PRINT("Error at %s:%s:%d\n", file, func, line);
        STACK_DEBUG_PRINT("!> given stack's content was moditified outside\n");
        STACK_DEBUG_PRINT("!> found %llx instead of %llx\n", s->hash.content, real_content_hash);
        STACK_DEBUG_PRINT("stack [%p] : \n", s);
        STACK_DEBUG_PRINT("{\n");
        STACK_DEBUG_PRINT("    hash:       [header: %llx content: %llx] [CORRECT]\n", s->hash.header, s->hash.content);
        STACK_DEBUG_PRINT("    data:       %p  [CORRECT]\n", s->data);
        STACK_DEBUG_PRINT("    data_len:   %016zd  [CORRECT]\n", s->data_len);
        STACK_DEBUG_PRINT("    data_alloc: %016zd  [CORRECT]\n", s->data_alloc);
        
        ssize_t print_end = STACK_MAX_PRINT_CONTENT_LENGTH >> 1;
        ssize_t print_begin = STACK_MAX_PRINT_CONTENT_LENGTH - print_end;
        stack_print_elements(s, print_begin, print_end);
        
        STACK_DEBUG_PRINT("}\n");
        
        return stack_validation_error;
    }

    /* structure is right */
    return stack_code_ok;
}

#define STACK_VERIFY(s) CHECK(stack_verify(__FILE__, __FUNCTION__, __LINE__, s))
enum stack_error_code stack_verify(const char *file, const char *func, int line, struct stack_t *s)
{
    CHECK(stack_validate(file, func, line, s));
    return stack_code_ok;
}


enum stack_error_code stack_init(struct stack_t *s)
{
    if (s == NULL)
    {
        STACK_DEBUG_PRINT("Error at %s:%s:%d\n", __FILE__, __FUNCTION__, __LINE__);
        STACK_DEBUG_PRINT("!> given stack pointer is NULL\n");
        return stack_validation_error;
    }
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
    #ifdef STACK_FILL_RANDOM_AFTER_ALLOCATION
    {
        ssize_t total_size = (ssize_t)sizeof(*s->data) * s->data_alloc;
        for (ssize_t i = 0; i < total_size; ++i)
        {
            ((char *)s->data)[i] = rand();
        } 
    }
    #endif
    stack_update_hashes(s);
    STACK_VERIFY(s);
    return stack_code_ok;
}


enum stack_error_code stack_destroy(struct stack_t *s)
{
    STACK_VERIFY(s);
    free(s->data);
    s->data = NULL;
    s->data_len = -1;
    s->data_alloc = -1;
    stack_update_hashes(s);
    return stack_code_ok;
}


enum stack_error_code stack_get_size(struct stack_t *s, ssize_t *size)
{
    STACK_VERIFY(s);
    if (size != NULL)
    {
        *size = s->data_len;
    }
    return stack_code_ok;
}


enum stack_error_code stack_push(struct stack_t *s, stack_value_t value)
{
    STACK_VERIFY(s);
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
                ((char *)s->data)[i] = rand();
            } 
        }
        #endif
    }
    s->data[s->data_len++] = value;
    stack_update_hashes(s);
    STACK_VERIFY(s);
    return stack_code_ok;
}


enum stack_error_code stack_pop(struct stack_t *s, stack_value_t *pValue)
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
    stack_update_hashes(s);    
    STACK_VERIFY(s);
    return stack_code_ok;
}

#ifdef _WIN32
    #define __USE_MINGW_ANSI_STDIO 1
#endif
#include "stdio.h"
#include "stdlib.h"
#include "inttypes.h"
#include "string.h"

#include "stack.h"
#include "stack_config.h"
#include "stack_hashing.h"
#include "stack_macro_args.h"
#include "stack_memory_checks.h"



#ifdef _WIN32
    #include "Windows.h"
    #define stack_GetCurrentThreadId() GetCurrentThreadId()
#else
    #include "pthread.h"
    #define stack_GetCurrentThreadId pthread_self()
#endif



enum stack_error_code stack_print_elements(STACK_COMMON_ARGS, struct stack_t *s, ssize_t first, ssize_t last)
{
    ssize_t element = 0;
    

    STACK_DEBUG_PRINT("stack data content:\n");

    ASSERT_ADDRESS_READ(s->data, s->data_alloc * sizeof(*s->data), "printing elements [DATA ACCESS]");
    
    for (ssize_t i = 0; i < first && element < s->data_len; ++i, ++element)
    {
        STACK_DEBUG_PRINT("    data[%08zd] = %d\n", element, s->data[element]);
    }
    if (element < s->data_len - last)
    {
        STACK_DEBUG_PRINT("    data[%zd..%zd] = ...\n", element, s->data_len - last - 1);
        element = s->data_len - last;
    }
    for (ssize_t i = 0; i < last && element < s->data_len; ++i, ++element)
    {
        STACK_DEBUG_PRINT("    data[%08zd] = %d\n", element, s->data[element]);
    }
}


#define STACK_VALIDATE(s) CHECK(stack_validate(COMMON_ARGS_VALUE, s))
enum stack_error_code stack_validate(const char *file_name, const char *func_name, int line, struct stack_t *s)
{
    /* 1. easy check - if stack is null */
    if (s == NULL)
    {
        STACK_DEBUG_PRINT("Error at %s:%s:%d\n", file_name, func_name, line);
        STACK_DEBUG_PRINT("!> given stack is null\n");
        STACK_DEBUG_PRINT("stack [%p]\n", s);
        return stack_validation_error;
    }
    
    ASSERT_ADDRESS_READ(s, sizeof(*s), "stack pointer in validation [HEADER ACCESS]");

    /* 2. check header hash */
    uint64_t real_header_hash = calculate_header_hash(COMMON_ARGS_VALUE, s);
    if (real_header_hash != s->hash.header)
    {
        STACK_DEBUG_PRINT("Error at %s:%s:%d\n", file_name, func_name, line);
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
        STACK_DEBUG_PRINT("Error at %s:%s:%d\n", file_name, func_name, line);
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
        STACK_DEBUG_PRINT("Error at %s:%s:%d\n", file_name, func_name, line);
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
        STACK_DEBUG_PRINT("Error at %s:%s:%d\n", file_name, func_name, line);
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
        STACK_DEBUG_PRINT("Error at %s:%s:%d\n", file_name, func_name, line);
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
        STACK_DEBUG_PRINT("Error at %s:%s:%d\n", file_name, func_name, line);
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
    uint64_t real_content_hash = calculate_content_hash(COMMON_ARGS_VALUE, s);
    if (real_content_hash != s->hash.content)
    {
        STACK_DEBUG_PRINT("Error at %s:%s:%d\n", file_name, func_name, line);
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
        stack_print_elements(COMMON_ARGS_VALUE, s, print_begin, print_end);
        
        STACK_DEBUG_PRINT("}\n");
        
        return stack_validation_error;
    }

    /* structure is right */
    return stack_code_ok;
}

#define STACK_VERIFY(s) CHECK(stack_verify(COMMON_ARGS_VALUE, s))
enum stack_error_code stack_verify(STACK_COMMON_ARGS, struct stack_t *s)
{
    STACK_VALIDATE(s);
    return stack_code_ok;
}

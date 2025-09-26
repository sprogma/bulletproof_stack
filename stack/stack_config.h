#ifndef STACK_CONFIG
#define STACK_CONFIG



#define COMMON_ARGS_VALUE file_name, func_name, line
#define USE_MEMORY_CHECKS
#define USE_MEMORY_CHECKS_BAN_EXECUTE_WRITECOPY


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



#endif

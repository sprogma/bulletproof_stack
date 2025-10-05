#ifndef PARSER_COMMON
#define PARSER_COMMON

#include "inttypes.h"
#include "stdio.h"
#include "assert.h"

typedef uint64_t result_t;

#define HANDLE_ERROR(call) do { \
                             result_t error = 0; \
                             if ((error = (call)) != 0) { return error; } \
                         } while (0)


#ifndef NO_PRINT_ERROR
    #define PRINT_ERROR(...) log_error(__VA_ARGS__)
#else
    #define PRINT_ERROR(...)
#endif
#ifndef NO_PRINT_WARNING
    #define PRINT_WARNING(...) log_warning(__VA_ARGS__)
#else
    #define PRINT_WARNING(...)
#endif
#ifndef NO_PRINT_INFO
    #define PRINT_INFO(...) log_info(__VA_ARGS__)
#else
    #define PRINT_INFO(...)
#endif


void log_error(const char *fmt, ...);
void log_warning(const char *fmt, ...);
void log_info(const char *fmt, ...);


#endif

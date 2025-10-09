#ifndef LOGGER
#define LOGGER


#include "stdint.h"


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


#define HANDLE_ERROR(fncall) do{result_t err = 0; if ((err = (fncall)) != 0){return err;}}while(0)


typedef uint64_t result_t;

void log_error(const char *fmt, ...);
void log_warning(const char *fmt, ...);
void log_info(const char *fmt, ...);

#endif

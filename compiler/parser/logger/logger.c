#include "../common.h"
#include "stdarg.h"
#include "stdio.h"


void log_info(const char *fmt, ...)
{
    va_list myargs;
    va_start(myargs, fmt);
    
    fputs("INFO: ", stderr);
    vfprintf(stderr, fmt, myargs);
    putc('\n', stderr);
    
    va_end(myargs);
}

void log_warning(const char *fmt, ...)
{
    va_list myargs;
    va_start(myargs, fmt);
    
    fputs("WARNING: ", stderr);
    vfprintf(stderr, fmt, myargs);
    putc('\n', stderr);
    
    va_end(myargs);
}


void log_error(const char *fmt, ...)
{
    va_list myargs;
    va_start(myargs, fmt);
    
    fputs("ERROR: ", stderr);
    vfprintf(stderr, fmt, myargs);
    putc('\n', stderr);
    
    va_end(myargs);
}

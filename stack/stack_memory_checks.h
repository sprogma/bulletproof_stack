#ifndef STACK_MEMORY_CHECKS
#define STACK_MEMORY_CHECKS


#include "stdlib.h"


#define ASSERT_ADDRESS_READ(ptr, size, msg) do{if (assert_address_mapped_read(COMMON_ARGS_VALUE, ptr, size, msg) != 0){return stack_invalid_memory_error;}}while(0)
int assert_address_mapped_read(const char *file_name, const char *func_name, int line, void *address, size_t length, const char *call_from_message);

#define ASSERT_ADDRESS_READWRITE(ptr, size, msg) do{if (assert_address_mapped_readwrite(COMMON_ARGS_VALUE, ptr, size, msg) != 0){return stack_invalid_memory_error;}}while(0)
int assert_address_mapped_readwrite(const char *file_name, const char *func_name, int line, void *address, size_t length, const char *call_from_message);


#endif

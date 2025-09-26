#ifdef _WIN32
    #define __USE_MINGW_ANSI_STDIO 1
#endif
#include "stdio.h"
#include "stdlib.h"
#include "assert.h"


#include "stack.h"
#include "stack_config.h"


#ifdef _WIN32
    #include "Windows.h"
#else
    #warning Linux doesnt support normal memory mappings check. Using simple ptr > 4096
#endif


int is_address_mapped_read(void *address, size_t size)
{
    #ifndef USE_MEMORY_CHECKS
    return 1;
    #endif
    void *end_address = (char *)address + size;
    #ifdef _WIN32
        while (address < end_address)
        {
            MEMORY_BASIC_INFORMATION info;
            if (VirtualQuery(address, &info, sizeof(info)) == 0)
            {
                printf("VirtualQuerry ERROR: %ld\n", GetLastError());
                return 0;
            }
            if (info.State != MEM_COMMIT)
            {
                return 0;
            }
            if (info.AllocationProtect != PAGE_EXECUTE_READ && 
                info.AllocationProtect != PAGE_EXECUTE_READWRITE && 
                #ifndef USE_MEMORY_CHECKS_BAN_EXECUTE_WRITECOPY
                    info.AllocationProtect != PAGE_EXECUTE_WRITECOPY && 
                #endif
                info.AllocationProtect != PAGE_READONLY && 
                info.AllocationProtect != PAGE_READWRITE && 
                info.AllocationProtect != PAGE_WRITECOPY)
            {
                return 0;
            }
            address = address + 4096;
            void *end_of_allocation = info.AllocationBase + info.RegionSize - 4096;
            if (info.AllocationBase + info.RegionSize > address)
            {
                address = end_of_allocation;
            }
        }
        return 1;
    #else 
        #warning Linux doesnt support normal memory mappings check. Using simple ptr > 4096
        return (size_t)address > 4096;
    #endif
};


int is_address_mapped_readwrite(void *address, size_t size)
{
    #ifndef USE_MEMORY_CHECKS
    return 1;
    #endif
    void *end_address = (char *)address + size;
    #ifdef _WIN32
        while (address < end_address)
        {
            MEMORY_BASIC_INFORMATION info;
            if (VirtualQuery(address, &info, sizeof(info)) == 0)
            {
                printf("VireualQuerry ERROR: %ld\n", GetLastError());
                return 0;
            }
            if (info.State != MEM_COMMIT)
            {
                return 0;
            }
            if (info.AllocationProtect != PAGE_EXECUTE_READWRITE && 
                #ifndef USE_MEMORY_CHECKS_BAN_EXECUTE_WRITECOPY
                    info.AllocationProtect != PAGE_EXECUTE_WRITECOPY &&
                #endif
                info.AllocationProtect != PAGE_READWRITE && 
                info.AllocationProtect != PAGE_WRITECOPY)
            {
                return 0;
            }
            address = address + 4096;
            void *end_of_allocation = info.AllocationBase + info.RegionSize - 4096;
            if (info.AllocationBase + info.RegionSize > address)
            {
                address = end_of_allocation;
            }
        }
        return 1;
    #else 
        #warning Linux doesnt support normal memory mappings check. Using simple ptr > 4096
        return (size_t)address > 4096;
    #endif
};


int assert_address_mapped_read(const char *file_name, const char *func_name, int line, // STACK_COMMON_ARGS
                               void *address, size_t length, const char *call_from_message)
{
    if (is_address_mapped_read(address, length) == 0)
    {
        STACK_DEBUG_PRINT("Error at %s:%s:%d\n", file_name, func_name, line);
        STACK_DEBUG_PRINT("In %s failed check:\n", call_from_message);
        STACK_DEBUG_PRINT("Memory mapping from %p of size %zu\n", address, length);
        STACK_DEBUG_PRINT("have no rights on READ\n");
        return 1;
    }
    return 0;
}

int assert_address_mapped_readwrite(const char *file_name, const char *func_name, int line, // STACK_COMMON_ARGS
                                    void *address, size_t length, const char *call_from_message)
{
    if (is_address_mapped_readwrite(address, length) == 0)
    {
        STACK_DEBUG_PRINT("Error at %s:%s:%d\n", file_name, func_name, line);
        STACK_DEBUG_PRINT("In %s failed check:\n", call_from_message);
        STACK_DEBUG_PRINT("Memory mapping from %p of size %zu\n", address, length);
        STACK_DEBUG_PRINT("have no rights on READ or WRITE\n");
        return 1;
    }
    return 0;
}

#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "malloc.h"
#include "string.h"
#include "sys/stat.h"
#include "fcntl.h"


#ifdef _WIN32
    #include "windows.h"
#endif


#ifdef VERBOSE
    #define VERBOSE_INFO(...) PRINT_INFO(__VA_ARGS__)
#else
    #define VERBOSE_INFO(...)
#endif


#define NOT_DEFINE_INTEGER_TYPES
#include "../utils/assembler.h"
#include "../utils/specs.h"
#include "../logger/logger.h"
#include "spu.h"


int main(int argc, char **argv)
{
    struct spu s = {};
    size_t entry_ptr = 0;

    for (int i = 1; i < argc; ++i)
    {
        if (strcmp(argv[i], "-map") == 0)
        {
            if (i + 1 < argc)
            {
                if (load_spu_port_mapping(&s, argv[i + 1]) != 0)
                {
                    PRINT_ERROR("load_spu_port_mapping error");
                    return 1;
                }

                i += 1; /* skip N parameters of -map flag */
                continue;
            }
            else
            {
                PRINT_ERROR("-map flag wasn't followed by mapping string");
                return 1;
            }
        }
        else if (strcmp(argv[i], "-mem") == 0)
        {
            if (s.mem != NULL)
            {
                PRINT_ERROR("-mem must be specified before any action which loads memory (for example -image flag) or there is two -mem flags");
                return 1;
            }
            if (i + 1 < argc)
            {
                char *end = NULL;
                size_t size = strtoull(argv[i + 1], &end, 0);
                if (*end != '\0')
                {
                    PRINT_ERROR("memory must be unsigned integer - memory size in bytes.");
                    return 1;
                }
                s.mem_size = size;

                i += 1; /* skip N parameters of -mem flag */
                continue;
            }
            else
            {
                PRINT_ERROR("-mem flag wasn't followed by memory size in bytes");
                return 1;
            }
        }
        else if (strcmp(argv[i], "-image") == 0)
        {
            if (i + 2 >= argc)
            {
                PRINT_ERROR("-image flag wasn't followed by image offset in bytes, and by path to file");
                return 1;
            }
            if (s.mem == NULL)
            {
                if (s.mem_size == 0)
                {
                    PRINT_INFO("Using default memory size: 64MB");
                    s.mem_size = 64 * 1024 * 1024;
                }
                allocate_memory(&s, s.mem_size);
            }
            
            /* load image into given address */
            char *end = NULL;
            size_t load_address = strtoull(argv[i + 1], &end, 0);
            if (*end != '\0')
            {
                PRINT_ERROR("image offset must be unsigned integer.");
                return 1;
            }
            char *image_filename = argv[i + 2];


            load_image(&s, image_filename, load_address);

            i += 2; /* skip N parameters of -image flag */
            continue;
        }
        else if (strcmp(argv[i], "-entry") == 0)
        {
            if (entry_ptr != 0)
            {
                PRINT_ERROR("-entry was passed twice; previous value: %zu", entry_ptr);
                return 1;
            }
            if (i + 1 < argc)
            {
                char *end = NULL;
                size_t size = strtoull(argv[i + 1], &end, 0);
                if (*end != '\0')
                {
                    PRINT_ERROR("entry offset must be unsigned integer - entry offset in bytes.");
                    return 1;
                }
                if (size == 0)
                {
                    PRINT_ERROR("entry offset must be non zero [zero is IP, so it is some wrong usage].");
                    return 1;
                }
                entry_ptr = size;

                i += 1; /* skip N parameters of -entry flag */
                continue;
            }
            else
            {
                PRINT_ERROR("-entry flag wasn't followed by entry offset size in bytes");
                return 1;
            }
        }
        else
        {
            PRINT_ERROR("Unknown flag: %s", argv[i]);
            return 1;
        }
    }
    
    if (s.mem == NULL)
    {
        PRINT_ERROR("no images provided.");
        return 1;
    }

    /* set instruction pointer */
    if (entry_ptr == 0)
    {
        ((uint32_t *)s.mem)[0] = 0x4000;
        PRINT_INFO("Using default entry pointer: %u", ((uint32_t *)s.mem)[0]);
    }
    else
    {
        if (entry_ptr >= s.mem_size)
        {
            PRINT_ERROR("entry offset is outsize of SPU memory. [%zu > %zu]", entry_ptr, s.mem_size);
            return 1;
        }
        ((uint32_t *)s.mem)[0] = entry_ptr;
    }

    PRINT_INFO("Running...");

    run(&s);
    
    #ifdef DUMP_MEM
        dump(s.mem, 0x3FF0, 0x4100);
    #endif
}


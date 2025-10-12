#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "malloc.h"
#include "string.h"
#include "sys/stat.h"
#include "fcntl.h"


#ifdef _WIN32
    #include "windows.h"
#endif


#define NOT_DEFINE_INTEGER_TYPES
#include "../utils/assembler.h"
#include "../utils/specs.h"
#include "../logger/logger.h"
#include "port_mappings/map.h"
#include "spu.h"



result_t create_port_mapping(struct spu *s, struct port_mapping_t *mapping, int port, char *command)
{
    if (strncmp(command, "tcp", 3) == 0)
    {
        return create_port_mapping_tcp(s, mapping, port, command);
    }
    else if (strncmp(command, "stdio", 5) == 0)
    {
        return create_port_mapping_stdio(s, mapping, port, command);
    }
    else if (strncmp(command, "hexstdio", 8) == 0)
    {
        return create_port_mapping_hex_stdio(s, mapping, port, command);
    }
    #ifdef SDL_MAPPINGS
    else if (strncmp(command, "audio", 5) == 0)
    {
        return create_port_mapping_audio(s, mapping, port, command);
    }
    else if (strncmp(command, "video", 5) == 0)
    {
        return create_port_mapping_video(s, mapping, port, command);
    }
    else if (strncmp(command, "keyboard", 8) == 0)
    {
        return create_port_mapping_keyboard(s, mapping, port, command);
    }
    else if (strncmp(command, "timer", 5) == 0)
    {
        return create_port_mapping_timer(s, mapping, port, command);
    }
    #endif
    PRINT_ERROR("Unknown port mapping command: %s", command);
    return 1;
}


result_t load_spu_port_mapping(struct spu *s, char *mapping_scheme)
{
    if (s->port_mappings_parsed != 0)
    {
        PRINT_ERROR("Port mappings were given twice");
        return 1;
    }
    s->port_mappings_parsed = 1;

    size_t count = 0;
    /* count mappings */
    {
        char *tmp = mapping_scheme;
        while (*tmp && isspace(*tmp)) { tmp++; }
        while (*tmp)
        {
            count += !isspace(tmp[0]) && (isspace(tmp[1]) || tmp[1] == 0);
            tmp++;
        }
    }   

    PRINT_INFO("Found %zd mappings.", count);
    s->port_mappings = malloc(sizeof(*s->port_mappings) * count);

    /* parse mappings */
    {
        char *tmp = mapping_scheme;
        for (size_t i = 0; i < count; ++i)
        {
            tmp = skip_leading_spaces(tmp);
            
            char buffer[128];
            int port;
            if (sscanf(tmp, "%d:%128s", &port, buffer) != 2)
            {
                free(s->port_mappings);
                return 1;
            }
            
            /* add mapping */
            s->port_mappings_len++;

            s->port_mappings[s->port_mappings_len - 1].port = port;
            if (create_port_mapping(s, &s->port_mappings[s->port_mappings_len - 1], port, buffer) != 0)
            {
                PRINT_ERROR("create_port_mapping error");
                return 1;
            }

            tmp = strchr(tmp, ' ');
        }
    }
    
    return 0;
}

    

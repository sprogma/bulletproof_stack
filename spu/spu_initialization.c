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
#include "port_mappings/map.h"
#include "spu.h"



int create_port_mapping(struct spu *s, struct port_mapping_t *mapping, int port, char *command)
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
    else if (strncmp(command, "audio", 5) == 0)
    {
        return create_port_mapping_audio(s, mapping, port, command);
    }
    fprintf(stderr, "Unknown port mapping command: %s\n", command);
    return 1;
}


int load_spu_port_mapping(struct spu *s, char *mapping_scheme)
{
    if (s->port_mappings_parsed != 0)
    {
        fprintf(stderr, "ERROR: Port mappings were given twice\n");
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

    printf("Found %zd mappings.\n", count);

    s->port_mappings = malloc(sizeof(*s->port_mappings) * count);

    /* parse mappings */
    {
        char *tmp = mapping_scheme;
        for (size_t i = 0; i < count; ++i)
        {
            while (*tmp && isspace(*tmp)) { tmp++; }
            
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
                fprintf(stderr, "create_port_mapping error\n");
                return 1;
            }

            while (*tmp && !isspace(*tmp)) { tmp++; }
        }
    }
    
    return 0;
}

    

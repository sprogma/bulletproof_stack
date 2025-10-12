#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "malloc.h"
#include "string.h"
#include "sys/stat.h"
#include "fcntl.h"


#ifdef _WIN32
    #include "windows.h"
    
    #define NOT_DEFINE_INTEGER_TYPES
#endif

#include "../../utils/assembler.h"
#include "../../utils/specs.h"
#include "../spu.h"
#include "map.h"

#include "SDL2/SDL.h"
#include "SDL2/SDL_audio.h"


static void read_port(struct port_mapping_t *mapping, BYTE *data, size_t count)
{
    (void)mapping;
    
    if (count != 4)
    {
        printf("Error: Reading from timer port, with size %zd, must be 4\n", count);
        return;
    }

    uint32_t res = SDL_GetTicks();
    *(uint32_t *)data = res;
}


int create_port_mapping_timer(struct spu *s, struct port_mapping_t *mapping, int port, char *command)
{
    (void)s;
    (void)command;

    if (!SDL_WasInit(SDL_INIT_TIMER))
    {
        SDL_Init(SDL_INIT_TIMER);
    }

    printf("Connect port %d to timer output\n", port);


    mapping->port = port;
    mapping->name = "timer";
    mapping->send = NULL;
    mapping->read = read_port;
    
    return 0;
}

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
    
    if (count != 8)
    {
        printf("Error: Reading from keyboard port, with size %zd, must be 8\n", count);
        return;
    }
    
    SDL_Event e;
    if (SDL_PollEvent(&e) == 0)
    {
        *(uint32_t *)(data) = 0;
        *(uint32_t *)(data + 4) = 0;
        return;
    }

    if (e.type == SDL_KEYDOWN)
    {
        *(uint32_t *)(data) = e.key.keysym.scancode;
        *(uint32_t *)(data + 4) = 0;
    }
    else if (e.type == SDL_KEYUP)
    {
        *(uint32_t *)(data) = e.key.keysym.scancode;
        *(uint32_t *)(data + 4) = 1;
    }
    else
    {
        /* skip unknown action */
        *(uint32_t *)(data) = 0;
        *(uint32_t *)(data + 4) = 0;
        return;
    }
}


int create_port_mapping_keyboard(struct spu *s, struct port_mapping_t *mapping, int port, char *command)
{
    (void)s;
    (void)command;

    if (!SDL_WasInit(SDL_INIT_EVENTS))
    {
        SDL_Init(SDL_INIT_EVENTS);
    }

    printf("Connect port %d to audio output\n", port);


    mapping->port = port;
    mapping->name = "keyboard";
    mapping->send = NULL;
    mapping->read = read_port;
    
    return 0;
}

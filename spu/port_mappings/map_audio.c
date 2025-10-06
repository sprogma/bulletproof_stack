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



static void send_port(struct port_mapping_t *mapping, BYTE *data, size_t count)
{
    if (SDL_QueueAudio((int)(size_t)mapping->private_data, data, count) < 0)
    {
        fprintf(stderr, "Error: audio mapping on port %d error in QueueAudio: %s\n", mapping->port, SDL_GetError());
    }
    SDL_PauseAudioDevice((int)(size_t)mapping->private_data, 0);
    printf("audio: writed %zd bytes\n", count);
    SDL_Delay(1000);
}


static void read_port(struct port_mapping_t *mapping, BYTE *data, size_t count)
{

    int queue_size = SDL_GetQueuedAudioSize((int)(size_t)mapping->private_data);
    ssize_t ncount = count;
    while (ncount > 0)
    {
        if (ncount > 4)
        {
            memcpy(data, &queue_size, ncount);
        }
        else
        {
            memcpy(data, &queue_size, ncount);
        }
        ncount -= 4;
    }
}


int create_port_mapping_audio(struct spu *s, struct port_mapping_t *mapping, int port, char *command)
{
    (void)s;
    (void)command;

    if (!SDL_WasInit(SDL_INIT_AUDIO))
    {
        SDL_Init(SDL_INIT_AUDIO);
    }

    printf("Connect port %d to audio output\n", port);

    SDL_AudioSpec want, have;
    SDL_zero(want);
    want.freq = 44100;
    want.format = AUDIO_S32SYS;
    want.channels = 1;
    want.samples = 4096;
    want.callback = NULL;

    SDL_AudioDeviceID audio_device = SDL_OpenAudioDevice(NULL, 0, &want, &have, 0);
    if (audio_device == 0) 
    {
        fprintf(stderr, "Failed to open audio device! SDL_Error: %s\n", SDL_GetError());
        SDL_Quit();
        return 1;
    }

    if (have.format != AUDIO_S32SYS)
    {
        fprintf(stderr, "This platfrom likely doen't support 32bit signed audio\n");
        return 1;
    }

    mapping->port = port;
    mapping->name = "audio";
    mapping->send = send_port;
    mapping->read = read_port;
    mapping->private_data = (void *)(size_t)audio_device;

    SDL_PauseAudioDevice((int)(size_t)mapping->private_data, 0);
    
    return 0;
}

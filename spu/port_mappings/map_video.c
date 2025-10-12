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


struct video_data
{
    int scale;
    int w, h;
    SDL_Window *win;
    SDL_Renderer *ren;
    SDL_Surface *src;
};



static void send_port(struct port_mapping_t *mapping, BYTE *data, size_t count)
{
    struct video_data *videodata = mapping->private_data;
    if (count < sizeof(Uint32) * videodata->w * videodata->h)
    {
        fprintf(stderr, "ERROR: video port received only %zd bytes, need %zd bytes\n", count, sizeof(Uint32) * videodata->w * videodata->h);
        return;
    }
    printf("video: writed %zd bytes\n", count);
    SDL_LockSurface(videodata->src);
    Uint32 *int_data = (Uint32 *)data;
    for (int y = 0; y < videodata->h; ++y)
    {
        for (int x = 0; x < videodata->w; ++x)
        {
            *(Uint32 *)((Uint8 *) videodata->src->pixels + 
                              y * videodata->src->pitch + 
                              x * videodata->src->format->BytesPerPixel) = int_data[y * videodata->w + x];
        }
    }
    SDL_UnlockSurface(videodata->src);
    SDL_Texture *txt = SDL_CreateTextureFromSurface(videodata->ren, videodata->src);
    SDL_SetTextureScaleMode(txt, SDL_ScaleModeLinear);
    SDL_RenderCopy(videodata->ren, txt, NULL, NULL);
    SDL_RenderPresent(videodata->ren);
    SDL_DestroyTexture(txt);
}


int create_port_mapping_video(struct spu *s, struct port_mapping_t *mapping, int port, char *command)
{
    (void)s;
    (void)command;

    if (!SDL_WasInit(SDL_INIT_VIDEO))
    {
        SDL_Init(SDL_INIT_VIDEO);
    }
    
    struct video_data *videodata = calloc(1, sizeof(*videodata));
    
        
    videodata->scale = 1;
    int num;
    if (sscanf(command, "video%d", &num) == 1)
    {
        videodata->scale = num;
    }

    videodata->w = 160;
    videodata->h = 90;
    char *title = calloc(1, 32);
    sprintf(title, "port %d", port);
    videodata->win = SDL_CreateWindow(title, SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, videodata->w * videodata->scale, videodata->h * videodata->scale, 0);
    videodata->ren = SDL_CreateRenderer(videodata->win, 0, 0);
    free(title);

    videodata->src = SDL_CreateRGBSurface(SDL_SWSURFACE, videodata->w, videodata->h, 32, 0, 0, 0, 0);

    printf("Connect port %d to video output with scale %d\n", port, videodata->scale);

    mapping->port = port;
    mapping->name = "video";
    mapping->send = send_port;
    mapping->read = NULL;
    mapping->private_data = videodata;
    
    return 0;
}

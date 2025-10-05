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
#include "../../utils/assembler.h"
#include "../../utils/specs.h"
#include "../spu.h"
#include "map.h"



static void send_port(struct port_mapping_t *mapping, BYTE *data, size_t count)
{    
    for (size_t i = 0; i < count; ++i)
    {
        printf("OUT %d> %02x\n", mapping->port, data[i]);
    }
}


static void read_port(struct port_mapping_t *mapping, BYTE *data, size_t count)
{   
    for (size_t i = 0; i < count; ++i)
    {
        printf("READ %d [enter data: hex byte]> ", mapping->port);
        int x;
        scanf("%x", &x);
        data[i] = x;
    }
}


int create_port_mapping_hex_stdio(struct spu *s, struct port_mapping_t *mapping, int port, char *command)
{
    (void)s;
    (void)command;
    
    printf("Connect port %d to hex stdio\n", port);

    mapping->port = port;
    mapping->name = "stdio";
    mapping->send = send_port;
    mapping->read = read_port;
    
    return 0;
}

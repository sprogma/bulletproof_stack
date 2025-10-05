#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "malloc.h"
#include "string.h"
#include "sys/stat.h"
#include "fcntl.h"


#ifdef _WIN32
    #include "windows.h"
    #include "WinSock2.h"
    #include "WS2tcpip.h"
#endif


#define NOT_DEFINE_INTEGER_TYPES
#include "../../utils/assembler.h"
#include "../../utils/specs.h"
#include "../spu.h"
#include "map.h"


#ifdef _WIN32


// struct win_socket_t
// {
//     
// };
    
#endif



int create_port_mapping_tcp(struct spu *s, struct port_mapping_t *mapping, int port, char *command)
{   
    (void)s;
    
    #ifndef _WIN32
    (void)mapping;
    (void)port;
    
    fprintf(stderr, "tcp ports mappings are unsupported on not Windows platforms\n");
    return 1;
    #endif
    fprintf(stderr, "tcp ports mappings are unsupported at all.\n");
    return 1;
    
    int num = 0;
    if (strcmp(command, "tcp") == 0)
    {
        num = -1;
    }
    else if (scanf("tcp%d", &num) != 1)
    {
        fprintf(stderr, "Error: tcp mapping doesn't followed by port number, nor empty 'tcp' command\n");
        return 1;
    }
    printf("Open tcp connection on %d\n", num);

    /* create socket structure */
    WSADATA wsData;
    int werr = WSAStartup(MAKEWORD(2,2), &wsData);
    if (werr != 0)
    {
        fprintf(stderr, "Error: WSAStartup: %d\n", WSAGetLastError());
        return 1;
    }

    SOCKET ServSock = socket(AF_INET, SOCK_STREAM, 0);
    if (ServSock == INVALID_SOCKET) {
        fprintf(stderr, "Error: socket creation: %d\n", WSAGetLastError());
        closesocket(ServSock);
        WSACleanup();
        return 1;
    }

    mapping->port = port;
    mapping->name = "stdio";
    // mapping->send = send_port;
    // mapping->read = read_port;
    
    return 1;
}


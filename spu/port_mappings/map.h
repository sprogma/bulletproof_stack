#ifndef PORT_MAPPINGS
#define PORT_MAPPINGS


#include "../spu.h"
#include "../../utils/assembler.h"


/* pipes to stdio */
int create_port_mapping_stdio(struct spu *s, struct port_mapping_t *mapping, int port, char *command);


/* as stdio, but show hex values, useful in debuging */
int create_port_mapping_hex_stdio(struct spu *s, struct port_mapping_t *mapping, int port, char *command);


/* pipes to tcp socket */
int create_port_mapping_tcp(struct spu *s, struct port_mapping_t *mapping, int port, char *command);


#endif

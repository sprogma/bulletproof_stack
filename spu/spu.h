#ifndef SPU_HEADER
#define SPU_HEADER

#include "../utils/assembler.h"


struct port_mapping_t
{
    char *name;
    int32_t port;
    void (*send)(struct port_mapping_t *mapping, BYTE *data, size_t count);
    void (*read)(struct port_mapping_t *mapping, BYTE *data, size_t count);
    void *private_data;
};


struct spu
{
    BYTE *mem;
    size_t mem_size;

    struct port_mapping_t *port_mappings;
    size_t                 port_mappings_len;
    size_t                 port_mappings_parsed;
};



result_t load_spu_port_mapping(struct spu *s, char *mapping_scheme);


#endif

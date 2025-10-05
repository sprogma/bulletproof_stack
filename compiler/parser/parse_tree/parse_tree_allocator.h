#ifndef PARSE_TREE_ALLOCATOR
#define PARSE_TREE_ALLOCATOR

#include "../common.h"
#include "../api.h"

struct allocator_t
{
    struct parser_tree_node_t **buffers;
    int buffers_length;
    int buffers_alloc;
};

result_t allocator_create(struct allocator_t *allocator);
result_t allocator_destroy(struct allocator_t *allocator);
result_t allocator_create_node(struct allocator_t *allocator, struct parser_tree_node_t **buffer);
result_t allocator_destroy_node(struct allocator_t *allocator, struct parser_tree_node_t *buffer);

#endif

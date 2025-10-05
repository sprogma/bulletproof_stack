#include "parse_tree_allocator.h"
#include "stdlib.h"
#include "string.h"



result_t allocator_create(struct allocator_t *allocator)
{
    assert(allocator != NULL);

    allocator->buffers_length = 0;
    allocator->buffers_alloc = 0;

    return 0;
}


result_t allocator_destroy(struct allocator_t *allocator)
{
    assert(allocator != NULL);

    for (int i = 0; i < allocator->buffers_length; ++i)
    {
        free(allocator->buffers[i]);
    }

    free(allocator->buffers);

    allocator->buffers_length = 0;
    allocator->buffers_alloc = 0;

    return 0;
}


result_t allocator_create_node(struct allocator_t *allocator, struct parser_tree_node_t **buffer)
{
    assert(allocator != NULL);
    assert(buffer != NULL);

    if (allocator->buffers_length > 0)
    {
        *buffer = allocator->buffers[--allocator->buffers_length];
        memset(*buffer, 0, sizeof(**buffer));
        PRINT_INFO("Allocated %p", *buffer);
        return 0;
    }

    *buffer = calloc(1, sizeof(**buffer));
    PRINT_INFO("Allocated %p", *buffer);
    return 0;
}


result_t allocator_destroy_node(struct allocator_t *allocator, struct parser_tree_node_t *buffer)
{
    assert(allocator != NULL);
    assert(buffer != NULL);
    
    PRINT_INFO("Destroy %p", buffer);

    if (allocator->buffers_length >= allocator->buffers_alloc)
    {
        /* x = x * 2 + (!x) */
        allocator->buffers_alloc = allocator->buffers_alloc * 2 + (!allocator->buffers_alloc);
        
        struct parser_tree_node_t **new_ptr = realloc(allocator->buffers, 
                                                      sizeof(*allocator->buffers) * allocator->buffers_alloc);

        if (new_ptr == NULL)
        {
            PRINT_ERROR("No more memory");
            return 1;
        }

        allocator->buffers = new_ptr;
    }

    allocator->buffers[allocator->buffers_length++] = buffer;
    
    return 0;
}

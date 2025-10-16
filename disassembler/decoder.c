#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "assert.h"
#include "malloc.h"
#include "string.h"
#include "stdlib.h"
#include "ctype.h"


#include "../utils/assembler.h"


static result_t decode_instruction(struct output_buffer *s, BYTE *data, BYTE *end, int64_t *decoded_length)
{
    assert(data < end);
    
    int32_t length = decode_instruction_length(data);
    
    if (end - data < length)
    {
        PRINT_WARNING("Instruction length is greater than rest of file size. Parsing as byte");

        print_buffer(s, ".db 0x%02x\n", *data);
        
        *decoded_length = 1;
        return 0;
    }
    
    BYTE header = *data;

    const struct command *cmd = NULL;
    for (size_t i = 0; i < ARRAYLEN(native_commands); ++i)
    {
        if ((header & (~ARG_PTR_OPCODE_MASK)) == native_commands[i].code)
        {
            cmd = native_commands + i;
        }
    }

    if (cmd == NULL)
    {
        PRINT_WARNING("Unknown command. Parsing as bytes");
        print_buffer(s, ".db 0x%02x\n", *data);

        *decoded_length = 1;
        return 0;
    }
    
    if ((header & ARG_PTR_OPCODE_MASK) == ARG_PTR_ON_PTR)
    {    
        print_buffer(s, "$");
    }
    print_buffer(s, "%s", cmd->name);
    
    /* decode arguments */
    if (cmd->nargs > 0)
    {
        for (int a = 0; a < cmd->nargs; ++a)
        {
            int32_t ptr = *(int *)(data + 1 + 4 * a);
            if (a != 0)
            {
                print_buffer(s, ",");
            }
            print_buffer(s, " %d", ptr);
        }
    }

    print_buffer(s, "\n");
    
    *decoded_length = length;
    return 0;
}


result_t decode_program(BYTE *code, int64_t code_len, struct output_buffer *out)
{
    BYTE *code_end = code + code_len;

    while (code < code_end)
    {
        int64_t decoded_length;
        PRINT_INFO("Decoding from: %p/%p", code, code_end);
        HANDLE_ERROR(decode_instruction(out, code, code_end, &decoded_length));
        code += decoded_length;
    }

    return 0;
}


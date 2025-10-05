#define __USE_MINGW_ANSI_STDIO 1
#include "stdio.h"
#include "assert.h"
#include "malloc.h"
#include "string.h"
#include "stdlib.h"
#include "ctype.h"


#include "../utils/assembler.h"


static int decode_instruction(struct string_output_buffer *s, BYTE *data, BYTE *end, size_t *decoded_length)
{
    if (data >= end)
    {
        return 0;
    }

    BYTE header = *data;
    int32_t length = decode_instruction_length(data);
    
    /* for each command: try to guess it */
    
    if (end - data >= length)
    {
        if ((header & ARG_PTR_OPCODE_MASK) == ARG_PTR_ON_PTR)
        {
            reserve_string_output_buffer(s, s->len + 1);
            
            s->buffer[s->len] = '$';
            s->len++;
        }
        for (ssize_t i = 0; i < (ssize_t)sizeof(native_commands) / (ssize_t)sizeof(*native_commands); ++i)
        {
            size_t name_len = strlen(native_commands[i].name);
            if ((header & (~ARG_PTR_OPCODE_MASK)) == native_commands[i].code)
            {
                reserve_string_output_buffer(s, s->len + name_len + 128);
                memcpy(s->buffer + s->len, native_commands[i].name, name_len);
                s->len += name_len;
                
                /* decode arguments */
                if (native_commands[i].nargs > 0)
                {
                    s->len += sprintf(s->buffer + s->len, " ");
                    for (int a = 0; a < native_commands[i].nargs; ++a)
                    {
                        int32_t ptr = 0;
                        memcpy(&ptr, data + 1 + 4 * a, sizeof(ptr));
                        if (a != 0)
                        {
                            s->len += sprintf(s->buffer + s->len, ", ");
                        }
                        s->len += sprintf(s->buffer + s->len, "%d", ptr);
                    }
                }
                
                s->buffer[s->len] = '\n';
                s->len++;
            }
        }
        *decoded_length = length;
        return 0;
    }

    reserve_string_output_buffer(s, s->len + 3 + 1 + 6);
    memcpy(s->buffer + s->len, ".db 0x", 3 + 1 + 2);
    s->len += 3 + 1 + 2;
    
    sprintf(s->buffer + s->len, "%02x", *data);
    s->len += 2;
    
    s->buffer[s->len] = '\n';
    s->len++;
    
    *decoded_length = 1;
    
    return 0;
}


int decode_program(BYTE *code, ssize_t code_len, struct string_output_buffer *out)
{
    BYTE *code_end = code + code_len;

    while (code < code_end)
    {
        size_t decoded_length;
        decode_instruction(out, code, code_end, &decoded_length);
        code += decoded_length;
    }
}


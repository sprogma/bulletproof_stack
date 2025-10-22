
INSTRUCTION( O_NOP, "NOP", 0, 0, (0b00000 | ARG_NUM_0),
    VERBOSE_INFO("NOP\n");
)

INSTRUCTION( O_INT, "INT", 2, 1, (0b00000 | ARG_NUM_2),
    int32_t type = get_command_arg(s, ip, 0);
    int32_t ptr  = rel_to_abs(s, ip, get_command_arg(s, ip, 1));

    (void)type;
    (void)ptr;

    VERBOSE_INFO("Error: int command for now is unsopported [%d, %x].\n", type, ptr);
)

INSTRUCTION( O_MOV_CONST, "MOV_CONST", 2, 1, (0b00001 | ARG_NUM_2),
    uint32_t value = get_command_arg(s, ip, 0);
    int32_t ptr    = rel_to_abs(s, ip, get_command_arg(s, ip, 1));

    if ((opcode & ARG_PTR_OPCODE_MASK) == ARG_PTR_ON_PTR)
    {
        VERBOSE_INFO("ptr = *%08x=%08x\n", ptr, ptr_from_ptr(s, ptr));
        ptr = ptr_from_ptr(s, ptr);
    }

    VERBOSE_INFO("MOV_CONST set to %08x from %08x\n", ptr, value);
    *(int32_t *)ptr_to_memory(s, ptr) = value;
)

INSTRUCTION( O_LEA, "LEA", 2, 0, (0b00010 | ARG_NUM_2),
    int32_t dst = rel_to_abs(s, ip, get_command_arg(s, ip, 0));
    int32_t ptr = rel_to_abs(s, ip, get_command_arg(s, ip, 1));

    if ((opcode & ARG_PTR_OPCODE_MASK) == ARG_PTR_ON_PTR)
    {
        VERBOSE_INFO("dest = *%08x=%08x\n", dst, ptr_from_ptr(s, dst));
        dst = ptr_from_ptr(s, dst);
    }

    VERBOSE_INFO("LEA set to %08x = %08x\n", dst, ptr);
    *(int32_t *)ptr_to_memory(s, dst) = ptr;
)

INSTRUCTION( O_MOV, "MOV", 3, 0, (0b00000 | ARG_NUM_3),
    READ_DST_SRC_COUNT
    
    VERBOSE_INFO("MOV: set to %08x from %08x of length *%08x=%08x\n", dst, src, cnt, int_from(s, cnt));
    memmove(ptr_to_memory(s, dst), ptr_to_memory(s, src), int_from(s, cnt));
)

INSTRUCTION( O_INV, "INV", 3, 0, (0b00001 | ARG_NUM_3),
    READ_DST_SRC_COUNT

    VERBOSE_INFO("INV: set to %08x from %08x of length *%08x=%08x\n", dst, src, cnt, int_from(s, cnt));
    cnt = int_from(s, cnt);
    
    for (ssize_t i = 0; i < cnt; ++i)
    {
        s->mem[dst + i] = ~s->mem[src + i];
    }
)

INSTRUCTION(O_NEG, "NEG", 3, 0, (0b00010 | ARG_NUM_3),
    READ_DST_SRC_COUNT  

    VERBOSE_INFO("NEG: set to %08x from %08x of length *%08x=%08x\n", dst, src, cnt, int_from(s, cnt));
    cnt = int_from(s, cnt);

    for (ssize_t i = 0; i < cnt; ++i)
    {
        s->mem[dst + i] = ~s->mem[src + i];
    }
    large_integer_inc(ptr_to_memory(s, dst), cnt);
)

INSTRUCTION(O_INC, "INC", 3, 0, (0b00011 | ARG_NUM_3),
    READ_DST_SRC_COUNT  

    VERBOSE_INFO("INC: set to %08x from %08x of length *%08x=%08x\n", dst, src, cnt, int_from(s, cnt));
    cnt = int_from(s, cnt);

    if (dst != src)
    {
        memmove(ptr_to_memory(s, dst), ptr_to_memory(s, src), cnt);
    }
    large_integer_inc(ptr_to_memory(s, dst), cnt);
)

INSTRUCTION(O_DEC, "DEC", 3, 0, (0b00100 | ARG_NUM_3),
    READ_DST_SRC_COUNT  

    VERBOSE_INFO("DEC: set to %08x from %08x of length *%08x=%08x\n", dst, src, cnt, int_from(s, cnt));
    cnt = int_from(s, cnt);

    if (dst != src)
    {
        memmove(ptr_to_memory(s, dst), ptr_to_memory(s, src), cnt);
    }
    large_integer_dec(ptr_to_memory(s, dst), cnt);
)

INSTRUCTION(O_ALL, "ALL", 3, 0, (0b00101 | ARG_NUM_3),
    READ_DST_SRC_COUNT  

    VERBOSE_INFO("ALL: set to %08x from %08x of length *%08x=%08x\n", dst, src, cnt, int_from(s, cnt));
    cnt = int_from(s, cnt);

    BYTE total = 0xFF;
    for (ssize_t i = 0; i < cnt; ++i)
    {
        total &= s->mem[src + i];
    }
    *(int32_t *)ptr_to_memory(s, dst) = (total == 0xFF ? 0xFFFFFFFF : 0);
)

INSTRUCTION(O_ANY, "ANY", 3, 0, (0b00110 | ARG_NUM_3),
    READ_DST_SRC_COUNT  

    VERBOSE_INFO("ANY: set to %08x from %08x of length *%08x=%08x\n", dst, src, cnt, int_from(s, cnt));
    cnt = int_from(s, cnt);

    BYTE total = 0;
    for (ssize_t i = 0; i < cnt; ++i)
    {
        total |= s->mem[src + i];
    }
    *(int32_t *)ptr_to_memory(s, dst) = (total == 0 ? 0 : 0xFFFFFFFF);
)

INSTRUCTION(O_CLEA, "CLEA", 3, 0, (0b00111 | ARG_NUM_3),
    int32_t flg = rel_to_abs(s, ip, get_command_arg(s, ip, 0));
    int32_t dst = rel_to_abs(s, ip, get_command_arg(s, ip, 1));
    int32_t ptr = rel_to_abs(s, ip, get_command_arg(s, ip, 2));

    if ((opcode & ARG_PTR_OPCODE_MASK) == ARG_PTR_ON_PTR)
    {
        VERBOSE_INFO("dest = *%08x=%08x  flag = *%08x=%08x\n", dst, ptr_from_ptr(s, dst), flg, int_from(s, flg));
        flg = int_from(s, flg);
        dst = ptr_from_ptr(s, dst);
    }

    VERBOSE_INFO("CLEA set to %08x = %08x IF FLAG from %08x=%08x\n", dst, ptr, flg, int_from(s, flg));
    if (int_from(s, flg) != 0)
    {
        *(int32_t *)ptr_to_memory(s, dst) = ptr;
    }
)

INSTRUCTION(O_IN, "IN", 3, 1, (0b01000 | ARG_NUM_3),        
    int32_t port  = get_command_arg(s, ip, 0);
    int32_t ptr   = rel_to_abs(s, ip, get_command_arg(s, ip, 1));
    int32_t count = rel_to_abs(s, ip, get_command_arg(s, ip, 2));

    if ((opcode & ARG_PTR_OPCODE_MASK) == ARG_PTR_ON_PTR)
    {
        VERBOSE_INFO("ptr = *%08x=%08x  count = *%08x=%08x\n", ptr, int_from(s, ptr), count, int_from(s, count));
        ptr = ptr_from_ptr(s, ptr);
        count = int_from(s, count);
    }

    VERBOSE_INFO("IN read from port %08x data to %08x of count *%08x=%08x\n", port, ptr, count, int_from(s, count));
    read_port(s, port, ptr_to_memory(s, ptr), int_from(s, count));
)

INSTRUCTION(O_OUT, "OUT", 3, 1, (0b01001 | ARG_NUM_3),
    int32_t port  = get_command_arg(s, ip, 0);
    int32_t ptr   = rel_to_abs(s, ip, get_command_arg(s, ip, 1));
    int32_t count = rel_to_abs(s, ip, get_command_arg(s, ip, 2));

    if ((opcode & ARG_PTR_OPCODE_MASK) == ARG_PTR_ON_PTR)
    {
        VERBOSE_INFO("ptr = *%08x=%08x  count = *%08x=%08x\n", ptr, int_from(s, ptr), count, int_from(s, count));
        ptr = ptr_from_ptr(s, ptr);
        count = int_from(s, count);
    }

    VERBOSE_INFO("OUT send to port %08x data from %08x of count *%08x=%08x\n", port, ptr, count, int_from(s, count));
    send_port(s, port, ptr_to_memory(s, ptr), int_from(s, count));
)

INSTRUCTION(O_EQ, "EQ", 4, 0, (0b00000 | ARG_NUM_4),
    READ_DST_A_B_COUNT  

    VERBOSE_INFO("EQ: set to %08x from %08x and %08x of length *%08x=%08x\n", dst, a, b, cnt, int_from(s, cnt));
    cnt = int_from(s, cnt);

    for (ssize_t i = 0; i < cnt; ++i)
    {
        s->mem[dst + i] = ~(s->mem[a + i] ^ s->mem[b + i]);
    }
)

INSTRUCTION(O_OR, "OR", 4, 0, (0b00001 | ARG_NUM_4),
    READ_DST_A_B_COUNT  

    VERBOSE_INFO("OR: set to %08x from %08x and %08x of length *%08x=%08x\n", dst, a, b, cnt, int_from(s, cnt));
    cnt = int_from(s, cnt);

    for (ssize_t i = 0; i < cnt; ++i)
    {
        s->mem[dst + i] = s->mem[a + i] | s->mem[b + i];
    }
)

INSTRUCTION(O_AND, "AND", 4, 0, (0b00010 | ARG_NUM_4),
    READ_DST_A_B_COUNT  

    VERBOSE_INFO("AND: set to %08x from %08x and %08x of length *%08x=%08x\n", dst, a, b, cnt, int_from(s, cnt));
    cnt = int_from(s, cnt);

    for (ssize_t i = 0; i < cnt; ++i)
    {
        s->mem[dst + i] = s->mem[a + i] & s->mem[b + i];
    }
)

INSTRUCTION(O_XOR, "XOR", 4, 0, (0b00011 | ARG_NUM_4),
    READ_DST_A_B_COUNT  

    VERBOSE_INFO("XOR: set to %08x from %08x and %08x of length *%08x=%08x\n", dst, a, b, cnt, int_from(s, cnt));
    cnt = int_from(s, cnt);

    for (ssize_t i = 0; i < cnt; ++i)
    {
        s->mem[dst + i] = s->mem[a + i] ^ s->mem[b + i];
    }
)
INSTRUCTION(O_ADD, "ADD", 4, 0, (0b00100 | ARG_NUM_4),
    READ_DST_A_B_COUNT

    VERBOSE_INFO("ADD: set to %08x from %08x and %08x of length *%08x=%08x\n", dst, a, b, cnt, int_from(s, cnt));
    cnt = int_from(s, cnt);

    if (dst != a)
    {
        memmove(ptr_to_memory(s, dst), ptr_to_memory(s, a), cnt);
    }
    large_integer_add(ptr_to_memory(s, dst), ptr_to_memory(s, b), cnt);
)

INSTRUCTION(O_SUB, "SUB", 4, 0, (0b00101 | ARG_NUM_4),
    READ_DST_A_B_COUNT

    VERBOSE_INFO("SUB: set to %08x from %08x and %08x of length *%08x=%08x\n", dst, a, b, cnt, int_from(s, cnt));
    cnt = int_from(s, cnt);

    if (dst != a)
    {
        memmove(ptr_to_memory(s, dst), ptr_to_memory(s, a), cnt);
    }
    large_integer_sub(ptr_to_memory(s, dst), ptr_to_memory(s, b), cnt);
)

INSTRUCTION(O_MUL, "MUL", 4, 0, (0b00110 | ARG_NUM_4),
    READ_DST_A_B_COUNT

    VERBOSE_INFO("MUL: set to %08x from %08x and %08x of length *%08x=%08x\n", dst, a, b, cnt, int_from(s, cnt));
    cnt = int_from(s, cnt);

    if (dst != a)
    {
        memmove(ptr_to_memory(s, dst), ptr_to_memory(s, a), cnt);
    }
    large_integer_mul(ptr_to_memory(s, dst), ptr_to_memory(s, b), cnt);
)

INSTRUCTION(O_DIV, "DIV", 4, 0, (0b00111 | ARG_NUM_4),
    READ_DST_A_B_COUNT

    VERBOSE_INFO("DIV: set to %08x from %08x and %08x of length *%08x=%08x\n", dst, a, b, cnt, int_from(s, cnt));
    cnt = int_from(s, cnt);

    if (dst != a)
    {
        memmove(ptr_to_memory(s, dst), ptr_to_memory(s, a), cnt);
    }
    large_integer_div(ptr_to_memory(s, dst), ptr_to_memory(s, b), cnt);
)

INSTRUCTION(O_CMOV, "CMOV", 4, 0, (0b01000 | ARG_NUM_4),
    READ_DST_A_B_COUNT

    VERBOSE_INFO("CMOV: set to %08x from %08x of length *%08x=%08x ONLY IF %08x=%08x != 0\n", a, b, cnt, int_from(s, cnt), dst, int_from(s, dst));
    cnt = int_from(s, cnt);
    dst = int_from(s, dst);

    if (dst != 0)
    {
        memmove(ptr_to_memory(s, a), ptr_to_memory(s, b), cnt);
    }
)

INSTRUCTION(O_LT, "LT", 4, 0, (0b01001 | ARG_NUM_4),
    READ_DST_A_B_COUNT

    VERBOSE_INFO("LT: set to %08x from %08x and %08x of length *%08x=%08x\n", dst, a, b, cnt, int_from(s, cnt));
    cnt = int_from(s, cnt);

    *(int32_t *)ptr_to_memory(s, dst) = large_integer_less(ptr_to_memory(s, a), ptr_to_memory(s, b), cnt);
)


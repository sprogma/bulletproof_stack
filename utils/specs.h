#ifndef SPECS
#define SPECS


#define MAX_COMMAND_ARGUMENTS 4
/* in bytes */
#define MAX_INSTRUCTION_LENGTH 64
#define MAX_MACRO_INSTRUCTION_LENGTH 64



#define ARG_PTR_OPCODE_MASK  0b10000000
#define ARG_PTR              0b00000000
#define ARG_PTR_ON_PTR       0b10000000

#define ARG_NUM_OPCODE_MASK  0b01100000
#define ARG_NUM_0            0b00000000
// DEPRECATED BEFORE IMPLEMENTATION #define ARG_NUM_1           0b00100000
#define ARG_NUM_2            0b00100000
#define ARG_NUM_3            0b01000000
#define ARG_NUM_4            0b01100000


//! 
#define O_NOP                (0b00000 | ARG_NUM_0)


//! (INDEX: const 4 byte) (DATA: void*)
#define O_INT                (0b00000 | ARG_NUM_2)

//! (VAL: size_t) (DST: void*) 
#define O_MOV_CONST          (0b00001 | ARG_NUM_2)

//! (VAL: void**) (DST: void*) 
#define O_LEA                (0b00010 | ARG_NUM_2)


//! (DST: void*) (SRC: void*) (COUNT: size_t*) 
//! DST MAY INTERSECT WITH SRC
#define O_MOV                (0b00000 | ARG_NUM_3)

//! (DST: void*) (SRC: void*) (COUNT: size_t*) 
//! DST MAY BE SRC.
#define O_INV                (0b00001 | ARG_NUM_3)

//! (DST: void*) (SRC: void*) (COUNT: size_t*) 
//! DST MAY BE SRC.
#define O_NEG                (0b00010 | ARG_NUM_3)

//! (DST: void*) (SRC: void*) (COUNT: size_t*) 
//! DST MAY BE SRC.
#define O_INC                (0b00011 | ARG_NUM_3)
//! (DST: void*) (SRC: void*) (COUNT: size_t*) 
//! DST MAY BE SRC.
#define O_DEC                (0b00100 | ARG_NUM_3)

//! (DST: size_t*) (SRC: void*) (COUNT: size_t*)
#define O_ALL                (0b00101 | ARG_NUM_3)
//! (DST: size_t*) (SRC: void*) (COUNT: size_t*)
#define O_ANY                (0b00110 | ARG_NUM_3)

//! (FLAG: void *) (VAL: void**) (DST: void*) 
#define O_CLEA               (0b00111 | ARG_NUM_3)

//! (PORT: const 4 bytes) (TO: void *) (COUNT: size_t*)
#define O_IN                 (0b01000 | ARG_NUM_3)

//! (PORT: const 4 bytes) (FROM: void *) (COUNT: size_t*)
#define O_OUT                (0b01001 | ARG_NUM_3)




//! (DST: void*) (A: void*) (B: void*) (COUNT: size_t*) 
#define O_EQ                 (0b00000 | ARG_NUM_4)
//! (DST: void*) (A: void*) (B: void*) (COUNT: size_t*) 
#define O_OR                 (0b00001 | ARG_NUM_4)
//! (DST: void*) (A: void*) (B: void*) (COUNT: size_t*) 
#define O_AND                (0b00010 | ARG_NUM_4)
//! (DST: void*) (A: void*) (B: void*) (COUNT: size_t*) 
#define O_XOR                (0b00011 | ARG_NUM_4)

//! (DST: void*) (A: void*) (B: void*) (COUNT: size_t*) 
#define O_ADD                (0b00100 | ARG_NUM_4)
//! (DST: void*) (A: void*) (B: void*) (COUNT: size_t*) 
#define O_SUB                (0b00101 | ARG_NUM_4)
//! (DST: void*) (A: void*) (B: void*) (COUNT: size_t*) 
#define O_MUL                (0b00110 | ARG_NUM_4)
//! (DST: void*) (A: void*) (B: void*) (COUNT: size_t*) 
#define O_DIV                (0b00111 | ARG_NUM_4)

//! (FLAG: size_t*) (DST: void*) (SRC: void*) (COUNT: size_t*) 
#define O_CMOV               (0b01000 | ARG_NUM_4)

//! (FLAG: size_t*) (a: void*) (b: void*) (COUNT: size_t*) 
#define O_LT                 (0b01001 | ARG_NUM_4)


// //! (FLAG: size_t*) (DST: abs_void*) (SRC: void*) (COUNT: size_t*)
// #define O_CMOV               (0b01000 | ARG_NUM_4)


//!  ()
// #define O_CALL






struct command
{
    const char *name;
    const int nargs;
    const int code;
    const int const_first_argument;
};




static const struct command native_commands[] = {

    #define INSTRUCTION(opcode_macro, name, nargs, const_first_argument, opcode, handler) {name, nargs, opcode, const_first_argument},
    #include "instructions.inc"
    #undef INSTRUCTION
    
};

                                                                                

#endif // SPECS

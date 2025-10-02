#ifndef SPECS
#define SPECS


#define MAX_COMMAND_ARGUMENTS 4
/* in bytes */
#define MAX_INSTRUCTION_LENGTH 64
#define MAX_MACRO_INSTRUCTION_LENGTH 64



/*******************************************************
//! 1 bit for arguments size:
//! 0 - 2 byte (WORD) argument size
//! 1 - 4 byte (DWORD) argument size
//!
//! 2 bits for arguments number
//! binary number means exactly number of arguments
//!
//! 5 bits for opcode
********************************************************/

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


//! (INDEX:1 byte) (DATA: void*)
#define O_INT                (0b00000 | ARG_NUM_2)

//! (VAL: size_t) (DST: void*) 
#define O_MOV_CONST          (0b00001 | ARG_NUM_2)

//! (VAL: void**) (DST: void*) 
#define O_LEA                (0b00010 | ARG_NUM_2)

//#define O_ABSPTR             (0b00001 | ARG_NUM_??)


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

//! (FLAG: size_t*) (SRC: void*) (DST: void*) (COUNT: size_t*) 
#define O_CMOV               (0b01000 | ARG_NUM_4)


//!  ()
#define O_CALL






struct command
{
    const char *name;
    const int nargs;
    const int code;
};

/* to generate this table use

/ NOT WORkING SINCE CHANGE OF O_... MACROS /
[regex]::Matches((gc specs.h -Raw), "//!(?<a>.*)(\n//!.*)*\n#define\s+(?<b>\w+)\s+(?<c>0b\d+)")|%{"static const struct command native_commands[] = {"}{$n=($_.Groups["a"].Value | sls "\([^:]*:[^)]*\)" -A|% M*s).Count;$s=$_.Groups["b"]-replace"^O_";$v=[int]"$($_.Groups["c"])";"    {""$s"", $n, $v | ARG_NUM_$n},"}{"};"}

 */


static const struct command native_commands[] = {
    {"NOP", 0, 0 | ARG_NUM_0},
    {"INT", 2, 0 | ARG_NUM_2},
    {"MOV_CONST", 2, 1 | ARG_NUM_2},
    {"LEA", 2, 2 | ARG_NUM_2},
    {"MOV", 3, 0 | ARG_NUM_3},
    {"INV", 3, 1 | ARG_NUM_3},
    {"NEG", 3, 2 | ARG_NUM_3},
    {"INC", 3, 3 | ARG_NUM_3},
    {"DEC", 3, 4 | ARG_NUM_3},
    {"ALL", 3, 5 | ARG_NUM_3},
    {"ANY", 3, 6 | ARG_NUM_3},
    {"EQ", 4, 0 | ARG_NUM_4},
    {"OR", 4, 1 | ARG_NUM_4},
    {"AND", 4, 2 | ARG_NUM_4},
    {"XOR", 4, 3 | ARG_NUM_4},
    {"ADD", 4, 4 | ARG_NUM_4},
    {"SUB", 4, 5 | ARG_NUM_4},
    {"MUL", 4, 6 | ARG_NUM_4},
    {"DIV", 4, 7 | ARG_NUM_4},
    {"CMOV", 4, 8 | ARG_NUM_4},
};

                                                                                

#endif // SPECS

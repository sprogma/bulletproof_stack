#ifndef SPECS
#define SPECS


#define MAX_COMMAND_ARGUMENTS 4
/* in bytes */
#define MAX_INSTRUCTION_LENGTH 64



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

#define ARG_SIZE_OPCODE_MASK 0b10000000
#define ARG_SIZE_WORD        0b00000000
#define ARG_SIZE_DWORD       0b10000000

#define ARG_NUM_OPCODE_MASK  0b01100000
#define ARG_NUM_0            0b00000000
// DEPRECATED BEFORE IMPLEMENTATION #define ARG_NUM_1           0b00100000
#define ARG_NUM_2            0b00100000
#define ARG_NUM_3            0b01000000
#define ARG_NUM_4            0b01100000


//! 
#define O_NOP                0b00000


//! (INDEX:1 byte) (DATA: void*) 
#define O_INT                0b00000

//! (DST: void*) (VAL: size_t) 
#define O_MOV_CONST          0b00001

//#define O_ABSPTR             0b00001


//! (DST: void*) (SRC: void*) (COUNT: size_t*) 
//! DST MAY INTERSECT WITH SRC
#define O_MOV                0b00000

//! (DST: void*) (SRC: void*) (COUNT: size_t*) 
//! DST MAY BE SRC.
#define O_INV                0b00001

//! (DST: void*) (SRC: void*) (COUNT: size_t*) 
//! DST MAY BE SRC.
#define O_NEG                0b00010

//! (DST: void*) (SRC: void*) (COUNT: size_t*) 
//! DST MAY BE SRC.
#define O_INC                0b00011
//! (DST: void*) (SRC: void*) (COUNT: size_t*) 
//! DST MAY BE SRC.
#define O_DEC                0b00100

//! (DST: size_t*) (SRC: void*) (COUNT: size_t*)
#define O_ALL                0b00101
//! (DST: size_t*) (SRC: void*) (COUNT: size_t*)
#define O_ANY                0b00110




//! (DST: void*) (A: void*) (B: void*) (COUNT: size_t*) 
#define O_EQ                 0b00000
//! (DST: void*) (A: void*) (B: void*) (COUNT: size_t*) 
#define O_OR                 0b00001
//! (DST: void*) (A: void*) (B: void*) (COUNT: size_t*) 
#define O_AND                0b00010
//! (DST: void*) (A: void*) (B: void*) (COUNT: size_t*) 
#define O_XOR                0b00011

//! (DST: void*) (A: void*) (B: void*) (COUNT: size_t*) 
#define O_ADD                0b00100
//! (DST: void*) (A: void*) (B: void*) (COUNT: size_t*) 
#define O_SUB                0b00101
//! (DST: void*) (A: void*) (B: void*) (COUNT: size_t*) 
#define O_MUL                0b00110
//! (DST: void*) (A: void*) (B: void*) (COUNT: size_t*) 
#define O_DIV                0b00111

//! (FLAG: size_t*) (SRC: void*) (DST: void*) (COUNT: size_t*) 
#define O_CMOV               0b01000


//!  ()
#define O_CALL






struct command
{
    const char *name;
    const int nargs;
    const int code;
};

/* to generate this table use

[regex]::Matches((gc specs.h -Raw), "//!(?<a>.*)(//!.*)*\n#define\s+(?<b>\w+)\s+(?<c>0b\d+)")|%{"const struct command commands[] = {"}{$n=($_.Groups["a"].Value | sls "\([^:]*:[^)]*\)" -A|% M*s).Count;$s=$_.Groups["b"]-replace"^O_";$v=[int]"$($_.Groups["c"])";"    {""$s"", $n, $v},"}{"};"}"}"}

 */

static const struct command commands[] = {
    {"NOP", 0, 0},
    {"INT", 2, 0},
    {"MOV_CONST", 2, 1},
    {"MOV", 0, 0},
    {"INV", 0, 1},
    {"NEG", 0, 2},
    {"INC", 0, 3},
    {"DEC", 0, 4},
    {"ALL", 3, 5},
    {"ANY", 3, 6},
    {"EQ", 4, 0},
    {"OR", 4, 1},
    {"AND", 4, 2},
    {"XOR", 4, 3},
    {"ADD", 4, 4},
    {"SUB", 4, 5},
    {"MUL", 4, 6},
    {"DIV", 4, 7},
    {"CMOV", 4, 8},
};
                                                                                

#endif // SPECS

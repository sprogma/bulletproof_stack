; arguments
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
main:
MOV_CONST 24576, _main_end
MOV_CONST 24576, _main_start
LEA _local4, _local3
_local2:
MOV_CONST 1, _local3
$CLEA _local4, _zero, _local1 
$LEA _zero, _local0
_local1:
MOV_CONST 0, _main_y
LEA _local9, _local8
_local7:
MOV _local8, _main_y, _size4
MOV_CONST 90, _local10
EQ _local8, _local8, _local10, _size4
ALL _local8, _local8, _size4
INV _local8, _local8, _size4
$CLEA _local9, _zero, _local6 
$LEA _zero, _local5
_local6:
MOV_CONST 0, _main_x
LEA _local15, _local14
_local13:
MOV _local14, _main_x, _size4
MOV_CONST 160, _local16
EQ _local14, _local14, _local16, _size4
ALL _local14, _local14, _size4
INV _local14, _local14, _size4
$CLEA _local15, _zero, _local12 
$LEA _zero, _local11
_local12:
MOV put4 - 12, _main_end, _size4
MOV_CONST 0, put4 - 16
LEA put4 - 4, _local17
$LEA _zero, put4
_local17:
MOV _main_t, put4 - 8, _size4
MOV _main_a, _main_x, _size4
MOV_CONST 80, _local18
SUB _main_a, _main_a, _local18, _size4
MOV _main_b, _main_y, _size4
MOV_CONST 45, _local19
SUB _main_b, _main_b, _local19, _size4
MOV _main_a, _main_a, _size4
MOV_CONST 1, _local21
MUL _main_a, _main_a, _local21, _size4
MOV_CONST 2, _local20
DIV _main_a, _main_a, _local20, _size4
MOV _main_b, _main_b, _size4
MOV_CONST 1, _local23
MUL _main_b, _main_b, _local23, _size4
MOV_CONST 2, _local22
DIV _main_b, _main_b, _local22, _size4
MOV_CONST 0, _main_ta
MOV_CONST 0, _main_tb
MOV_CONST 0, _main_i
LEA _local28, _local27
_local26:
MOV _local27, _main_i, _size4
MOV_CONST 100, _local29
EQ _local27, _local27, _local29, _size4
ALL _local27, _local27, _size4
INV _local27, _local27, _size4
$CLEA _local28, _zero, _local25 
$LEA _zero, _local24
_local25:
MOV _main_t, _main_ta, _size4
MOV _local33, _main_ta, _size4
MUL _main_t, _main_t, _local33, _size4
MOV _local32, _main_tb, _size4
MOV _local34, _main_tb, _size4
MUL _local32, _local32, _local34, _size4
SUB _main_t, _main_t, _local32, _size4
MOV_CONST 100, _local31
DIV _main_t, _main_t, _local31, _size4
MOV _local30, _main_a, _size4
ADD _main_t, _main_t, _local30, _size4
MOV_CONST 2, _main_tb
MOV _local37, _main_ta, _size4
MOV _local38, _main_tb, _size4
MUL _local37, _local37, _local38, _size4
MUL _main_tb, _main_tb, _local37, _size4
MOV_CONST 100, _local36
DIV _main_tb, _main_tb, _local36, _size4
MOV _local35, _main_b, _size4
ADD _main_tb, _main_tb, _local35, _size4
MOV _main_ta, _main_t, _size4
MOV _local41, _main_ta, _size4
MOV _local45, _main_ta, _size4
MUL _local41, _local41, _local45, _size4
MOV _local44, _main_tb, _size4
MOV _local46, _main_tb, _size4
MUL _local44, _local44, _local46, _size4
ADD _local41, _local41, _local44, _size4
MOV_CONST 4, _local43
MOV_CONST 100, _local47
MUL _local43, _local43, _local47, _size4
LT _local41, _local41, _local43, _size4
INV _local41, _local41, _size4
LEA _local42, _local41
$CLEA _local42, _zero, _local39 
$LEA _zero, _local40 
_local39:
MOV _local50, _main_i, _size4
MOV_CONST 2, _local54
DIV _local50, _local50, _local54, _size4
MOV_CONST 2, _local53
MUL _local50, _local50, _local53, _size4
MOV _local52, _main_i, _size4
EQ _local50, _local50, _local52, _size4
ALL _local50, _local50, _size4
LEA _local51, _local50
$CLEA _local51, _zero, _local48 
$LEA _zero, _local49 
_local48:
MOV put4 - 12, _main_end, _size4
MOV_CONST 16711680, put4 - 16
LEA put4 - 4, _local55
$LEA _zero, put4
_local55:
MOV _main_t, put4 - 8, _size4
MOV_CONST 99, _main_i
_local49:
_local40:
MOV _main_i, _main_i, _size4
MOV_CONST 1, _local56
ADD _main_i, _main_i, _local56, _size4
$LEA _zero, _local26 
_local24:
MOV _main_end, _main_end, _size4
MOV_CONST 4, _local57
ADD _main_end, _main_end, _local57, _size4
MOV _main_x, _main_x, _size4
MOV_CONST 1, _local58
ADD _main_x, _main_x, _local58, _size4
$LEA _zero, _local13 
_local11:
MOV _main_y, _main_y, _size4
MOV_CONST 1, _local59
ADD _main_y, _main_y, _local59, _size4
$LEA _zero, _local7 
_local5:
MOV out - 12, _main_start, _size4
MOV out - 16, _main_end, _size4
MOV _local60, _main_start, _size4
SUB out - 16, out - 16, _local60, _size4
LEA out - 4, _local61
$LEA _zero, out
_local61:
MOV _main_t, out - 8, _size4
MOV _main_end, _main_start, _size4
$LEA _zero, _local2 
_local0:
MOV_CONST 0, main - 8
LEA _local62, _size4
LEA _local63, main - 4
$MOV _zero, _local63, _local62
_main_end:
.dd 0
_main_start:
.dd 0
_main_t:
.dd 0
_main_x:
.dd 0
_main_y:
.dd 0
_local3:
.dd 0
_local4:
.dd 0
_local8:
.dd 0
_local9:
.dd 0
_local10:
.dd 0
_local14:
.dd 0
_local15:
.dd 0
_local16:
.dd 0
_main_a:
.dd 0
_main_b:
.dd 0
_main_i:
.dd 0
_local18:
.dd 0
_local19:
.dd 0
_main_ta:
.dd 0
_main_tb:
.dd 0
_local20:
.dd 0
_local21:
.dd 0
_local22:
.dd 0
_local23:
.dd 0
_local27:
.dd 0
_local28:
.dd 0
_local29:
.dd 0
_local30:
.dd 0
_local31:
.dd 0
_local32:
.dd 0
_local33:
.dd 0
_local34:
.dd 0
_local35:
.dd 0
_local36:
.dd 0
_local37:
.dd 0
_local38:
.dd 0
_local41:
.dd 0
_local42:
.dd 0
_local43:
.dd 0
_local44:
.dd 0
_local45:
.dd 0
_local46:
.dd 0
_local47:
.dd 0
_local50:
.dd 0
_local51:
.dd 0
_local52:
.dd 0
_local53:
.dd 0
_local54:
.dd 0
_local56:
.dd 0
_local57:
.dd 0
_local58:
.dd 0
_local59:
.dd 0
_local60:
.dd 0
_local62:
.dd 0
_local63:
.dd 0
_size4:
.dd 4
_size1:
.dd 1
_zero:
.dd 0

; arguments
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
draw:
MOV_CONST 24576, _draw_start
MOV_CONST 24576, _draw_end
MOV_CONST 0, _draw_y
LEA _local4, _local3
_local2:
MOV _local3, _draw_y, _size4
MOV_CONST 90, _local5
EQ _local3, _local3, _local5, _size4
ALL _local3, _local3, _size4
INV _local3, _local3, _size4
$CLEA _local4, _zero, _local1 
$LEA _zero, _local0
_local1:
MOV_CONST 0, _draw_x
LEA _local10, _local9
_local8:
MOV _local9, _draw_x, _size4
MOV_CONST 160, _local11
EQ _local9, _local9, _local11, _size4
ALL _local9, _local9, _size4
INV _local9, _local9, _size4
$CLEA _local10, _zero, _local7 
$LEA _zero, _local6
_local7:
MOV put4 - 12, _draw_end, _size4
MOV_CONST 0, put4 - 16
LEA put4 - 4, _local12
$LEA _zero, put4
_local12:
MOV _draw_t, put4 - 8, _size4
MOV f - 12, _draw_x, _size4
MOV_CONST 80, _local13
SUB f - 12, f - 12, _local13, _size4
LEA f - 4, _local14
$LEA _zero, f
_local14:
MOV fdiv - 12, f - 8, _size4
MOV_CONST 80, f - 12
LEA f - 4, _local15
$LEA _zero, f
_local15:
MOV fdiv - 16, f - 8, _size4
LEA fdiv - 4, _local16
$LEA _zero, fdiv
_local16:
MOV _draw_a, fdiv - 8, _size4
MOV f - 12, _draw_y, _size4
MOV_CONST 45, _local17
SUB f - 12, f - 12, _local17, _size4
LEA f - 4, _local18
$LEA _zero, f
_local18:
MOV fdiv - 12, f - 8, _size4
MOV_CONST 45, f - 12
LEA f - 4, _local19
$LEA _zero, f
_local19:
MOV fdiv - 16, f - 8, _size4
LEA fdiv - 4, _local20
$LEA _zero, fdiv
_local20:
MOV _draw_b, fdiv - 8, _size4
MOV fmul - 12, _draw_a, _size4
MOV fmul - 16, _draw_a, _size4
LEA fmul - 4, _local27
$LEA _zero, fmul
_local27:
MOV _local23, fmul - 8, _size4
MOV fmul - 12, _draw_b, _size4
MOV fmul - 16, _draw_b, _size4
LEA fmul - 4, _local28
$LEA _zero, fmul
_local28:
MOV _local26, fmul - 8, _size4
ADD _local23, _local23, _local26, _size4
MOV_CONST 256, _local25
LT _local23, _local23, _local25, _size4
LEA _local24, _local23
$CLEA _local24, _zero, _local21 
$LEA _zero, _local22 
_local21:
MOV put4 - 12, _draw_end, _size4
MOV_CONST 16711680, put4 - 16
LEA put4 - 4, _local29
$LEA _zero, put4
_local29:
MOV _draw_t, put4 - 8, _size4
_local22:
MOV _draw_end, _draw_end, _size4
MOV_CONST 4, _local30
ADD _draw_end, _draw_end, _local30, _size4
MOV _draw_x, _draw_x, _size4
MOV_CONST 1, _local31
ADD _draw_x, _draw_x, _local31, _size4
$LEA _zero, _local8 
_local6:
MOV _draw_y, _draw_y, _size4
MOV_CONST 1, _local32
ADD _draw_y, _draw_y, _local32, _size4
$LEA _zero, _local2 
_local0:
MOV out - 12, _draw_start, _size4
MOV out - 16, _draw_end, _size4
MOV _local33, _draw_start, _size4
SUB out - 16, out - 16, _local33, _size4
LEA out - 4, _local34
$LEA _zero, out
_local34:
MOV _draw_t, out - 8, _size4
MOV_CONST 0, draw - 8
LEA _local35, _size4
LEA _local36, draw - 4
$MOV _zero, _local36, _local35
; arguments
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
main:
LEA _local41, _local40
_local39:
MOV_CONST 1, _local40
$CLEA _local41, _zero, _local38 
$LEA _zero, _local37
_local38:
LEA draw - 4, _local42
$LEA _zero, draw
_local42:
MOV _main_t, draw - 8, _size4
$LEA _zero, _local39 
_local37:
MOV_CONST 0, main - 8
LEA _local43, _size4
LEA _local44, main - 4
$MOV _zero, _local44, _local43
_draw_t:
.dd 0
_draw_start:
.dd 0
_draw_end:
.dd 0
_draw_x:
.dd 0
_draw_y:
.dd 0
_draw_a:
.dd 0
_draw_b:
.dd 0
_local3:
.dd 0
_local4:
.dd 0
_local5:
.dd 0
_local9:
.dd 0
_local10:
.dd 0
_local11:
.dd 0
_local13:
.dd 0
_local17:
.dd 0
_local23:
.dd 0
_local24:
.dd 0
_local25:
.dd 0
_local26:
.dd 0
_local30:
.dd 0
_local31:
.dd 0
_local32:
.dd 0
_local33:
.dd 0
_local35:
.dd 0
_local36:
.dd 0
_main_t:
.dd 0
_local40:
.dd 0
_local41:
.dd 0
_local43:
.dd 0
_local44:
.dd 0
_size4:
.dd 4
_size1:
.dd 1
_zero:
.dd 0

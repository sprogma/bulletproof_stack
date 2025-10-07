
LEA main - 4, end_proc
$LEA __ld_zero, main
end_proc:
; like HLT instruction
.db 0xFF
__ld_zero:
.dd 0
; arguments
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
main:
MOV_CONST 24576, _0a__main_end
MOV_CONST 24576, _0a__main_start
LEA _0a__local4, _0a__local3
_0a__local2:
MOV_CONST 1, _0a__local3
$CLEA _0a__local4, _0a__zero, _0a__local1 
$LEA _0a__zero, _0a__local0
_0a__local1:
MOV_CONST 0, _0a__main_y
LEA _0a__local9, _0a__local8
_0a__local7:
MOV _0a__local8, _0a__main_y, _0a__size4
MOV_CONST 90, _0a__local10
EQ _0a__local8, _0a__local8, _0a__local10, _0a__size4
ALL _0a__local8, _0a__local8, _0a__size4
INV _0a__local8, _0a__local8, _0a__size4
$CLEA _0a__local9, _0a__zero, _0a__local6 
$LEA _0a__zero, _0a__local5
_0a__local6:
MOV_CONST 0, _0a__main_x
LEA _0a__local15, _0a__local14
_0a__local13:
MOV _0a__local14, _0a__main_x, _0a__size4
MOV_CONST 160, _0a__local16
EQ _0a__local14, _0a__local14, _0a__local16, _0a__size4
ALL _0a__local14, _0a__local14, _0a__size4
INV _0a__local14, _0a__local14, _0a__size4
$CLEA _0a__local15, _0a__zero, _0a__local12 
$LEA _0a__zero, _0a__local11
_0a__local12:
MOV put4 - 12, _0a__main_end, _0a__size4
MOV_CONST 0, put4 - 16
LEA put4 - 4, _0a__local17
$LEA _0a__zero, put4
_0a__local17:
MOV _0a__main_t, put4 - 8, _0a__size4
MOV _0a__main_a, _0a__main_x, _0a__size4
MOV_CONST 80, _0a__local18
SUB _0a__main_a, _0a__main_a, _0a__local18, _0a__size4
MOV _0a__main_b, _0a__main_y, _0a__size4
MOV_CONST 45, _0a__local19
SUB _0a__main_b, _0a__main_b, _0a__local19, _0a__size4
MOV _0a__main_a, _0a__main_a, _0a__size4
MOV_CONST 1, _0a__local21
MUL _0a__main_a, _0a__main_a, _0a__local21, _0a__size4
MOV_CONST 2, _0a__local20
DIV _0a__main_a, _0a__main_a, _0a__local20, _0a__size4
MOV _0a__main_b, _0a__main_b, _0a__size4
MOV_CONST 1, _0a__local23
MUL _0a__main_b, _0a__main_b, _0a__local23, _0a__size4
MOV_CONST 2, _0a__local22
DIV _0a__main_b, _0a__main_b, _0a__local22, _0a__size4
MOV_CONST 0, _0a__main_ta
MOV_CONST 0, _0a__main_tb
MOV_CONST 0, _0a__main_i
LEA _0a__local28, _0a__local27
_0a__local26:
MOV _0a__local27, _0a__main_i, _0a__size4
MOV_CONST 100, _0a__local29
EQ _0a__local27, _0a__local27, _0a__local29, _0a__size4
ALL _0a__local27, _0a__local27, _0a__size4
INV _0a__local27, _0a__local27, _0a__size4
$CLEA _0a__local28, _0a__zero, _0a__local25 
$LEA _0a__zero, _0a__local24
_0a__local25:
MOV _0a__main_t, _0a__main_ta, _0a__size4
MOV _0a__local33, _0a__main_ta, _0a__size4
MUL _0a__main_t, _0a__main_t, _0a__local33, _0a__size4
MOV _0a__local32, _0a__main_tb, _0a__size4
MOV _0a__local34, _0a__main_tb, _0a__size4
MUL _0a__local32, _0a__local32, _0a__local34, _0a__size4
SUB _0a__main_t, _0a__main_t, _0a__local32, _0a__size4
MOV_CONST 100, _0a__local31
DIV _0a__main_t, _0a__main_t, _0a__local31, _0a__size4
MOV _0a__local30, _0a__main_a, _0a__size4
ADD _0a__main_t, _0a__main_t, _0a__local30, _0a__size4
MOV_CONST 2, _0a__main_tb
MOV _0a__local37, _0a__main_ta, _0a__size4
MOV _0a__local38, _0a__main_tb, _0a__size4
MUL _0a__local37, _0a__local37, _0a__local38, _0a__size4
MUL _0a__main_tb, _0a__main_tb, _0a__local37, _0a__size4
MOV_CONST 100, _0a__local36
DIV _0a__main_tb, _0a__main_tb, _0a__local36, _0a__size4
MOV _0a__local35, _0a__main_b, _0a__size4
ADD _0a__main_tb, _0a__main_tb, _0a__local35, _0a__size4
MOV _0a__main_ta, _0a__main_t, _0a__size4
MOV _0a__local41, _0a__main_ta, _0a__size4
MOV _0a__local45, _0a__main_ta, _0a__size4
MUL _0a__local41, _0a__local41, _0a__local45, _0a__size4
MOV _0a__local44, _0a__main_tb, _0a__size4
MOV _0a__local46, _0a__main_tb, _0a__size4
MUL _0a__local44, _0a__local44, _0a__local46, _0a__size4
ADD _0a__local41, _0a__local41, _0a__local44, _0a__size4
MOV_CONST 4, _0a__local43
MOV_CONST 100, _0a__local47
MUL _0a__local43, _0a__local43, _0a__local47, _0a__size4
LT _0a__local41, _0a__local41, _0a__local43, _0a__size4
INV _0a__local41, _0a__local41, _0a__size4
LEA _0a__local42, _0a__local41
$CLEA _0a__local42, _0a__zero, _0a__local39 
$LEA _0a__zero, _0a__local40 
_0a__local39:
MOV _0a__local50, _0a__main_i, _0a__size4
MOV_CONST 2, _0a__local54
DIV _0a__local50, _0a__local50, _0a__local54, _0a__size4
MOV_CONST 2, _0a__local53
MUL _0a__local50, _0a__local50, _0a__local53, _0a__size4
MOV _0a__local52, _0a__main_i, _0a__size4
EQ _0a__local50, _0a__local50, _0a__local52, _0a__size4
ALL _0a__local50, _0a__local50, _0a__size4
LEA _0a__local51, _0a__local50
$CLEA _0a__local51, _0a__zero, _0a__local48 
$LEA _0a__zero, _0a__local49 
_0a__local48:
MOV put4 - 12, _0a__main_end, _0a__size4
MOV_CONST 16711680, put4 - 16
LEA put4 - 4, _0a__local55
$LEA _0a__zero, put4
_0a__local55:
MOV _0a__main_t, put4 - 8, _0a__size4
MOV_CONST 99, _0a__main_i
_0a__local49:
_0a__local40:
MOV _0a__main_i, _0a__main_i, _0a__size4
MOV_CONST 1, _0a__local56
ADD _0a__main_i, _0a__main_i, _0a__local56, _0a__size4
$LEA _0a__zero, _0a__local26 
_0a__local24:
MOV _0a__main_end, _0a__main_end, _0a__size4
MOV_CONST 4, _0a__local57
ADD _0a__main_end, _0a__main_end, _0a__local57, _0a__size4
MOV _0a__main_x, _0a__main_x, _0a__size4
MOV_CONST 1, _0a__local58
ADD _0a__main_x, _0a__main_x, _0a__local58, _0a__size4
$LEA _0a__zero, _0a__local13 
_0a__local11:
MOV _0a__main_y, _0a__main_y, _0a__size4
MOV_CONST 1, _0a__local59
ADD _0a__main_y, _0a__main_y, _0a__local59, _0a__size4
$LEA _0a__zero, _0a__local7 
_0a__local5:
MOV out - 12, _0a__main_start, _0a__size4
MOV out - 16, _0a__main_end, _0a__size4
MOV _0a__local60, _0a__main_start, _0a__size4
SUB out - 16, out - 16, _0a__local60, _0a__size4
LEA out - 4, _0a__local61
$LEA _0a__zero, out
_0a__local61:
MOV _0a__main_t, out - 8, _0a__size4
MOV _0a__main_end, _0a__main_start, _0a__size4
$LEA _0a__zero, _0a__local2 
_0a__local0:
MOV_CONST 0, main - 8
LEA _0a__local62, _0a__size4
LEA _0a__local63, main - 4
$MOV _0a__zero, _0a__local63, _0a__local62
_0a__main_end:
.dd 0
_0a__main_start:
.dd 0
_0a__main_t:
.dd 0
_0a__main_x:
.dd 0
_0a__main_y:
.dd 0
_0a__local3:
.dd 0
_0a__local4:
.dd 0
_0a__local8:
.dd 0
_0a__local9:
.dd 0
_0a__local10:
.dd 0
_0a__local14:
.dd 0
_0a__local15:
.dd 0
_0a__local16:
.dd 0
_0a__main_a:
.dd 0
_0a__main_b:
.dd 0
_0a__main_i:
.dd 0
_0a__local18:
.dd 0
_0a__local19:
.dd 0
_0a__main_ta:
.dd 0
_0a__main_tb:
.dd 0
_0a__local20:
.dd 0
_0a__local21:
.dd 0
_0a__local22:
.dd 0
_0a__local23:
.dd 0
_0a__local27:
.dd 0
_0a__local28:
.dd 0
_0a__local29:
.dd 0
_0a__local30:
.dd 0
_0a__local31:
.dd 0
_0a__local32:
.dd 0
_0a__local33:
.dd 0
_0a__local34:
.dd 0
_0a__local35:
.dd 0
_0a__local36:
.dd 0
_0a__local37:
.dd 0
_0a__local38:
.dd 0
_0a__local41:
.dd 0
_0a__local42:
.dd 0
_0a__local43:
.dd 0
_0a__local44:
.dd 0
_0a__local45:
.dd 0
_0a__local46:
.dd 0
_0a__local47:
.dd 0
_0a__local50:
.dd 0
_0a__local51:
.dd 0
_0a__local52:
.dd 0
_0a__local53:
.dd 0
_0a__local54:
.dd 0
_0a__local56:
.dd 0
_0a__local57:
.dd 0
_0a__local58:
.dd 0
_0a__local59:
.dd 0
_0a__local60:
.dd 0
_0a__local62:
.dd 0
_0a__local63:
.dd 0
_0a__size4:
.dd 4
_0a__size1:
.dd 1
_0a__zero:
.dd 0


; [void=int] put4(int, int) function:
; 
; ptr - pointer to write data
; value - data to write
; 
; writes only 4 byte slices

; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE

put4:

; write data to memory
LEA _1io__size4_ptr, _1io__size4
LEA _1io__value_ptr, put4 - 16
$MOV put4 - 12, _1io__value_ptr, _1io__size4_ptr

; return to caller
LEA _1io__ptr_ptr, put4 - 4
$MOV _1io__zero, _1io__ptr_ptr, _1io__size4_ptr


; [void=int] put1(int, int) function:
; 
; ptr - pointer to write data
; value - data to write
; 
; writes only 1 byte slices

; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE

put1:

; write data to memory
LEA _1io__size1_ptr, _1io__size1
LEA _1io__size4_ptr, _1io__size4
LEA _1io__value_ptr, put1 - 16
$MOV put1 - 12, _1io__value_ptr, _1io__size1_ptr

; return to caller
LEA _1io__ptr_ptr, put1 - 4
$MOV _1io__zero, _1io__ptr_ptr, _1io__size4_ptr


; [void=int] out(int, int) function:
; 
; ptr - pointer to output data
; count - count of data to write
; 
; writes data to first port
;

; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE

out:

; send output data
LEA _1io__ptr_ptr, out - 16
$OUT 1, out - 12, _1io__ptr_ptr

; return to caller
LEA _1io__size4_ptr, _1io__size4
LEA _1io__ptr_ptr, out - 4
$MOV _1io__zero, _1io__ptr_ptr, _1io__size4_ptr

_1io__ptr_ptr:
.dd 0
_1io__value_ptr:
.dd 0
_1io__size4_ptr:
.dd 0
_1io__size1_ptr:
.dd 0


_1io__size4:
.dd 4
_1io__size1:
.dd 4
_1io__zero:
.dd 0


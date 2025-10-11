
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
draw:
MOV_CONST 24576, _0gl__draw_start
MOV_CONST 24576, _0gl__draw_end
MOV_CONST 0, _0gl__draw_x
LEA _0gl__local4, _0gl__local3
_0gl__local2:
MOV _0gl__local3, _0gl__draw_x, _0gl__size4
MOV_CONST 160, _0gl__local5
EQ _0gl__local3, _0gl__local3, _0gl__local5, _0gl__size4
ALL _0gl__local3, _0gl__local3, _0gl__size4
INV _0gl__local3, _0gl__local3, _0gl__size4
$CLEA _0gl__local4, _0gl__zero, _0gl__local1 
$LEA _0gl__zero, _0gl__local0
_0gl__local1:
MOV_CONST 0, _0gl__draw_y
LEA _0gl__local10, _0gl__local9
_0gl__local8:
MOV _0gl__local9, _0gl__draw_y, _0gl__size4
MOV_CONST 90, _0gl__local11
EQ _0gl__local9, _0gl__local9, _0gl__local11, _0gl__size4
ALL _0gl__local9, _0gl__local9, _0gl__size4
INV _0gl__local9, _0gl__local9, _0gl__size4
$CLEA _0gl__local10, _0gl__zero, _0gl__local7 
$LEA _0gl__zero, _0gl__local6
_0gl__local7:
MOV _0gl__draw_end, _0gl__draw_end, _0gl__size4
MOV_CONST 4, _0gl__local12
ADD _0gl__draw_end, _0gl__draw_end, _0gl__local12, _0gl__size4
MOV _0gl__draw_y, _0gl__draw_y, _0gl__size4
MOV_CONST 1, _0gl__local13
ADD _0gl__draw_y, _0gl__draw_y, _0gl__local13, _0gl__size4
$LEA _0gl__zero, _0gl__local8 
_0gl__local6:
MOV _0gl__draw_x, _0gl__draw_x, _0gl__size4
MOV_CONST 1, _0gl__local14
ADD _0gl__draw_x, _0gl__draw_x, _0gl__local14, _0gl__size4
$LEA _0gl__zero, _0gl__local2 
_0gl__local0:
MOV out - 12, _0gl__draw_start, _0gl__size4
MOV out - 16, _0gl__draw_end, _0gl__size4
MOV _0gl__local15, _0gl__draw_start, _0gl__size4
SUB out - 16, out - 16, _0gl__local15, _0gl__size4
LEA out - 4, _0gl__local16
$LEA _0gl__zero, out
_0gl__local16:
MOV _0gl__draw_t, out - 8, _0gl__size4
MOV_CONST 0, draw - 8
LEA _0gl__local17, _0gl__size4
LEA _0gl__local18, draw - 4
$MOV _0gl__zero, _0gl__local18, _0gl__local17
; arguments
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
main:
OUT 1, calling, _0gl__size4
MOV_CONST 24576, _0gl__main_end
MOV_CONST 24576, _0gl__main_start
LEA _0gl__local23, _0gl__local22
_0gl__local21:
MOV_CONST 1, _0gl__local22
$CLEA _0gl__local23, _0gl__zero, _0gl__local20 
$LEA _0gl__zero, _0gl__local19
_0gl__local20:
OUT 1, .calling, _0gl__size4
LEA draw - 4, _0gl__local24
$LEA _0gl__zero, draw
_0gl__local24:
MOV _0gl__main_t, draw - 8, _0gl__size4
$LEA _0gl__zero, _0gl__local21 
_0gl__local19:
MOV_CONST 0, main - 8
LEA _0gl__local25, _0gl__size4
LEA _0gl__local26, main - 4
$MOV _0gl__zero, _0gl__local26, _0gl__local25
calling:
.dd 0xABABABAB
_0gl__draw_t:
.dd 0
_0gl__draw_start:
.dd 0
_0gl__draw_end:
.dd 0
_0gl__draw_x:
.dd 0
_0gl__draw_y:
.dd 0
_0gl__local3:
.dd 0
_0gl__local4:
.dd 0
_0gl__local5:
.dd 0
_0gl__local9:
.dd 0
_0gl__local10:
.dd 0
_0gl__local11:
.dd 0
_0gl__local12:
.dd 0
_0gl__local13:
.dd 0
_0gl__local14:
.dd 0
_0gl__local15:
.dd 0
_0gl__local17:
.dd 0
_0gl__local18:
.dd 0
_0gl__main_end:
.dd 0
_0gl__main_start:
.dd 0
_0gl__main_t:
.dd 0
_0gl__main_x:
.dd 0
_0gl__main_y:
.dd 0
_0gl__local22:
.dd 0
_0gl__local23:
.dd 0
_0gl__local25:
.dd 0
_0gl__local26:
.dd 0
_0gl__size4:
.dd 4
_0gl__size1:
.dd 1
_0gl__zero:
.dd 0

; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
fmul:
MOV fmul - 8, fmul - 12, _1math__size4
MOV _1math__local1, fmul - 16, _1math__size4
MUL fmul - 8, fmul - 8, _1math__local1, _1math__size4
MOV_CONST 1000, _1math__local0
DIV fmul - 8, fmul - 8, _1math__local0, _1math__size4
LEA _1math__local2, _1math__size4
LEA _1math__local3, fmul - 4
$MOV _1math__zero, _1math__local3, _1math__local2
; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
fdiv:
MOV fdiv - 8, fdiv - 12, _1math__size4
MOV_CONST 1000, _1math__local5
MUL fdiv - 8, fdiv - 8, _1math__local5, _1math__size4
MOV _1math__local4, fdiv - 16, _1math__size4
DIV fdiv - 8, fdiv - 8, _1math__local4, _1math__size4
LEA _1math__local6, _1math__size4
LEA _1math__local7, fdiv - 4
$MOV _1math__zero, _1math__local7, _1math__local6
; arguments
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
sqrt:
MOV _1math__sqrt_aa, sqrt - 12, _1math__size4
MOV_CONST 1000, _1math__local8
MUL _1math__sqrt_aa, _1math__sqrt_aa, _1math__local8, _1math__size4
MOV_CONST 0, _1math__sqrt_res
MOV_CONST 46340, _1math__sqrt_add
LEA _1math__local13, _1math__local12
_1math__local11:
MOV _1math__local12, _1math__sqrt_add, _1math__size4
MOV_CONST 1, _1math__local14
LT _1math__local12, _1math__local12, _1math__local14, _1math__size4
INV _1math__local12, _1math__local12, _1math__size4
$CLEA _1math__local13, _1math__zero, _1math__local10 
$LEA _1math__zero, _1math__local9
_1math__local10:
MOV _1math__local17, _1math__sqrt_res, _1math__size4
MOV _1math__local21, _1math__sqrt_add, _1math__size4
ADD _1math__local17, _1math__local17, _1math__local21, _1math__size4
MOV _1math__local20, _1math__sqrt_res, _1math__size4
MOV _1math__local22, _1math__sqrt_add, _1math__size4
ADD _1math__local20, _1math__local20, _1math__local22, _1math__size4
MUL _1math__local17, _1math__local17, _1math__local20, _1math__size4
MOV _1math__local19, _1math__sqrt_aa, _1math__size4
LT _1math__local17, _1math__local17, _1math__local19, _1math__size4
LEA _1math__local18, _1math__local17
$CLEA _1math__local18, _1math__zero, _1math__local15 
$LEA _1math__zero, _1math__local16 
_1math__local15:
MOV _1math__sqrt_res, _1math__sqrt_res, _1math__size4
MOV _1math__local23, _1math__sqrt_add, _1math__size4
ADD _1math__sqrt_res, _1math__sqrt_res, _1math__local23, _1math__size4
_1math__local16:
MOV _1math__sqrt_add, _1math__sqrt_add, _1math__size4
MOV_CONST 2, _1math__local24
DIV _1math__sqrt_add, _1math__sqrt_add, _1math__local24, _1math__size4
$LEA _1math__zero, _1math__local11 
_1math__local9:
MOV sqrt - 8, _1math__sqrt_res, _1math__size4
LEA _1math__local25, _1math__size4
LEA _1math__local26, sqrt - 4
$MOV _1math__zero, _1math__local26, _1math__local25
; arguments
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
f:
MOV f - 8, f - 12, _1math__size4
MOV_CONST 1000, _1math__local27
MUL f - 8, f - 8, _1math__local27, _1math__size4
LEA _1math__local28, _1math__size4
LEA _1math__local29, f - 4
$MOV _1math__zero, _1math__local29, _1math__local28
_1math__local0:
.dd 0
_1math__local1:
.dd 0
_1math__local2:
.dd 0
_1math__local3:
.dd 0
_1math__local4:
.dd 0
_1math__local5:
.dd 0
_1math__local6:
.dd 0
_1math__local7:
.dd 0
_1math__sqrt_aa:
.dd 0
_1math__sqrt_res:
.dd 0
_1math__sqrt_add:
.dd 0
_1math__local8:
.dd 0
_1math__local12:
.dd 0
_1math__local13:
.dd 0
_1math__local14:
.dd 0
_1math__local17:
.dd 0
_1math__local18:
.dd 0
_1math__local19:
.dd 0
_1math__local20:
.dd 0
_1math__local21:
.dd 0
_1math__local22:
.dd 0
_1math__local23:
.dd 0
_1math__local24:
.dd 0
_1math__local25:
.dd 0
_1math__local26:
.dd 0
_1math__local27:
.dd 0
_1math__local28:
.dd 0
_1math__local29:
.dd 0
_1math__size4:
.dd 4
_1math__size1:
.dd 1
_1math__zero:
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
LEA _2io__size4_ptr, _2io__size4
LEA _2io__value_ptr, put4 - 16
$MOV put4 - 12, _2io__value_ptr, _2io__size4_ptr

; return to caller
LEA _2io__ptr_ptr, put4 - 4
$MOV _2io__zero, _2io__ptr_ptr, _2io__size4_ptr


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
LEA _2io__size1_ptr, _2io__size1
LEA _2io__size4_ptr, _2io__size4
LEA _2io__value_ptr, put1 - 16
$MOV put1 - 12, _2io__value_ptr, _2io__size1_ptr

; return to caller
LEA _2io__ptr_ptr, put1 - 4
$MOV _2io__zero, _2io__ptr_ptr, _2io__size4_ptr


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
LEA _2io__ptr_ptr, out - 16
$OUT 1, out - 12, _2io__ptr_ptr

; return to caller
LEA _2io__size4_ptr, _2io__size4
LEA _2io__ptr_ptr, out - 4
$MOV _2io__zero, _2io__ptr_ptr, _2io__size4_ptr

_2io__ptr_ptr:
.dd 0
_2io__value_ptr:
.dd 0
_2io__size4_ptr:
.dd 0
_2io__size1_ptr:
.dd 0


_2io__size4:
.dd 4
_2io__size1:
.dd 4
_2io__zero:
.dd 0


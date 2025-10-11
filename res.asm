
LEA main - 4, end_proc
$LEA __ld_zero, main
end_proc:
; like HLT instruction
.db 0xFF
__ld_zero:
.dd 0
; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
fmul:
MOV fmul - 8, fmul - 12, _0a__size4
MOV _0a__local1, fmul - 16, _0a__size4
MUL fmul - 8, fmul - 8, _0a__local1, _0a__size4
MOV_CONST 1000, _0a__local0
DIV fmul - 8, fmul - 8, _0a__local0, _0a__size4
LEA _0a__local2, _0a__size4
LEA _0a__local3, fmul - 4
$MOV _0a__zero, _0a__local3, _0a__local2
; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
fdiv:
MOV fdiv - 8, fdiv - 12, _0a__size4
MOV_CONST 1000, _0a__local5
MUL fdiv - 8, fdiv - 8, _0a__local5, _0a__size4
MOV _0a__local4, fdiv - 16, _0a__size4
DIV fdiv - 8, fdiv - 8, _0a__local4, _0a__size4
LEA _0a__local6, _0a__size4
LEA _0a__local7, fdiv - 4
$MOV _0a__zero, _0a__local7, _0a__local6
; arguments
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
sqrt:
MOV _0a__sqrt_aa, sqrt - 12, _0a__size4
MOV_CONST 1000, _0a__local8
MUL _0a__sqrt_aa, _0a__sqrt_aa, _0a__local8, _0a__size4
MOV_CONST 0, _0a__sqrt_res
MOV_CONST 46340, _0a__sqrt_add
LEA _0a__local13, _0a__local12
_0a__local11:
MOV _0a__local12, _0a__sqrt_add, _0a__size4
MOV_CONST 1, _0a__local14
LT _0a__local12, _0a__local12, _0a__local14, _0a__size4
INV _0a__local12, _0a__local12, _0a__size4
$CLEA _0a__local13, _0a__zero, _0a__local10 
$LEA _0a__zero, _0a__local9
_0a__local10:
MOV _0a__local17, _0a__sqrt_res, _0a__size4
MOV _0a__local21, _0a__sqrt_add, _0a__size4
ADD _0a__local17, _0a__local17, _0a__local21, _0a__size4
MOV _0a__local20, _0a__sqrt_res, _0a__size4
MOV _0a__local22, _0a__sqrt_add, _0a__size4
ADD _0a__local20, _0a__local20, _0a__local22, _0a__size4
MUL _0a__local17, _0a__local17, _0a__local20, _0a__size4
MOV _0a__local19, _0a__sqrt_aa, _0a__size4
LT _0a__local17, _0a__local17, _0a__local19, _0a__size4
LEA _0a__local18, _0a__local17
$CLEA _0a__local18, _0a__zero, _0a__local15 
$LEA _0a__zero, _0a__local16 
_0a__local15:
MOV _0a__sqrt_res, _0a__sqrt_res, _0a__size4
MOV _0a__local23, _0a__sqrt_add, _0a__size4
ADD _0a__sqrt_res, _0a__sqrt_res, _0a__local23, _0a__size4
_0a__local16:
MOV _0a__sqrt_add, _0a__sqrt_add, _0a__size4
MOV_CONST 2, _0a__local24
DIV _0a__sqrt_add, _0a__sqrt_add, _0a__local24, _0a__size4
$LEA _0a__zero, _0a__local11 
_0a__local9:
MOV sqrt - 8, _0a__sqrt_res, _0a__size4
LEA _0a__local25, _0a__size4
LEA _0a__local26, sqrt - 4
$MOV _0a__zero, _0a__local26, _0a__local25
; arguments
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
f:
MOV f - 8, f - 12, _0a__size4
MOV_CONST 1000, _0a__local27
MUL f - 8, f - 8, _0a__local27, _0a__size4
LEA _0a__local28, _0a__size4
LEA _0a__local29, f - 4
$MOV _0a__zero, _0a__local29, _0a__local28
_0a__local0:
.dd 0
_0a__local1:
.dd 0
_0a__local2:
.dd 0
_0a__local3:
.dd 0
_0a__local4:
.dd 0
_0a__local5:
.dd 0
_0a__local6:
.dd 0
_0a__local7:
.dd 0
_0a__sqrt_aa:
.dd 0
_0a__sqrt_res:
.dd 0
_0a__sqrt_add:
.dd 0
_0a__local8:
.dd 0
_0a__local12:
.dd 0
_0a__local13:
.dd 0
_0a__local14:
.dd 0
_0a__local17:
.dd 0
_0a__local18:
.dd 0
_0a__local19:
.dd 0
_0a__local20:
.dd 0
_0a__local21:
.dd 0
_0a__local22:
.dd 0
_0a__local23:
.dd 0
_0a__local24:
.dd 0
_0a__local25:
.dd 0
_0a__local26:
.dd 0
_0a__local27:
.dd 0
_0a__local28:
.dd 0
_0a__local29:
.dd 0
_0a__size4:
.dd 4
_0a__size1:
.dd 1
_0a__zero:
.dd 0

; arguments
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
draw:
MOV_CONST 10, put4 - 12
MOV_CONST 5, f - 12
LEA f - 4, _1b__local0
$LEA _1b__zero, f
_1b__local0:
MOV fmul - 12, f - 8, _1b__size4
MOV_CONST 5, f - 12
LEA f - 4, _1b__local1
$LEA _1b__zero, f
_1b__local1:
MOV fmul - 16, f - 8, _1b__size4
LEA fmul - 4, _1b__local2
$LEA _1b__zero, fmul
_1b__local2:
MOV sqrt - 12, fmul - 8, _1b__size4
LEA sqrt - 4, _1b__local3
$LEA _1b__zero, sqrt
_1b__local3:
MOV put4 - 16, sqrt - 8, _1b__size4
LEA put4 - 4, _1b__local4
$LEA _1b__zero, put4
_1b__local4:
MOV _1b__draw_t, put4 - 8, _1b__size4
MOV_CONST 10, out - 12
MOV_CONST 4, out - 16
LEA out - 4, _1b__local5
$LEA _1b__zero, out
_1b__local5:
MOV _1b__draw_t, out - 8, _1b__size4
; arguments
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
main:
MOV_CONST 24576, _1b__main_end
MOV_CONST 24576, _1b__main_start
LEA _1b__local10, _1b__local9
_1b__local8:
MOV_CONST 1, _1b__local9
$CLEA _1b__local10, _1b__zero, _1b__local7 
$LEA _1b__zero, _1b__local6
_1b__local7:
LEA draw - 4, _1b__local11
$LEA _1b__zero, draw
_1b__local11:
MOV _1b__main_t, draw - 8, _1b__size4
$LEA _1b__zero, _1b__local8 
_1b__local6:
MOV_CONST 0, main - 8
LEA _1b__local12, _1b__size4
LEA _1b__local13, main - 4
$MOV _1b__zero, _1b__local13, _1b__local12
_1b__draw_t:
.dd 0
_1b__main_end:
.dd 0
_1b__main_start:
.dd 0
_1b__main_t:
.dd 0
_1b__main_x:
.dd 0
_1b__main_y:
.dd 0
_1b__local9:
.dd 0
_1b__local10:
.dd 0
_1b__local12:
.dd 0
_1b__local13:
.dd 0
_1b__size4:
.dd 4
_1b__size1:
.dd 1
_1b__zero:
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


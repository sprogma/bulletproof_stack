; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
fmul:
MOV fmul - 8, fmul - 12, _size4
MOV _local1, fmul - 16, _size4
MUL fmul - 8, fmul - 8, _local1, _size4
MOV_CONST 1000, _local0
DIV fmul - 8, fmul - 8, _local0, _size4
LEA _local2, _size4
LEA _local3, fmul - 4
$MOV _zero, _local3, _local2
; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
fdiv:
MOV fdiv - 8, fdiv - 12, _size4
MOV_CONST 1000, _local5
MUL fdiv - 8, fdiv - 8, _local5, _size4
MOV _local4, fdiv - 16, _size4
DIV fdiv - 8, fdiv - 8, _local4, _size4
LEA _local6, _size4
LEA _local7, fdiv - 4
$MOV _zero, _local7, _local6
; arguments
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
sqrt:
MOV _local8, sqrt - 12, _size4
MOV_CONST 1000, _local9
MUL _local8, _local8, _local9, _size4
MOV _sqrt_aa, _local8, _size4
MOV_CONST 0, _local10
MOV _sqrt_res, _local10, _size4
MOV_CONST 46340, _local11
MOV _sqrt_add, _local11, _size4
LEA _local16, _local15
_local14:
MOV _local15, _sqrt_add, _size4
MOV_CONST 0, _local17
LT _local15, _local17, _local15, _size4
$CLEA _local16, _zero, _local13 
$LEA _zero, _local12
_local13:
MOV _local20, _sqrt_res, _size4
MOV _local24, _sqrt_add, _size4
ADD _local20, _local20, _local24, _size4
MOV _local23, _sqrt_res, _size4
MOV _local25, _sqrt_add, _size4
ADD _local23, _local23, _local25, _size4
MUL _local20, _local20, _local23, _size4
MOV _local22, _sqrt_aa, _size4
LT _local20, _local20, _local22, _size4
LEA _local21, _local20
$CLEA _local21, _zero, _local18 
$LEA _zero, _local19 
_local18:
MOV _local26, _sqrt_res, _size4
MOV _local27, _sqrt_add, _size4
ADD _local26, _local26, _local27, _size4
MOV _sqrt_res, _local26, _size4
_local19:
MOV _local28, _sqrt_add, _size4
MOV_CONST 2, _local29
DIV _local28, _local28, _local29, _size4
MOV _sqrt_add, _local28, _size4
$LEA _zero, _local14 
_local12:
MOV sqrt - 8, _sqrt_res, _size4
LEA _local30, _size4
LEA _local31, sqrt - 4
$MOV _zero, _local31, _local30
; arguments
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
f:
MOV f - 8, f - 12, _size4
MOV_CONST 1000, _local32
MUL f - 8, f - 8, _local32, _size4
LEA _local33, _size4
LEA _local34, f - 4
$MOV _zero, _local34, _local33
_local0:
.dd 0
_local1:
.dd 0
_local2:
.dd 0
_local3:
.dd 0
_local4:
.dd 0
_local5:
.dd 0
_local6:
.dd 0
_local7:
.dd 0
_sqrt_aa:
.dd 0
_sqrt_res:
.dd 0
_sqrt_add:
.dd 0
_local8:
.dd 0
_local9:
.dd 0
_local10:
.dd 0
_local11:
.dd 0
_local15:
.dd 0
_local16:
.dd 0
_local17:
.dd 0
_local20:
.dd 0
_local21:
.dd 0
_local22:
.dd 0
_local23:
.dd 0
_local24:
.dd 0
_local25:
.dd 0
_local26:
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
_size4:
.dd 4
_size1:
.dd 1
_zero:
.dd 0

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
MOV _sqrt_aa, sqrt - 12, _size4
MOV_CONST 1000, _local8
MUL _sqrt_aa, _sqrt_aa, _local8, _size4
MOV_CONST 0, _sqrt_res
MOV_CONST 46340, _sqrt_add
LEA _local13, _local12
_local11:
MOV _local12, _sqrt_add, _size4
MOV_CONST 1, _local14
LT _local12, _local12, _local14, _size4
INV _local12, _local12, _size4
$CLEA _local13, _zero, _local10 
$LEA _zero, _local9
_local10:
MOV _local17, _sqrt_res, _size4
MOV _local21, _sqrt_add, _size4
ADD _local17, _local17, _local21, _size4
MOV _local20, _sqrt_res, _size4
MOV _local22, _sqrt_add, _size4
ADD _local20, _local20, _local22, _size4
MUL _local17, _local17, _local20, _size4
MOV _local19, _sqrt_aa, _size4
LT _local17, _local17, _local19, _size4
LEA _local18, _local17
$CLEA _local18, _zero, _local15 
$LEA _zero, _local16 
_local15:
MOV _sqrt_res, _sqrt_res, _size4
MOV _local23, _sqrt_add, _size4
ADD _sqrt_res, _sqrt_res, _local23, _size4
_local16:
MOV _sqrt_add, _sqrt_add, _size4
MOV_CONST 2, _local24
DIV _sqrt_add, _sqrt_add, _local24, _size4
$LEA _zero, _local11 
_local9:
MOV sqrt - 8, _sqrt_res, _size4
LEA _local25, _size4
LEA _local26, sqrt - 4
$MOV _zero, _local26, _local25
; arguments
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
f:
MOV f - 8, f - 12, _size4
MOV_CONST 1000, _local27
MUL f - 8, f - 8, _local27, _size4
LEA _local28, _size4
LEA _local29, f - 4
$MOV _zero, _local29, _local28
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
_local12:
.dd 0
_local13:
.dd 0
_local14:
.dd 0
_local17:
.dd 0
_local18:
.dd 0
_local19:
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
_size4:
.dd 4
_size1:
.dd 1
_zero:
.dd 0

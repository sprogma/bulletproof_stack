; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
fadd:
MOV fadd - 8, fadd - 12, _size4
MOV _local0, fadd - 16, _size4
ADD fadd - 8, fadd - 8, _local0, _size4
LEA _local1, _size4
LEA _local2, fadd - 4
$MOV _zero, _local2, _local1
; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
fsub:
MOV fsub - 8, fsub - 12, _size4
MOV _local3, fsub - 16, _size4
SUB fsub - 8, fsub - 8, _local3, _size4
LEA _local4, _size4
LEA _local5, fsub - 4
$MOV _zero, _local5, _local4
; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
fmul:
MOV fmul - 8, fmul - 12, _size4
MOV _local7, fmul - 16, _size4
MUL fmul - 8, fmul - 8, _local7, _size4
MOV_CONST 1000, _local6
DIV fmul - 8, fmul - 8, _local6, _size4
LEA _local8, _size4
LEA _local9, fmul - 4
$MOV _zero, _local9, _local8
; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
fdiv:
MOV fdiv - 8, fdiv - 12, _size4
MOV_CONST 1000, _local11
MUL fdiv - 8, fdiv - 8, _local11, _size4
MOV _local10, fdiv - 16, _size4
DIV fdiv - 8, fdiv - 8, _local10, _size4
LEA _local12, _size4
LEA _local13, fdiv - 4
$MOV _zero, _local13, _local12
; arguments
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
sqrt:
MOV _sqrt_aa, sqrt - 12, _size4
MOV_CONST 1000, _local14
MUL _sqrt_aa, _sqrt_aa, _local14, _size4
MOV_CONST 0, _sqrt_res
MOV_CONST 1073741824, _sqrt_add
LEA _local19, _local18
_local17:
MOV _local18, _sqrt_add, _size4
MOV_CONST 0, _local20
LT _local18, _local18, _local20, _size4
INV _local18, _local18, _size4
$CLEA _local19, _zero, _local16 
$LEA _zero, _local15
_local16:
MOV _local23, _sqrt_res, _size4
MOV _local27, _sqrt_add, _size4
ADD _local23, _local23, _local27, _size4
MOV _local26, _sqrt_res, _size4
MOV _local28, _sqrt_add, _size4
ADD _local26, _local26, _local28, _size4
MUL _local23, _local23, _local26, _size4
MOV _local25, _sqrt_aa, _size4
LT _local23, _local23, _local25, _size4
LEA _local24, _local23
$CLEA _local24, _zero, _local21 
$LEA _zero, _local22 
_local21:
MOV _sqrt_res, _sqrt_res, _size4
MOV _local29, _sqrt_add, _size4
ADD _sqrt_res, _sqrt_res, _local29, _size4
_local22:
MOV _sqrt_add, _sqrt_add, _size4
MOV_CONST 2, _local30
DIV _sqrt_add, _sqrt_add, _local30, _size4
$LEA _zero, _local17 
_local15:
MOV sqrt - 8, sqrt - 12, _size4
LEA _local31, _size4
LEA _local32, sqrt - 4
$MOV _zero, _local32, _local31
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
_local8:
.dd 0
_local9:
.dd 0
_local10:
.dd 0
_local11:
.dd 0
_local12:
.dd 0
_local13:
.dd 0
_sqrt_aa:
.dd 0
_sqrt_res:
.dd 0
_sqrt_add:
.dd 0
_local14:
.dd 0
_local18:
.dd 0
_local19:
.dd 0
_local20:
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
_size4:
.dd 4
_size1:
.dd 1
_zero:
.dd 0

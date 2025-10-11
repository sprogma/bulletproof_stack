; arguments
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
draw:
MOV_CONST 10, put4 - 12
MOV_CONST 5, f - 12
LEA f - 4, _local0
$LEA _zero, f
_local0:
MOV fmul - 12, f - 8, _size4
MOV_CONST 5, f - 12
LEA f - 4, _local1
$LEA _zero, f
_local1:
MOV fmul - 16, f - 8, _size4
LEA fmul - 4, _local2
$LEA _zero, fmul
_local2:
MOV sqrt - 12, fmul - 8, _size4
LEA sqrt - 4, _local3
$LEA _zero, sqrt
_local3:
MOV put4 - 16, sqrt - 8, _size4
LEA put4 - 4, _local4
$LEA _zero, put4
_local4:
MOV _draw_t, put4 - 8, _size4
MOV_CONST 10, out - 12
MOV_CONST 4, out - 16
LEA out - 4, _local5
$LEA _zero, out
_local5:
MOV _draw_t, out - 8, _size4
; arguments
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
main:
MOV_CONST 24576, _main_end
MOV_CONST 24576, _main_start
LEA _local10, _local9
_local8:
MOV_CONST 1, _local9
$CLEA _local10, _zero, _local7 
$LEA _zero, _local6
_local7:
LEA draw - 4, _local11
$LEA _zero, draw
_local11:
MOV _main_t, draw - 8, _size4
$LEA _zero, _local8 
_local6:
MOV_CONST 0, main - 8
LEA _local12, _size4
LEA _local13, main - 4
$MOV _zero, _local13, _local12
_draw_t:
.dd 0
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
_local9:
.dd 0
_local10:
.dd 0
_local12:
.dd 0
_local13:
.dd 0
_size4:
.dd 4
_size1:
.dd 1
_zero:
.dd 0

; arguments
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
main:
MOV_CONST 16384, put4 - 12
MOV_CONST 1024, _local0
ADD put4 - 12, put4 - 12, _local0, _size4
MOV_CONST 16909060, put4 - 16
LEA put4 - 4, _local1
$LEA _zero, put4
_local1:
MOV _main_x, put4 - 8, _size4
MOV_CONST 16384, put4 - 12
MOV_CONST 1024, _local2
MOV_CONST 4, _local3
ADD _local2, _local2, _local3, _size4
ADD put4 - 12, put4 - 12, _local2, _size4
MOV_CONST 16909060, put4 - 16
LEA put4 - 4, _local4
$LEA _zero, put4
_local4:
MOV _main_x, put4 - 8, _size4
MOV_CONST 16384, out - 12
MOV_CONST 1024, _local5
ADD out - 12, out - 12, _local5, _size4
MOV_CONST 8, out - 16
LEA out - 4, _local6
$LEA _zero, out
_local6:
MOV _main_x, out - 8, _size4
MOV_CONST 0, main - 8
LEA _local7, _size4
LEA _local8, main - 4
$MOV _zero, _local8, _local7
_main_x:
.dd 0
_local0:
.dd 0
_local2:
.dd 0
_local3:
.dd 0
_local5:
.dd 0
_local7:
.dd 0
_local8:
.dd 0
_size4:
.dd 4
_size1:
.dd 1
_zero:
.dd 0

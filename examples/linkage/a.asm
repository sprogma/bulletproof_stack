; arguments
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
main:
MOV_CONST 5, _main_x
MOV_CONST 7, _main_y
MOV add - 12, _main_x, _size4
MOV add - 16, _main_y, _size4
LEA add - 4, _local0
$LEA _zero, add
_local0:
MOV main - 8, add - 8, _size4
LEA _local1, _size4
LEA _local2, main - 4
$MOV _zero, _local2, _local1
_main_x:
.dd 0
_main_y:
.dd 0
_local1:
.dd 0
_local2:
.dd 0
_size4:
.dd 4
_size1:
.dd 1
_zero:
.dd 0

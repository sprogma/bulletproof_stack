$LEA _zero, main

; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE

main:
MOV_CONST 10, _main_a
MOV_CONST 1, _main_s
LEA _local4, _local3
_local2:
MOV _local3, _main_a, _size4
MOV_CONST 0, _local5
EQ _local3, _local3, _local5, _size4
ALL _local3, _local3, _size4
INV _local3, _local3, _size4
$CLEA _local4, _zero, _local1
$LEA _zero, _local0
_local1:
MOV _main_s, _main_s, _size4
MOV _local6, _main_a, _size4
MUL _main_s, _main_s, _local6, _size4
MOV _main_a, _main_a, _size4
MOV_CONST 1, _local7
SUB _main_a, _main_a, _local7, _size4
$LEA _zero, _local2
_local0:
MOV main - 8, _main_s, _size4

OUT 1, main - 8, _size4
OUT 2, main - 8, _size4
.db 0xFF

_main_a:
.dd 0
_main_s:
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
_size4:
.dd 4
_size1:
.dd 1
_int_tmp:
.dd 0
_byte_tmp:
.db 0
_zero:
.db 0

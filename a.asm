; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
c:
MOV _c_x, c - 12, _size4
MOV _c_y, c - 16, _size4
MOV c - 8, _c_x, _size4
MOV _local0, _c_y, _size4
ADD c - 8, c - 8, _local0, _size4
LEA _local1, _size4
LEA _local2, c - 4
$MOV _zero, _local2, _local1
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
main:
MOV_CONST 1, _main_a
MOV_CONST 2, _main_b
MOV c - 12, _main_a, _size4
MOV c - 16, _main_b, _size4
LEA c - 4, _local3
$LEA _zero, c
_local3:
MOV main - 8, c - 8, _size4
LEA _local4, _size4
LEA _local5, main - 4
$MOV _zero, _local5, _local4
c - 12:
.dd 0
c - 16:
.dd 0
_c_x:
.dd 0
_c_y:
.dd 0
_local0:
.dd 0
_local1:
.dd 0
_local2:
.dd 0
_main_a:
.dd 0
_main_b:
.dd 0
_local4:
.dd 0
_local5:
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

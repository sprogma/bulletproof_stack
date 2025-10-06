; return value
;.dd 0xBEBEBEBE
; return address
;.dd 0xBEBEBEBE
main:
LEA _main_a_ptr, _main_a
LEA _size4_ptr, _size4
MOV_CONST 1, _main_a
MOV_CONST 0x5000, _main_s
LEA _local4, _local3
_local2:
MOV _local3, _main_s, _size4
MOV_CONST 33533952, _local5
EQ _local3, _local3, _local5, _size4
ALL _local3, _local3, _size4
INV _local3, _local3, _size4
$CLEA _local4, _zero, _local1 
$LEA _zero, _local0
_local1:
MOV _main_a, _main_a, _size4
MOV_CONST 9368709, _local6
ADD _main_a, _main_a, _local6, _size4
$MOV _main_s, _main_a_ptr, _size4_ptr
MOV _main_s, _main_s, _size4
MOV_CONST 4, _local7
ADD _main_s, _main_s, _local7, _size4
$LEA _zero, _local2 
_local0:

MOV_CONST 0x5000, _main_s
OUT 1, _main_s, out_size

this:
$LEA _zero, this

.db 0xFF

_size4_ptr:
.dd 0
_main_a_ptr:
.dd 0
out_size:
.dd 1764000 ; use only first 10 seconds
; 33500000 ~ have near this total bytes
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

; return value
;.dd 0xBEBEBEBE
; return address
;.dd 0xBEBEBEBE
main:
LEA _main_a_ptr, _main_a
LEA _size4_ptr, _size4
MOV_CONST 20480, _main_s
MOV_CONST 0, _main_a
LEA _local4, _local3
_local2:
MOV _local3, _main_s, _size4
MOV_CONST 285080, _local5
EQ _local3, _local3, _local5, _size4
ALL _local3, _local3, _size4
INV _local3, _local3, _size4
$CLEA _local4, _zero, _local1 
$LEA _zero, _local0
_local1:
MOV _main_a, _main_a, _size4
MOV_CONST 5368709, _local6
ADD _main_a, _main_a, _local6, _size4
$MOV _main_s, _main_a_ptr, _size4_ptr
MOV _main_s, _main_s, _size4
MOV_CONST 4, _local7
ADD _main_s, _main_s, _local7, _size4
$LEA _zero, _local2 
_local0:
LEA _local12, _local11
_local10:
MOV _local11, _main_s, _size4
MOV_CONST 373280, _local13
EQ _local11, _local11, _local13, _size4
ALL _local11, _local11, _size4
INV _local11, _local11, _size4
$CLEA _local12, _zero, _local9 
$LEA _zero, _local8
_local9:
MOV _main_a, _main_a, _size4
MOV_CONST 8368709, _local14
ADD _main_a, _main_a, _local14, _size4
$MOV _main_s, _main_a_ptr, _size4_ptr
MOV _main_s, _main_s, _size4
MOV_CONST 4, _local15
ADD _main_s, _main_s, _local15, _size4
$LEA _zero, _local10 
_local8:
LEA _local20, _local19
_local18:
MOV _local19, _main_s, _size4
MOV_CONST 637880, _local21
EQ _local19, _local19, _local21, _size4
ALL _local19, _local19, _size4
INV _local19, _local19, _size4
$CLEA _local20, _zero, _local17 
$LEA _zero, _local16
_local17:
MOV _main_a, _main_a, _size4
MOV_CONST 10368709, _local22
ADD _main_a, _main_a, _local22, _size4
$MOV _main_s, _main_a_ptr, _size4_ptr
MOV _main_s, _main_s, _size4
MOV_CONST 4, _local23
ADD _main_s, _main_s, _local23, _size4
$LEA _zero, _local18 
_local16:
LEA _local28, _local27
_local26:
MOV _local27, _main_s, _size4
MOV_CONST 726080, _local29
EQ _local27, _local27, _local29, _size4
ALL _local27, _local27, _size4
INV _local27, _local27, _size4
$CLEA _local28, _zero, _local25 
$LEA _zero, _local24
_local25:
MOV _main_a, _main_a, _size4
MOV_CONST 5368709, _local30
ADD _main_a, _main_a, _local30, _size4
$MOV _main_s, _main_a_ptr, _size4_ptr
MOV _main_s, _main_s, _size4
MOV_CONST 4, _local31
ADD _main_s, _main_s, _local31, _size4
$LEA _zero, _local26 

_local24:

MOV_CONST 20480, _main_s
OUT 1, _main_s, out_size


this:
$LEA _zero, this


.db 0xFF

out_size:
.dd 705600
_size4_ptr:
.dd 0
_main_a_ptr:
.dd 0
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
_local11:
.dd 0
_local12:
.dd 0
_local13:
.dd 0
_local14:
.dd 0
_local15:
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

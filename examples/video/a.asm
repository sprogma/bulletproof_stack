$LEA _zero, main

; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
diff:
.dd 0
main:
MOV_CONST 0x2000, _main_s
MOV_CONST 0, _main_a
LEA _local4, _local3
_local2:
MOV _local3, _main_a, _size4
MOV_CONST 160, _local5
EQ _local3, _local3, _local5, _size4
ALL _local3, _local3, _size4
INV _local3, _local3, _size4
$CLEA _local4, _zero, _local1 
$LEA _zero, _local0
_local1:
MOV_CONST 0, _main_b
LEA _local10, _local9
_local8:
MOV _local9, _main_b, _size4
MOV_CONST 90, _local11
EQ _local9, _local9, _local11, _size4
ALL _local9, _local9, _size4
INV _local9, _local9, _size4
$CLEA _local10, _zero, _local7 
$LEA _zero, _local6
_local7:
MOV _main_s, _main_s, _size4
MOV_CONST 1, _local12
ADD _main_s, _main_s, _local12, _size4
MOV _local15, _main_s, _size4
MOV_CONST 23, _local19
DIV _local15, _local15, _local19, _size4
MOV_CONST 23, _local18
MUL _local15, _local15, _local18, _size4
MOV _local17, _main_s, _size4
ADD _local15, _local15, diff, _size4
EQ _local15, _local15, _local17, _size4
ALL _local15, _local15, _size4
MUL _main_ptr, _main_s, _size4, _size4
LEA _local16, _local15
$CLEA _local16, _zero, _local13 
$MOV_CONST 0, _main_ptr
$LEA _zero, _local14 
_local13:
$MOV_CONST 0xFFFFFFFF, _main_ptr
_local14:
MOV _main_b, _main_b, _size4
MOV_CONST 1, _local20
ADD _main_b, _main_b, _local20, _size4
$LEA _zero, _local8 
_local6:
MOV _main_a, _main_a, _size4
MOV_CONST 1, _local21
ADD _main_a, _main_a, _local21, _size4
$LEA _zero, _local2 
_local0:

LEA count_ptr, count
MOV_CONST 0x8000, _main_s
$OUT 1, _main_s, count_ptr

INC diff, diff, _size4
MOV_CONST 23, flag
EQ flag, flag, diff, _size4
INV flag, flag, _size4
LEA flag_ptr, flag
$CLEA flag_ptr, _zero, main
MOV_CONST 0, diff
$LEA _zero, main

.db 0xFF

flag:
.dd 0
flag_ptr:
.dd 0

count_ptr:
.dd 0
count:
.dd 57600

_main_a:
.dd 0
_main_b:
.dd 0
_main_s:
.dd 0
_main_ptr:
.dd 0
_local3:
.dd 0
_local4:
.dd 0
_local5:
.dd 0
_local9:
.dd 0
_local10:
.dd 0
_local11:
.dd 0
_local12:
.dd 0
_local15:
.dd 0
_local16:
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

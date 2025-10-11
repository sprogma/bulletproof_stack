; arguments
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
draw:
MOV_CONST 24576, _draw_start
MOV_CONST 24576, _draw_end
MOV_CONST 0, _draw_x
LEA _local4, _local3
_local2:
MOV _local3, _draw_x, _size4
MOV_CONST 160, _local5
EQ _local3, _local3, _local5, _size4
ALL _local3, _local3, _size4
INV _local3, _local3, _size4
$CLEA _local4, _zero, _local1 
$LEA _zero, _local0
_local1:
MOV_CONST 0, _draw_y
LEA _local10, _local9
_local8:
MOV _local9, _draw_y, _size4
MOV_CONST 90, _local11
EQ _local9, _local9, _local11, _size4
ALL _local9, _local9, _size4
INV _local9, _local9, _size4
$CLEA _local10, _zero, _local7 
$LEA _zero, _local6
_local7:
MOV _draw_end, _draw_end, _size4
MOV_CONST 4, _local12
ADD _draw_end, _draw_end, _local12, _size4
MOV _draw_y, _draw_y, _size4
MOV_CONST 1, _local13
ADD _draw_y, _draw_y, _local13, _size4
$LEA _zero, _local8 
_local6:
MOV _draw_x, _draw_x, _size4
MOV_CONST 1, _local14
ADD _draw_x, _draw_x, _local14, _size4
$LEA _zero, _local2 
_local0:
MOV out - 12, _draw_start, _size4
MOV out - 16, _draw_end, _size4
MOV _local15, _draw_start, _size4
SUB out - 16, out - 16, _local15, _size4
LEA out - 4, _local16
$LEA _zero, out
_local16:
MOV _draw_t, out - 8, _size4
MOV_CONST 0, draw - 8
LEA _local17, _size4
LEA _local18, draw - 4
$MOV _zero, _local18, _local17
; arguments
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
main:
MOV_CONST 24576, _main_end
MOV_CONST 24576, _main_start
LEA _local23, _local22
_local21:
MOV_CONST 1, _local22
$CLEA _local23, _zero, _local20 
$LEA _zero, _local19
_local20:
LEA draw - 4, _local24
$LEA _zero, draw
_local24:
MOV _main_t, draw - 8, _size4
$LEA _zero, _local21 
_local19:
MOV_CONST 0, main - 8
LEA _local25, _size4
LEA _local26, main - 4
$MOV _zero, _local26, _local25
_draw_t:
.dd 0
_draw_start:
.dd 0
_draw_end:
.dd 0
_draw_x:
.dd 0
_draw_y:
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
_local13:
.dd 0
_local14:
.dd 0
_local15:
.dd 0
_local17:
.dd 0
_local18:
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
_local22:
.dd 0
_local23:
.dd 0
_local25:
.dd 0
_local26:
.dd 0
_size4:
.dd 4
_size1:
.dd 1
_zero:
.dd 0

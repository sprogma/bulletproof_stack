
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
main:

MOV _frame_base, video_start, _size4

MOV_CONST 8, _tmp1
MUL _frame_size, _xsize, _ysize, _size4
DIV _frame_size, _frame_size, _tmp1, _size4

MOV_CONST 8, _tmp1
DIV _frame_line_size, _xsize, _tmp1, _size4

_inf_loop:
MOV _memend, _membase, _size4
MOV_CONST 0, _y
_loop_1:

MOV_CONST 0, _x
_loop_2:

; background
$MOV_CONST 255, _memend

; unpack frame
MOV_CONST 8, _tmp2 ; 8 - bit per byte
DIV _tmp1, _x, _tmp2, _size4
MUL _tmp3, _tmp1, _tmp2, _size4 ; _tmp2 = (x / 8) * 8
SUB _tmp2, _x, _tmp3, _size4 ; _tmp2 = x - (x / 8) * 8
; generate mask from _tmp2: 1 << _tmp2
; use LUT
LEA _tmp3, _mask_LUT
ADD _tmp2, _tmp2, _tmp3, _size4
LEA _tmp_ptr2, _tmp2
LEA _tmp_ptr3, _size4
$MOV _tmp_ptr2, _tmp2, _tmp_ptr3
; check: if mask is 1 - add dot on screen
ADD _tmp1, _tmp1, _frame_base, _size4
LEA _tmp_ptr3, _tmp3
LEA _tmp_ptr4, _size4
$MOV _tmp_ptr3, _tmp1, _tmp_ptr4
; now: tmp2 = mask of pixel
; now: tmp3 = byte from data
AND _tmp1, _tmp2, _tmp3, _size4
ANY _tmp1, _tmp1, _size4
INV _tmp1, _tmp1, _size4
LEA _tmp_ptr1, _tmp1
$CLEA _tmp_ptr1, _zero, _black_pixel
$MOV_CONST 65280, _memend
_black_pixel:

; move memory pointer
ADD _memend, _memend, _four, _size4

; _loop_1
INC _x, _x, _size4
LEA _tmp_ptr1, _tmp1
LT _tmp1, _x, _xsize, _size4
$CLEA _tmp_ptr1, _zero, _loop_2

; go to next frame's line
ADD _frame_base, _frame_base, _frame_line_size, _size4

; _loop_2
INC _y, _y, _size4
LEA _tmp_ptr1, _tmp1
LT _tmp1, _y, _ysize, _size4
$CLEA _tmp_ptr1, _zero, _loop_1

; draw image
SUB _tmp1, _memend, _membase, _size4
LEA _tmp_ptr1, _tmp1
$OUT 1, _membase, _tmp_ptr1


; infite loop
$LEA _zero, _inf_loop

; return
LEA _tmp_ptr2, main - 4
LEA _tmp_ptr1, _size4
$MOV _zero, _tmp_ptr2, _tmp_ptr1


; need video to be loaded at this pointer
video_start:
.dd 0x40000
_frame_base:
.dd 0
_frame_size:
.dd 0
_frame_line_size:
.dd 0

_xsize:
.dd 160
_ysize:
.dd 90

_mask_LUT:
.db 0x01
.db 0x02
.db 0x04
.db 0x08
.db 0x10
.db 0x20
.db 0x40
.db 0x80

_x:
.dd 0
_y:
.dd 0

_tmp1:
.dd 0
_tmp2:
.dd 0
_tmp3:
.dd 0
_tmp4:
.dd 0
_tmp_ptr1:
.dd 0
_tmp_ptr2:
.dd 0
_tmp_ptr3:
.dd 0
_tmp_ptr4:
.dd 0

_one:
.dd 1
_four:
.dd 4

_zero:
.dd 0
_flt_size:
.dd 4
_flt_base:
.dd 1000
_size4:
.dd 4
_size1:
.dd 1

_membase:
.dd 0x10000
_memend:
.dd 0

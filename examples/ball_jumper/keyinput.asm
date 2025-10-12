
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
read_key:

IN 2, _scancode, _size8

; if read SDL_SCANCODE_W = 26, move forward
MOV_CONST 26, _tmp1
EQ _tmp1, _tmp1, _scancode, _size4
ALL _tmp1, _tmp1, _size4
LEA _tmp_ptr1, _tmp1
$CLEA _tmp_ptr1, _zero, _equal
$LEA _zero, _not_equal
_equal:
MOV_CONST 200, _tmp1
ADD gx, gx, _tmp1, _flt_size
_not_equal:
; [ working ]
; OUT 3, _scancode, _size8


LEA _tmp_ptr2, read_key - 4
LEA _tmp_ptr1, _size4
$MOV _zero, _tmp_ptr2, _tmp_ptr1

_scancode:
.dd 0
_is_up:
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
_size8:
.dd 8


.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
physics:

_poll_loop:
IN 2, _scancode, _size8

ANY _tmp1, _scancode, _size4
LEA _tmp_ptr1, _tmp1
$CLEA _tmp_ptr1, _zero, _handle

; go physics
ADD gx, gx, _dx, _flt_size
ADD gy, gy, _dy, _flt_size
ADD gz, gz, _dz, _flt_size

LEA _tmp_ptr2, physics - 4
LEA _tmp_ptr1, _size4
$MOV _zero, _tmp_ptr2, _tmp_ptr1

_handle:

; if read SDL_SCANCODE_W = 26, move forward
MOV_CONST 26, _tmp1
EQ _tmp1, _tmp1, _scancode, _size4
ALL _tmp1, _tmp1, _size4
INV _tmp1, _tmp1, _size4
LEA _tmp_ptr1, _tmp1
$CLEA _tmp_ptr1, _zero, _not_equal1
; keydown/up?
MOV_CONST 1, _tmp1
EQ _tmp1, _tmp1, _is_up, _size4
ALL _tmp1, _tmp1, _size4
$CLEA _tmp_ptr1, _zero, _key_up1
MOV_CONST 200, _dz
$LEA _zero, _not_equal1
_key_up1:
MOV_CONST 0, _dz
_not_equal1:


; if read SDL_SCANCODE_S = 22, move back
MOV_CONST 22, _tmp1
EQ _tmp1, _tmp1, _scancode, _size4
ALL _tmp1, _tmp1, _size4
INV _tmp1, _tmp1, _size4
LEA _tmp_ptr1, _tmp1
$CLEA _tmp_ptr1, _zero, _not_equal2
; keydown/up?
MOV_CONST 1, _tmp1
EQ _tmp1, _tmp1, _is_up, _size4
ALL _tmp1, _tmp1, _size4
$CLEA _tmp_ptr1, _zero, _key_up2
MOV_CONST -200, _dz
$LEA _zero, _not_equal2
_key_up2:
MOV_CONST 0, _dz
_not_equal2:

; if read SDL_SCANCODE_A = 4, move left
MOV_CONST 4, _tmp1
EQ _tmp1, _tmp1, _scancode, _size4
ALL _tmp1, _tmp1, _size4
INV _tmp1, _tmp1, _size4
LEA _tmp_ptr1, _tmp1
$CLEA _tmp_ptr1, _zero, _not_equal3
; keydown/up?
MOV_CONST 1, _tmp1
EQ _tmp1, _tmp1, _is_up, _size4
ALL _tmp1, _tmp1, _size4
$CLEA _tmp_ptr1, _zero, _key_up3
MOV_CONST -200, _dx
$LEA _zero, _not_equal3
_key_up3:
MOV_CONST 0, _dx
_not_equal3:


; if read SDL_SCANCODE_D = 7, move left
MOV_CONST 7, _tmp1
EQ _tmp1, _tmp1, _scancode, _size4
ALL _tmp1, _tmp1, _size4
INV _tmp1, _tmp1, _size4
LEA _tmp_ptr1, _tmp1
$CLEA _tmp_ptr1, _zero, _not_equal4
; keydown/up?
MOV_CONST 1, _tmp1
EQ _tmp1, _tmp1, _is_up, _size4
ALL _tmp1, _tmp1, _size4
$CLEA _tmp_ptr1, _zero, _key_up4
MOV_CONST 200, _dx
$LEA _zero, _not_equal4
_key_up4:
MOV_CONST 0, _dx
_not_equal4:


$LEA _zero, _poll_loop

_scancode:
.dd 0
_is_up:
.dd 0

_dx:
.dd 0
_dy:
.dd 0
_dz:
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

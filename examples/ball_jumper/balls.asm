.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
main:

_inf_loop:
MOV _memend, _membase, _size4
MOV_CONST 0, _y
_loop_1:

MOV_CONST 0, _x
_loop_2:

; background
$MOV_CONST 0, _memend

; create ray
MOV_CONST 80, _tmp1
SUB _rx, _x, _tmp1, _flt_size
MOV_CONST 45, _tmp1
SUB _ry, _tmp1, _y, _flt_size
MOV_CONST 8, _tmp1
MUL _rx, _rx, _tmp1, _flt_size
MUL _ry, _ry, _tmp1, _flt_size
MOV_CONST 1000, _rz

; remember nearest distance: =+inf
MOV_CONST 1000000, _dst

; cast it with balls
MOV_CONST 0, _i
_loop_3:

; global coodinates
MOV intersect_ball - 12, gx, _flt_size
MOV intersect_ball - 16, gy, _flt_size
MOV intersect_ball - 20, gz, _flt_size
; ray coordinates
MOV intersect_ball - 24, _rx, _flt_size
MOV intersect_ball - 28, _ry, _flt_size
MOV intersect_ball - 32, _rz, _flt_size
; ball position: tmp1 = address of current ball
LEA _tmp1, _balls
MUL _tmp2, _i, _balls_size, _size4
ADD _tmp1, _tmp1, _tmp2, _size4

; load current ball to bx by bz br
LEA _tmp_ptr1, _br
LEA _tmp_ptr2, _balls_size
$MOV _tmp_ptr1, _tmp1, _tmp_ptr2

; load current ball to intersect function
LEA _tmp_ptr1, intersect_ball - 48
LEA _tmp_ptr2, _balls_size
$MOV _tmp_ptr1, _tmp1, _tmp_ptr2

LEA intersect_ball - 4, _intercect_ret_1
$LEA _zero, intersect_ball
_intercect_ret_1:

; if result < 0, when this isn't ball
LT _tmp1, intersect_ball - 8, _zero, _flt_size
LEA _tmp_ptr1, _tmp1
$CLEA _tmp_ptr1, _zero, _no_intercestion

; if _dst < result, when we don't see this ball
LT _tmp1, _dst, intersect_ball - 8, _flt_size
LEA _tmp_ptr1, _tmp1
$CLEA _tmp_ptr1, _zero, _no_intercestion

; remember new _dst
MOV _dst, intersect_ball - 8, _flt_size

; calculate point of intersection
MUL _px, _rx, intersect_ball - 8, _flt_size
DIV _px, _px, _flt_base, _flt_size
ADD _px, _px, gx, _flt_size
MUL _py, _ry, intersect_ball - 8, _flt_size
DIV _py, _py, _flt_base, _flt_size
ADD _py, _py, gy, _flt_size
MUL _pz, _rz, intersect_ball - 8, _flt_size
DIV _pz, _pz, _flt_base, _flt_size
ADD _pz, _pz, gz, _flt_size
; calculate color using phong model
MOV phong - 12, _ldx, _flt_size
MOV phong - 16, _ldy, _flt_size
MOV phong - 20, _ldz, _flt_size
SUB phong - 24, _px, gx, _flt_size
SUB phong - 28, _py, gy, _flt_size
SUB phong - 32, _pz, gz, _flt_size
SUB phong - 36, _px, _bx, _flt_size
SUB phong - 40, _py, _by, _flt_size
SUB phong - 44, _pz, _bz, _flt_size
LEA phong - 4, _phong_ret_1
$LEA _zero, phong
_phong_ret_1:

; convert result to color
MOV_CONST 255, _tmp2
MUL _tmp1, phong - 8, _tmp2, _flt_size
DIV _tmp1, _tmp1, _flt_base, _flt_size

MOV_CONST 256, _tmp2
MUL _tmp1, _tmp1, _tmp2, _size4

LEA _tmp_ptr1, _tmp1
LEA _tmp_ptr2, _flt_size
$MOV _memend, _tmp_ptr1, _tmp_ptr2

_no_intercestion:

; _loop_3
INC _i, _i, _size4
LEA _tmp_ptr1, _tmp1
LT _tmp1, _i, _balls_len, _size4
$CLEA _tmp_ptr1, _zero, _loop_3

; move memory pointer
ADD _memend, _memend, _four, _size4


; _loop_1
INC _x, _x, _size4
LEA _tmp_ptr1, _tmp1
LT _tmp1, _x, _xsize, _size4
$CLEA _tmp_ptr1, _zero, _loop_2

; _loop_2
INC _y, _y, _size4
LEA _tmp_ptr1, _tmp1
LT _tmp1, _y, _ysize, _size4
$CLEA _tmp_ptr1, _zero, _loop_1

; draw image
SUB _tmp1, _memend, _membase, _size4
LEA _tmp_ptr1, _tmp1
$OUT 1, _membase, _tmp_ptr1

; read one event
LEA read_key - 4, _key_input_ret_1
$LEA _zero, read_key
_key_input_ret_1:

; infite loop
$LEA _zero, _inf_loop

; return
LEA _tmp_ptr2, main - 4
LEA _tmp_ptr1, _size4
$MOV _zero, _tmp_ptr2, _tmp_ptr1

_dst:
.dd 0

_ldx:
.dd 500
_ldy:
.dd 1000
_ldz:
.dd -500

gx:
.dd 0
gy:
.dd 0
gz:
.dd 0

_px:
.dd 0
_py:
.dd 0
_pz:
.dd 0

_x:
.dd 0
_y:
.dd 0
_i:
.dd 0

_rx:
.dd 0
_ry:
.dd 0
_rz:
.dd 0

_xsize:
.dd 160
_ysize:
.dd 90

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

_balls_len:
.dd 3
_balls_size:
.dd 16
_balls:
; in format <RADIUS> <Z> <Y> <X>
.dd 1000, 5000, -400, -200
.dd 500, 6000, 600, 500
.dd 1500, 5000, -1600, 1500
_br:
.dd 0
_bz:
.dd 0
_by:
.dd 0
_bx:
.dd 0

_membase:
.dd 0x10000
_memend:
.dd 0

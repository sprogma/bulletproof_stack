; arguments
_normal:
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
_view:
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
_light:
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
phong:
; 1. normalize light vector
MUL sqrt - 12, _light + 8, _light + 8, _flt_size
DIV sqrt - 12, sqrt - 12, _flt_base, _flt_size
MUL _tmp1, _light + 4, _light + 4, _flt_size
DIV _tmp1, _tmp1, _flt_base, _flt_size
ADD sqrt - 12, sqrt - 12, _tmp1, _flt_size
MUL _tmp1, _light + 0, _light + 0, _flt_size
DIV _tmp1, _tmp1, _flt_base, _flt_size
ADD sqrt - 12, sqrt - 12, _tmp1, _flt_size
LEA sqrt - 4, _ret_1
$LEA _zero, sqrt
_ret_1:

; if zero - return from function
LEA _tmp_ptr1, _tmp1
LT _tmp1, sqrt - 8, _one, _flt_size
$CLEA _tmp_ptr1, _zero, _phong_ret

MUL _light + 8, _light + 8, _flt_base, _flt_size
MUL _light + 4, _light + 4, _flt_base, _flt_size
MUL _light + 0, _light + 0, _flt_base, _flt_size
DIV _light + 8, _light + 8, sqrt - 8, _flt_size
DIV _light + 4, _light + 4, sqrt - 8, _flt_size
DIV _light + 0, _light + 0, sqrt - 8, _flt_size
; 2. normalize normal vector
MUL sqrt - 12, _normal + 8, _normal + 8, _flt_size
DIV sqrt - 12, sqrt - 12, _flt_base, _flt_size
MUL _tmp1, _normal + 4, _normal + 4, _flt_size
DIV _tmp1, _tmp1, _flt_base, _flt_size
ADD sqrt - 12, sqrt - 12, _tmp1, _flt_size
MUL _tmp1, _normal + 0, _normal + 0, _flt_size
DIV _tmp1, _tmp1, _flt_base, _flt_size
ADD sqrt - 12, sqrt - 12, _tmp1, _flt_size
LEA sqrt - 4, _ret_2
$LEA _zero, sqrt
_ret_2:
MUL _normal + 8, _normal + 8, _flt_base, _flt_size
MUL _normal + 4, _normal + 4, _flt_base, _flt_size
MUL _normal + 0, _normal + 0, _flt_base, _flt_size
DIV _normal + 8, _normal + 8, sqrt - 8, _flt_size
DIV _normal + 4, _normal + 4, sqrt - 8, _flt_size
DIV _normal + 0, _normal + 0, sqrt - 8, _flt_size
; 3. normalize view vector
MUL sqrt - 12, _view + 8, _view + 8, _flt_size
DIV sqrt - 12, sqrt - 12, _flt_base, _flt_size
MUL _tmp1, _view + 4, _view + 4, _flt_size
DIV _tmp1, _tmp1, _flt_base, _flt_size
ADD sqrt - 12, sqrt - 12, _tmp1, _flt_size
MUL _tmp1, _view + 0, _view + 0, _flt_size
DIV _tmp1, _tmp1, _flt_base, _flt_size
ADD sqrt - 12, sqrt - 12, _tmp1, _flt_size
LEA sqrt - 4, _ret_3
$LEA _zero, sqrt
_ret_3:

; if zero - return from function
LEA _tmp_ptr1, _tmp1
LT _tmp1, sqrt - 8, _one, _flt_size
$CLEA _tmp_ptr1, _zero, _phong_ret

MUL _view + 8, _view + 8, _flt_base, _flt_size
MUL _view + 4, _view + 4, _flt_base, _flt_size
MUL _view + 0, _view + 0, _flt_base, _flt_size
DIV _view + 8, _view + 8, sqrt - 8, _flt_size
DIV _view + 4, _view + 4, sqrt - 8, _flt_size
DIV _view + 0, _view + 0, sqrt - 8, _flt_size
; set ambient light
MOV_CONST 200, phong - 8
; calculate diffuse : max(0, dot(normal, light) * 0.4)
MUL _tmp1, _normal + 8, _light + 8, _flt_size
DIV _tmp1, _tmp1, _flt_base, _flt_size
MUL _tmp2, _normal + 4, _light + 4, _flt_size
DIV _tmp2, _tmp2, _flt_base, _flt_size
ADD _tmp1, _tmp1, _tmp2, _flt_size
MUL _tmp2, _normal + 0, _light + 0, _flt_size
DIV _tmp2, _tmp2, _flt_base, _flt_size
ADD _tmp1, _tmp1, _tmp2, _flt_size
; clamp it from bottom by zero
LT _tmp2, _zero, _tmp1, _flt_size
LEA _tmp_ptr2, _tmp2
$CLEA _tmp_ptr2, _zero, _end_clamp
MOV_CONST 0, _tmp1
_end_clamp:
; scale
MOV_CONST 800, _tmp2
MUL _tmp1, _tmp1, _tmp2, _flt_size
DIV _tmp1, _tmp1, _flt_base, _flt_size
; add to resulting light
ADD phong - 8, phong - 8, _tmp1, _flt_size
; - add blink light
; TODO: add blink part, and change scale of diffuse light to 400

_phong_ret:
LEA _tmp_ptr2, phong - 4
LEA _tmp_ptr1, _size4
$MOV _zero, _tmp_ptr2, _tmp_ptr1



_size4:
.dd 4
_size1:
.dd 1
_zero:
.dd 0
_flt_size:
.dd 4
_flt_base:
.dd 1000
_one:
.dd 1
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

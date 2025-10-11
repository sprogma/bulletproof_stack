; using with math libray:
; having this functions:

; int sqrt(int)
; int fmul(int, int)
; int fdiv(int, int)


; [void=int] project(int, int, int, int, int, int, int, int, int) function:
; 
; xyz - position
; dxyz - ray
; xyz - point position

; arguments
_radius:
.dd 0xBEBEBEBE
_point:
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
_ray:
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
_pos:
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
_return:
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE

intersect_ball:
LEA _size4_ptr, _size4
; calculate projection
; 1. move ray to point coordinates
SUB _pos + 8, _pos + 8, _point + 8, _flt_size
SUB _pos + 4, _pos + 4, _point + 4, _flt_size
SUB _pos + 0, _pos + 0, _point + 0, _flt_size
; 2. calculate a
MUL _a, _ray + 8, _ray + 8, _flt_size
DIV _a, _a, _flt_base, _flt_size
MUL _tmp1, _ray + 4, _ray + 4, _flt_size
DIV _tmp1, _tmp1, _flt_base, _flt_size
ADD _a, _a, _tmp1, _flt_size
MUL _tmp1, _ray + 0, _ray + 0, _flt_size
DIV _tmp1, _tmp1, _flt_base, _flt_size
ADD _a, _a, _tmp1, _flt_size
; 3. calculate b/2
MUL _b, _pos + 8, _ray + 8, _flt_size
DIV _b, _b, _flt_base, _flt_size
MUL _tmp1, _pos + 4, _ray + 4, _flt_size
DIV _tmp1, _tmp1, _flt_base, _flt_size
ADD _b, _b, _tmp1, _flt_size
MUL _tmp1, _pos + 0, _ray + 0, _flt_size
DIV _tmp1, _tmp1, _flt_base, _flt_size
ADD _b, _b, _tmp1, _flt_size
; 4. calculate c
MUL _c, _pos + 8, _pos + 8, _flt_size
DIV _c, _c, _flt_base, _flt_size
MUL _tmp1, _pos + 4, _pos + 4, _flt_size
DIV _tmp1, _tmp1, _flt_base, _flt_size
ADD _c, _c, _tmp1, _flt_size
MUL _tmp1, _pos + 0, _pos + 0, _flt_size
DIV _tmp1, _tmp1, _flt_base, _flt_size
ADD _c, _c, _tmp1, _flt_size
MUL _tmp1, _radius, _radius, _flt_size
DIV _tmp1, _tmp1, _flt_base, _flt_size
SUB _c, _c, _tmp1, _flt_size
; 5. calculate D/4
MUL _d, _b, _b, _flt_size
DIV _d, _d, _flt_base, _flt_size
MUL _tmp1, _a, _c, _flt_size
DIV _tmp1, _tmp1, _flt_base, _flt_size
SUB _d, _d, _tmp1, _flt_size
; 5.5 if D/4 < 0, return -1
LT _tmp1, _d, _flt_zero, _flt_size
LEA _ptr_tmp1, _tmp1
$CLEA _ptr_tmp1, _zero, _ret_no
; 6. use sqrt
MOV sqrt - 12, _d, _flt_size
LEA sqrt - 4, _sqrt_ret_1
$LEA _zero, sqrt
_sqrt_ret_1:
MOV _d, sqrt - 8, _flt_size
; 7. calculate first root
NEG _rt1, _b, _flt_size
SUB _rt1, _rt1, _d, _flt_size
MUL _rt1, _rt1, _flt_base, _flt_size
DIV _rt1, _rt1, _a, _flt_size
; 8. calculate second root
NEG _rt2, _b, _flt_size
ADD _rt2, _rt2, _d, _flt_size
MUL _rt2, _rt2, _flt_base, _flt_size
DIV _rt2, _rt2, _a, _flt_size
; ---- print [woking]
; OUT 1, _rt1, _flt_size
; OUT 1, _rt2, _flt_size
; 9. return minimum one from positive solutions, or -1 owerwise
;    using fact, that _rt1 < _rt2
; _rt2 < 0
LT _tmp1, _rt2, _flt_zero, _flt_size
LEA _ptr_tmp1, _tmp1
$CLEA _ptr_tmp1, _zero, _ret_no

; _rt1 < 0
LT _tmp1, _rt1, _flt_zero, _flt_size
LEA _ptr_tmp1, _tmp1
$CLEA _ptr_tmp1, _zero, _ret_second

; return _rt1 - both roots is positive
MOV _return, _rt1, _flt_size
LEA _ptr_tmp1, intersect_ball - 4
$MOV _zero, _ptr_tmp1, _size4_ptr

; return _rt2 - only first root is negative
_ret_second:
MOV _return, _rt2, _flt_size
LEA _ptr_tmp1, intersect_ball - 4
$MOV _zero, _ptr_tmp1, _size4_ptr

; return -1 - both roots is negative
_ret_no:
MOV_CONST -1000, _return
LEA _ptr_tmp1, intersect_ball - 4
$MOV _zero, _ptr_tmp1, _size4_ptr



_zero:
.dd 0

_size4:
.dd 4
_ptr_tmp1:
.dd 0
_ptr_tmp2:
.dd 0
_ptr_tmp3:
.dd 0
_size4_ptr:
.dd 0

_flt_base:
.dd 1000
_flt_size:
.dd 4
_flt_zero:
.dd 0
_const_2:
.dd 2
_tmp1:
.dd 0
_tmp2:
.dd 0
_tmp3:
.dd 0
_a:
.dd 0
_b:
.dd 0
_c:
.dd 0
_d:
.dd 0
_rt1:
.dd 0
_rt2:
.dd 0


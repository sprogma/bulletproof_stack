
LEA main - 4, end_proc
$LEA __ld_zero, main
end_proc:
; like HLT instruction
.db 0xFF
__ld_zero:
.dd 0
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
_0curvedY__radius:
.dd 0xBEBEBEBE
_0curvedY__point:
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
_0curvedY__ray:
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
_0curvedY__pos:
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
_0curvedY__return:
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE

intersect_ball:
LEA _0curvedY__size4_ptr, _0curvedY__size4
; calculate projection
; 1. move ray to point coordinates
SUB _0curvedY__pos + 8, _0curvedY__pos + 8, _0curvedY__point + 8, _0curvedY__flt_size
SUB _0curvedY__pos + 4, _0curvedY__pos + 4, _0curvedY__point + 4, _0curvedY__flt_size
SUB _0curvedY__pos + 0, _0curvedY__pos + 0, _0curvedY__point + 0, _0curvedY__flt_size
; 2. calculate a
MUL _0curvedY__a, _0curvedY__ray + 8, _0curvedY__ray + 8, _0curvedY__flt_size
DIV _0curvedY__a, _0curvedY__a, _0curvedY__flt_base, _0curvedY__flt_size
MUL _0curvedY__tmp1, _0curvedY__ray + 4, _0curvedY__ray + 4, _0curvedY__flt_size
DIV _0curvedY__tmp1, _0curvedY__tmp1, _0curvedY__flt_base, _0curvedY__flt_size
ADD _0curvedY__a, _0curvedY__a, _0curvedY__tmp1, _0curvedY__flt_size
MUL _0curvedY__tmp1, _0curvedY__ray + 0, _0curvedY__ray + 0, _0curvedY__flt_size
DIV _0curvedY__tmp1, _0curvedY__tmp1, _0curvedY__flt_base, _0curvedY__flt_size
ADD _0curvedY__a, _0curvedY__a, _0curvedY__tmp1, _0curvedY__flt_size
; 3. calculate b/2
MUL _0curvedY__b, _0curvedY__pos + 8, _0curvedY__ray + 8, _0curvedY__flt_size
DIV _0curvedY__b, _0curvedY__b, _0curvedY__flt_base, _0curvedY__flt_size
MUL _0curvedY__tmp1, _0curvedY__pos + 4, _0curvedY__ray + 4, _0curvedY__flt_size
DIV _0curvedY__tmp1, _0curvedY__tmp1, _0curvedY__flt_base, _0curvedY__flt_size
ADD _0curvedY__b, _0curvedY__b, _0curvedY__tmp1, _0curvedY__flt_size
MUL _0curvedY__tmp1, _0curvedY__pos + 0, _0curvedY__ray + 0, _0curvedY__flt_size
DIV _0curvedY__tmp1, _0curvedY__tmp1, _0curvedY__flt_base, _0curvedY__flt_size
ADD _0curvedY__b, _0curvedY__b, _0curvedY__tmp1, _0curvedY__flt_size
; 4. calculate c
MUL _0curvedY__c, _0curvedY__pos + 8, _0curvedY__pos + 8, _0curvedY__flt_size
DIV _0curvedY__c, _0curvedY__c, _0curvedY__flt_base, _0curvedY__flt_size
MUL _0curvedY__tmp1, _0curvedY__pos + 4, _0curvedY__pos + 4, _0curvedY__flt_size
DIV _0curvedY__tmp1, _0curvedY__tmp1, _0curvedY__flt_base, _0curvedY__flt_size
ADD _0curvedY__c, _0curvedY__c, _0curvedY__tmp1, _0curvedY__flt_size
MUL _0curvedY__tmp1, _0curvedY__pos + 0, _0curvedY__pos + 0, _0curvedY__flt_size
DIV _0curvedY__tmp1, _0curvedY__tmp1, _0curvedY__flt_base, _0curvedY__flt_size
ADD _0curvedY__c, _0curvedY__c, _0curvedY__tmp1, _0curvedY__flt_size
MUL _0curvedY__tmp1, _0curvedY__radius, _0curvedY__radius, _0curvedY__flt_size
DIV _0curvedY__tmp1, _0curvedY__tmp1, _0curvedY__flt_base, _0curvedY__flt_size
SUB _0curvedY__c, _0curvedY__c, _0curvedY__tmp1, _0curvedY__flt_size
; 5. calculate D/4
MUL _0curvedY__d, _0curvedY__b, _0curvedY__b, _0curvedY__flt_size
DIV _0curvedY__d, _0curvedY__d, _0curvedY__flt_base, _0curvedY__flt_size
MUL _0curvedY__tmp1, _0curvedY__a, _0curvedY__c, _0curvedY__flt_size
DIV _0curvedY__tmp1, _0curvedY__tmp1, _0curvedY__flt_base, _0curvedY__flt_size
SUB _0curvedY__d, _0curvedY__d, _0curvedY__tmp1, _0curvedY__flt_size
; 5.5 if D/4 < 0, return -1
LT _0curvedY__tmp1, _0curvedY__d, _0curvedY__flt_zero, _0curvedY__flt_size
LEA _0curvedY__ptr_tmp1, _0curvedY__tmp1
$CLEA _0curvedY__ptr_tmp1, _0curvedY__zero, _0curvedY__ret_no
; 6. use sqrt
MOV sqrt - 12, _0curvedY__d, _0curvedY__flt_size
LEA sqrt - 4, _0curvedY__sqrt_ret_1
$LEA _0curvedY__zero, sqrt
_0curvedY__sqrt_ret_1:
MOV _0curvedY__d, sqrt - 8, _0curvedY__flt_size
; 7. calculate first root
NEG _0curvedY__rt1, _0curvedY__b, _0curvedY__flt_size
SUB _0curvedY__rt1, _0curvedY__rt1, _0curvedY__d, _0curvedY__flt_size
MUL _0curvedY__rt1, _0curvedY__rt1, _0curvedY__flt_base, _0curvedY__flt_size
DIV _0curvedY__rt1, _0curvedY__rt1, _0curvedY__a, _0curvedY__flt_size
; 8. calculate second root
NEG _0curvedY__rt2, _0curvedY__b, _0curvedY__flt_size
ADD _0curvedY__rt2, _0curvedY__rt2, _0curvedY__d, _0curvedY__flt_size
MUL _0curvedY__rt2, _0curvedY__rt2, _0curvedY__flt_base, _0curvedY__flt_size
DIV _0curvedY__rt2, _0curvedY__rt2, _0curvedY__a, _0curvedY__flt_size
; ---- print [woking]
; OUT 1, _0curvedY__rt1, _0curvedY__flt_size
; OUT 1, _0curvedY__rt2, _0curvedY__flt_size
; 9. return minimum one from positive solutions, or -1 owerwise
;    using fact, that _0curvedY__rt1 < _0curvedY__rt2
; _0curvedY__rt2 < 0
LT _0curvedY__tmp1, _0curvedY__rt2, _0curvedY__flt_zero, _0curvedY__flt_size
LEA _0curvedY__ptr_tmp1, _0curvedY__tmp1
$CLEA _0curvedY__ptr_tmp1, _0curvedY__zero, _0curvedY__ret_no

; _0curvedY__rt1 < 0
LT _0curvedY__tmp1, _0curvedY__rt1, _0curvedY__flt_zero, _0curvedY__flt_size
LEA _0curvedY__ptr_tmp1, _0curvedY__tmp1
$CLEA _0curvedY__ptr_tmp1, _0curvedY__zero, _0curvedY__ret_second

; return _0curvedY__rt1 - both roots is positive
MOV _0curvedY__return, _0curvedY__rt1, _0curvedY__flt_size
LEA _0curvedY__ptr_tmp1, intersect_ball - 4
$MOV _0curvedY__zero, _0curvedY__ptr_tmp1, _0curvedY__size4_ptr

; return _0curvedY__rt2 - only first root is negative
_0curvedY__ret_second:
MOV _0curvedY__return, _0curvedY__rt2, _0curvedY__flt_size
LEA _0curvedY__ptr_tmp1, intersect_ball - 4
$MOV _0curvedY__zero, _0curvedY__ptr_tmp1, _0curvedY__size4_ptr

; return -1 - both roots is negative
_0curvedY__ret_no:
MOV_CONST -1000, _0curvedY__return
LEA _0curvedY__ptr_tmp1, intersect_ball - 4
$MOV _0curvedY__zero, _0curvedY__ptr_tmp1, _0curvedY__size4_ptr



_0curvedY__zero:
.dd 0

_0curvedY__size4:
.dd 4
_0curvedY__ptr_tmp1:
.dd 0
_0curvedY__ptr_tmp2:
.dd 0
_0curvedY__ptr_tmp3:
.dd 0
_0curvedY__size4_ptr:
.dd 0

_0curvedY__flt_base:
.dd 1000
_0curvedY__flt_size:
.dd 4
_0curvedY__flt_zero:
.dd 0
_0curvedY__const_2:
.dd 2
_0curvedY__tmp1:
.dd 0
_0curvedY__tmp2:
.dd 0
_0curvedY__tmp3:
.dd 0
_0curvedY__a:
.dd 0
_0curvedY__b:
.dd 0
_0curvedY__c:
.dd 0
_0curvedY__d:
.dd 0
_0curvedY__rt1:
.dd 0
_0curvedY__rt2:
.dd 0


; arguments
_1phong__normal:
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
_1phong__view:
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
_1phong__light:
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
phong:
; 1. normalize light vector
MUL sqrt - 12, _1phong__light + 8, _1phong__light + 8, _1phong__flt_size
DIV sqrt - 12, sqrt - 12, _1phong__flt_base, _1phong__flt_size
MUL _1phong__tmp1, _1phong__light + 4, _1phong__light + 4, _1phong__flt_size
DIV _1phong__tmp1, _1phong__tmp1, _1phong__flt_base, _1phong__flt_size
ADD sqrt - 12, sqrt - 12, _1phong__tmp1, _1phong__flt_size
MUL _1phong__tmp1, _1phong__light + 0, _1phong__light + 0, _1phong__flt_size
DIV _1phong__tmp1, _1phong__tmp1, _1phong__flt_base, _1phong__flt_size
ADD sqrt - 12, sqrt - 12, _1phong__tmp1, _1phong__flt_size
LEA sqrt - 4, _1phong__ret_1
$LEA _1phong__zero, sqrt
_1phong__ret_1:

; if zero - return from function
LEA _1phong__tmp_ptr1, _1phong__tmp1
LT _1phong__tmp1, sqrt - 8, _1phong__one, _1phong__flt_size
$CLEA _1phong__tmp_ptr1, _1phong__zero, _1phong__phong_ret

MUL _1phong__light + 8, _1phong__light + 8, _1phong__flt_base, _1phong__flt_size
MUL _1phong__light + 4, _1phong__light + 4, _1phong__flt_base, _1phong__flt_size
MUL _1phong__light + 0, _1phong__light + 0, _1phong__flt_base, _1phong__flt_size
DIV _1phong__light + 8, _1phong__light + 8, sqrt - 8, _1phong__flt_size
DIV _1phong__light + 4, _1phong__light + 4, sqrt - 8, _1phong__flt_size
DIV _1phong__light + 0, _1phong__light + 0, sqrt - 8, _1phong__flt_size
; 2. normalize normal vector
MUL sqrt - 12, _1phong__normal + 8, _1phong__normal + 8, _1phong__flt_size
DIV sqrt - 12, sqrt - 12, _1phong__flt_base, _1phong__flt_size
MUL _1phong__tmp1, _1phong__normal + 4, _1phong__normal + 4, _1phong__flt_size
DIV _1phong__tmp1, _1phong__tmp1, _1phong__flt_base, _1phong__flt_size
ADD sqrt - 12, sqrt - 12, _1phong__tmp1, _1phong__flt_size
MUL _1phong__tmp1, _1phong__normal + 0, _1phong__normal + 0, _1phong__flt_size
DIV _1phong__tmp1, _1phong__tmp1, _1phong__flt_base, _1phong__flt_size
ADD sqrt - 12, sqrt - 12, _1phong__tmp1, _1phong__flt_size
LEA sqrt - 4, _1phong__ret_2
$LEA _1phong__zero, sqrt
_1phong__ret_2:
MUL _1phong__normal + 8, _1phong__normal + 8, _1phong__flt_base, _1phong__flt_size
MUL _1phong__normal + 4, _1phong__normal + 4, _1phong__flt_base, _1phong__flt_size
MUL _1phong__normal + 0, _1phong__normal + 0, _1phong__flt_base, _1phong__flt_size
DIV _1phong__normal + 8, _1phong__normal + 8, sqrt - 8, _1phong__flt_size
DIV _1phong__normal + 4, _1phong__normal + 4, sqrt - 8, _1phong__flt_size
DIV _1phong__normal + 0, _1phong__normal + 0, sqrt - 8, _1phong__flt_size
; 3. normalize view vector
MUL sqrt - 12, _1phong__view + 8, _1phong__view + 8, _1phong__flt_size
DIV sqrt - 12, sqrt - 12, _1phong__flt_base, _1phong__flt_size
MUL _1phong__tmp1, _1phong__view + 4, _1phong__view + 4, _1phong__flt_size
DIV _1phong__tmp1, _1phong__tmp1, _1phong__flt_base, _1phong__flt_size
ADD sqrt - 12, sqrt - 12, _1phong__tmp1, _1phong__flt_size
MUL _1phong__tmp1, _1phong__view + 0, _1phong__view + 0, _1phong__flt_size
DIV _1phong__tmp1, _1phong__tmp1, _1phong__flt_base, _1phong__flt_size
ADD sqrt - 12, sqrt - 12, _1phong__tmp1, _1phong__flt_size
LEA sqrt - 4, _1phong__ret_3
$LEA _1phong__zero, sqrt
_1phong__ret_3:

; if zero - return from function
LEA _1phong__tmp_ptr1, _1phong__tmp1
LT _1phong__tmp1, sqrt - 8, _1phong__one, _1phong__flt_size
$CLEA _1phong__tmp_ptr1, _1phong__zero, _1phong__phong_ret

MUL _1phong__view + 8, _1phong__view + 8, _1phong__flt_base, _1phong__flt_size
MUL _1phong__view + 4, _1phong__view + 4, _1phong__flt_base, _1phong__flt_size
MUL _1phong__view + 0, _1phong__view + 0, _1phong__flt_base, _1phong__flt_size
DIV _1phong__view + 8, _1phong__view + 8, sqrt - 8, _1phong__flt_size
DIV _1phong__view + 4, _1phong__view + 4, sqrt - 8, _1phong__flt_size
DIV _1phong__view + 0, _1phong__view + 0, sqrt - 8, _1phong__flt_size
; set ambient light
MOV_CONST 200, phong - 8
; calculate diffuse : max(0, dot(normal, light) * 0.4)
MUL _1phong__tmp1, _1phong__normal + 8, _1phong__light + 8, _1phong__flt_size
DIV _1phong__tmp1, _1phong__tmp1, _1phong__flt_base, _1phong__flt_size
MUL _1phong__tmp2, _1phong__normal + 4, _1phong__light + 4, _1phong__flt_size
DIV _1phong__tmp2, _1phong__tmp2, _1phong__flt_base, _1phong__flt_size
ADD _1phong__tmp1, _1phong__tmp1, _1phong__tmp2, _1phong__flt_size
MUL _1phong__tmp2, _1phong__normal + 0, _1phong__light + 0, _1phong__flt_size
DIV _1phong__tmp2, _1phong__tmp2, _1phong__flt_base, _1phong__flt_size
ADD _1phong__tmp1, _1phong__tmp1, _1phong__tmp2, _1phong__flt_size
; clamp it from bottom by zero
LT _1phong__tmp2, _1phong__zero, _1phong__tmp1, _1phong__flt_size
LEA _1phong__tmp_ptr2, _1phong__tmp2
$CLEA _1phong__tmp_ptr2, _1phong__zero, _1phong__end_clamp
MOV_CONST 0, _1phong__tmp1
_1phong__end_clamp:
; scale
MOV_CONST 800, _1phong__tmp2
MUL _1phong__tmp1, _1phong__tmp1, _1phong__tmp2, _1phong__flt_size
DIV _1phong__tmp1, _1phong__tmp1, _1phong__flt_base, _1phong__flt_size
; add to resulting light
ADD phong - 8, phong - 8, _1phong__tmp1, _1phong__flt_size
; - add blink light
; TODO: add blink part, and change scale of diffuse light to 400

_1phong__phong_ret:
LEA _1phong__tmp_ptr2, phong - 4
LEA _1phong__tmp_ptr1, _1phong__size4
$MOV _1phong__zero, _1phong__tmp_ptr2, _1phong__tmp_ptr1



_1phong__size4:
.dd 4
_1phong__size1:
.dd 1
_1phong__zero:
.dd 0
_1phong__flt_size:
.dd 4
_1phong__flt_base:
.dd 1000
_1phong__one:
.dd 1
_1phong__tmp1:
.dd 0
_1phong__tmp2:
.dd 0
_1phong__tmp3:
.dd 0
_1phong__tmp4:
.dd 0
_1phong__tmp_ptr1:
.dd 0
_1phong__tmp_ptr2:
.dd 0
_1phong__tmp_ptr3:
.dd 0
_1phong__tmp_ptr4:
.dd 0

; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
fmul:
MOV fmul - 8, fmul - 12, _2math__size4
MOV _2math__local1, fmul - 16, _2math__size4
MUL fmul - 8, fmul - 8, _2math__local1, _2math__size4
MOV_CONST 1000, _2math__local0
DIV fmul - 8, fmul - 8, _2math__local0, _2math__size4
LEA _2math__local2, _2math__size4
LEA _2math__local3, fmul - 4
$MOV _2math__zero, _2math__local3, _2math__local2
; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
fdiv:
MOV fdiv - 8, fdiv - 12, _2math__size4
MOV_CONST 1000, _2math__local5
MUL fdiv - 8, fdiv - 8, _2math__local5, _2math__size4
MOV _2math__local4, fdiv - 16, _2math__size4
DIV fdiv - 8, fdiv - 8, _2math__local4, _2math__size4
LEA _2math__local6, _2math__size4
LEA _2math__local7, fdiv - 4
$MOV _2math__zero, _2math__local7, _2math__local6
; arguments
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
sqrt:
MOV _2math__local8, sqrt - 12, _2math__size4
MOV_CONST 1000, _2math__local9
MUL _2math__local8, _2math__local8, _2math__local9, _2math__size4
MOV _2math__sqrt_aa, _2math__local8, _2math__size4
MOV_CONST 0, _2math__local10
MOV _2math__sqrt_res, _2math__local10, _2math__size4
MOV_CONST 46340, _2math__local11
MOV _2math__sqrt_add, _2math__local11, _2math__size4
LEA _2math__local16, _2math__local15
_2math__local14:
MOV _2math__local15, _2math__sqrt_add, _2math__size4
MOV_CONST 0, _2math__local17
LT _2math__local15, _2math__local17, _2math__local15, _2math__size4
$CLEA _2math__local16, _2math__zero, _2math__local13 
$LEA _2math__zero, _2math__local12
_2math__local13:
MOV _2math__local20, _2math__sqrt_res, _2math__size4
MOV _2math__local24, _2math__sqrt_add, _2math__size4
ADD _2math__local20, _2math__local20, _2math__local24, _2math__size4
MOV _2math__local23, _2math__sqrt_res, _2math__size4
MOV _2math__local25, _2math__sqrt_add, _2math__size4
ADD _2math__local23, _2math__local23, _2math__local25, _2math__size4
MUL _2math__local20, _2math__local20, _2math__local23, _2math__size4
MOV _2math__local22, _2math__sqrt_aa, _2math__size4
LT _2math__local20, _2math__local20, _2math__local22, _2math__size4
LEA _2math__local21, _2math__local20
$CLEA _2math__local21, _2math__zero, _2math__local18 
$LEA _2math__zero, _2math__local19 
_2math__local18:
MOV _2math__local26, _2math__sqrt_res, _2math__size4
MOV _2math__local27, _2math__sqrt_add, _2math__size4
ADD _2math__local26, _2math__local26, _2math__local27, _2math__size4
MOV _2math__sqrt_res, _2math__local26, _2math__size4
_2math__local19:
MOV _2math__local28, _2math__sqrt_add, _2math__size4
MOV_CONST 2, _2math__local29
DIV _2math__local28, _2math__local28, _2math__local29, _2math__size4
MOV _2math__sqrt_add, _2math__local28, _2math__size4
$LEA _2math__zero, _2math__local14 
_2math__local12:
MOV sqrt - 8, _2math__sqrt_res, _2math__size4
LEA _2math__local30, _2math__size4
LEA _2math__local31, sqrt - 4
$MOV _2math__zero, _2math__local31, _2math__local30
; arguments
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
f:
MOV f - 8, f - 12, _2math__size4
MOV_CONST 1000, _2math__local32
MUL f - 8, f - 8, _2math__local32, _2math__size4
LEA _2math__local33, _2math__size4
LEA _2math__local34, f - 4
$MOV _2math__zero, _2math__local34, _2math__local33
_2math__local0:
.dd 0
_2math__local1:
.dd 0
_2math__local2:
.dd 0
_2math__local3:
.dd 0
_2math__local4:
.dd 0
_2math__local5:
.dd 0
_2math__local6:
.dd 0
_2math__local7:
.dd 0
_2math__sqrt_aa:
.dd 0
_2math__sqrt_res:
.dd 0
_2math__sqrt_add:
.dd 0
_2math__local8:
.dd 0
_2math__local9:
.dd 0
_2math__local10:
.dd 0
_2math__local11:
.dd 0
_2math__local15:
.dd 0
_2math__local16:
.dd 0
_2math__local17:
.dd 0
_2math__local20:
.dd 0
_2math__local21:
.dd 0
_2math__local22:
.dd 0
_2math__local23:
.dd 0
_2math__local24:
.dd 0
_2math__local25:
.dd 0
_2math__local26:
.dd 0
_2math__local27:
.dd 0
_2math__local28:
.dd 0
_2math__local29:
.dd 0
_2math__local30:
.dd 0
_2math__local31:
.dd 0
_2math__local32:
.dd 0
_2math__local33:
.dd 0
_2math__local34:
.dd 0
_2math__size4:
.dd 4
_2math__size1:
.dd 1
_2math__zero:
.dd 0

.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
main:

_3balls__inf_loop:
MOV _3balls__memend, _3balls__membase, _3balls__size4
MOV_CONST 0, _3balls__y
_3balls__loop_1:

MOV_CONST 0, _3balls__x
_3balls__loop_2:

; background
$MOV_CONST 0, _3balls__memend

; create ray
MOV_CONST 80, _3balls__tmp1
SUB _3balls__rx, _3balls__x, _3balls__tmp1, _3balls__flt_size
MOV_CONST 45, _3balls__tmp1
SUB _3balls__ry, _3balls__tmp1, _3balls__y, _3balls__flt_size
MOV_CONST 8, _3balls__tmp1
MUL _3balls__rx, _3balls__rx, _3balls__tmp1, _3balls__flt_size
MUL _3balls__ry, _3balls__ry, _3balls__tmp1, _3balls__flt_size
MOV_CONST 1000, _3balls__rz

; remember nearest distance: =+inf
MOV_CONST 1000000, _3balls__dst

; cast it with balls
MOV_CONST 0, _3balls__i
_3balls__loop_3:

; global coodinates
MOV intersect_ball - 12, _3balls__gx, _3balls__flt_size
MOV intersect_ball - 16, _3balls__gy, _3balls__flt_size
MOV intersect_ball - 20, _3balls__gz, _3balls__flt_size
; ray coordinates
MOV intersect_ball - 24, _3balls__rx, _3balls__flt_size
MOV intersect_ball - 28, _3balls__ry, _3balls__flt_size
MOV intersect_ball - 32, _3balls__rz, _3balls__flt_size
; ball position: tmp1 = address of current ball
LEA _3balls__tmp1, _3balls__balls
MUL _3balls__tmp2, _3balls__i, _3balls__balls_size, _3balls__size4
ADD _3balls__tmp1, _3balls__tmp1, _3balls__tmp2, _3balls__size4

; load current ball to bx by bz br
LEA _3balls__tmp_ptr1, _3balls__br
LEA _3balls__tmp_ptr2, _3balls__balls_size
$MOV _3balls__tmp_ptr1, _3balls__tmp1, _3balls__tmp_ptr2

; load current ball to intersect function
LEA _3balls__tmp_ptr1, intersect_ball - 48
LEA _3balls__tmp_ptr2, _3balls__balls_size
$MOV _3balls__tmp_ptr1, _3balls__tmp1, _3balls__tmp_ptr2

LEA intersect_ball - 4, _3balls__intercect_ret_1
$LEA _3balls__zero, intersect_ball
_3balls__intercect_ret_1:

; if result < 0, when this isn't ball
LT _3balls__tmp1, intersect_ball - 8, _3balls__zero, _3balls__flt_size
LEA _3balls__tmp_ptr1, _3balls__tmp1
$CLEA _3balls__tmp_ptr1, _3balls__zero, _3balls__no_intercestion

; if _3balls__dst < result, when we don't see this ball
LT _3balls__tmp1, _3balls__dst, intersect_ball - 8, _3balls__flt_size
LEA _3balls__tmp_ptr1, _3balls__tmp1
$CLEA _3balls__tmp_ptr1, _3balls__zero, _3balls__no_intercestion

; remember new _3balls__dst
MOV _3balls__dst, intersect_ball - 8, _3balls__flt_size

; calculate point of intersection
MUL _3balls__px, _3balls__rx, intersect_ball - 8, _3balls__flt_size
DIV _3balls__px, _3balls__px, _3balls__flt_base, _3balls__flt_size
ADD _3balls__px, _3balls__px, _3balls__gx, _3balls__flt_size
MUL _3balls__py, _3balls__ry, intersect_ball - 8, _3balls__flt_size
DIV _3balls__py, _3balls__py, _3balls__flt_base, _3balls__flt_size
ADD _3balls__py, _3balls__py, _3balls__gy, _3balls__flt_size
MUL _3balls__pz, _3balls__rz, intersect_ball - 8, _3balls__flt_size
DIV _3balls__pz, _3balls__pz, _3balls__flt_base, _3balls__flt_size
ADD _3balls__pz, _3balls__pz, _3balls__gz, _3balls__flt_size
; calculate color using phong model
MOV phong - 12, _3balls__ldx, _3balls__flt_size
MOV phong - 16, _3balls__ldy, _3balls__flt_size
MOV phong - 20, _3balls__ldz, _3balls__flt_size
SUB phong - 24, _3balls__px, _3balls__gx, _3balls__flt_size
SUB phong - 28, _3balls__py, _3balls__gy, _3balls__flt_size
SUB phong - 32, _3balls__pz, _3balls__gz, _3balls__flt_size
SUB phong - 36, _3balls__px, _3balls__bx, _3balls__flt_size
SUB phong - 40, _3balls__py, _3balls__by, _3balls__flt_size
SUB phong - 44, _3balls__pz, _3balls__bz, _3balls__flt_size
LEA phong - 4, _3balls__phong_ret_1
$LEA _3balls__zero, phong
_3balls__phong_ret_1:

; convert result to color
MOV_CONST 255, _3balls__tmp2
MUL _3balls__tmp1, phong - 8, _3balls__tmp2, _3balls__flt_size
DIV _3balls__tmp1, _3balls__tmp1, _3balls__flt_base, _3balls__flt_size

MOV_CONST 256, _3balls__tmp2
MUL _3balls__tmp1, _3balls__tmp1, _3balls__tmp2, _3balls__size4

LEA _3balls__tmp_ptr1, _3balls__tmp1
LEA _3balls__tmp_ptr2, _3balls__flt_size
$MOV _3balls__memend, _3balls__tmp_ptr1, _3balls__tmp_ptr2

_3balls__no_intercestion:

; _3balls__loop_3
INC _3balls__i, _3balls__i, _3balls__size4
LEA _3balls__tmp_ptr1, _3balls__tmp1
LT _3balls__tmp1, _3balls__i, _3balls__balls_len, _3balls__size4
$CLEA _3balls__tmp_ptr1, _3balls__zero, _3balls__loop_3

; move memory pointer
ADD _3balls__memend, _3balls__memend, _3balls__four, _3balls__size4


; _3balls__loop_1
INC _3balls__x, _3balls__x, _3balls__size4
LEA _3balls__tmp_ptr1, _3balls__tmp1
LT _3balls__tmp1, _3balls__x, _3balls__xsize, _3balls__size4
$CLEA _3balls__tmp_ptr1, _3balls__zero, _3balls__loop_2

; _3balls__loop_2
INC _3balls__y, _3balls__y, _3balls__size4
LEA _3balls__tmp_ptr1, _3balls__tmp1
LT _3balls__tmp1, _3balls__y, _3balls__ysize, _3balls__size4
$CLEA _3balls__tmp_ptr1, _3balls__zero, _3balls__loop_1

; draw image
SUB _3balls__tmp1, _3balls__memend, _3balls__membase, _3balls__size4
LEA _3balls__tmp_ptr1, _3balls__tmp1
$OUT 1, _3balls__membase, _3balls__tmp_ptr1

; infite loop
$LEA _3balls__zero, _3balls__inf_loop

; return
LEA _3balls__tmp_ptr2, main - 4
LEA _3balls__tmp_ptr1, _3balls__size4
$MOV _3balls__zero, _3balls__tmp_ptr2, _3balls__tmp_ptr1

_3balls__dst:
.dd 0

_3balls__ldx:
.dd 500
_3balls__ldy:
.dd 1000
_3balls__ldz:
.dd -500

_3balls__gx:
.dd 0
_3balls__gy:
.dd 0
_3balls__gz:
.dd 0

_3balls__px:
.dd 0
_3balls__py:
.dd 0
_3balls__pz:
.dd 0

_3balls__x:
.dd 0
_3balls__y:
.dd 0
_3balls__i:
.dd 0

_3balls__rx:
.dd 0
_3balls__ry:
.dd 0
_3balls__rz:
.dd 0

_3balls__xsize:
.dd 160
_3balls__ysize:
.dd 90

_3balls__tmp1:
.dd 0
_3balls__tmp2:
.dd 0
_3balls__tmp3:
.dd 0
_3balls__tmp4:
.dd 0
_3balls__tmp_ptr1:
.dd 0
_3balls__tmp_ptr2:
.dd 0
_3balls__tmp_ptr3:
.dd 0
_3balls__tmp_ptr4:
.dd 0

_3balls__one:
.dd 1
_3balls__four:
.dd 4

_3balls__zero:
.dd 0
_3balls__flt_size:
.dd 4
_3balls__flt_base:
.dd 1000
_3balls__size4:
.dd 4

_3balls__balls_len:
.dd 3
_3balls__balls_size:
.dd 16
_3balls__balls:
; in format <RADIUS> <Z> <Y> <X>
.dd 1000, 5000, -400, -200
.dd 500, 6000, 600, 500
.dd 1500, 5000, -1600, 1500
_3balls__br:
.dd 0
_3balls__bz:
.dd 0
_3balls__by:
.dd 0
_3balls__bx:
.dd 0

_3balls__membase:
.dd 0x10000
_3balls__memend:
.dd 0


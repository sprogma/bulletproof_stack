
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
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
fmul:
MOV fmul - 8, fmul - 12, _1math__size4
MOV _1math__local1, fmul - 16, _1math__size4
MUL fmul - 8, fmul - 8, _1math__local1, _1math__size4
MOV_CONST 1000, _1math__local0
DIV fmul - 8, fmul - 8, _1math__local0, _1math__size4
LEA _1math__local2, _1math__size4
LEA _1math__local3, fmul - 4
$MOV _1math__zero, _1math__local3, _1math__local2
; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
fdiv:
MOV fdiv - 8, fdiv - 12, _1math__size4
MOV_CONST 1000, _1math__local5
MUL fdiv - 8, fdiv - 8, _1math__local5, _1math__size4
MOV _1math__local4, fdiv - 16, _1math__size4
DIV fdiv - 8, fdiv - 8, _1math__local4, _1math__size4
LEA _1math__local6, _1math__size4
LEA _1math__local7, fdiv - 4
$MOV _1math__zero, _1math__local7, _1math__local6
; arguments
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
sqrt:
MOV _1math__local8, sqrt - 12, _1math__size4
MOV_CONST 1000, _1math__local9
MUL _1math__local8, _1math__local8, _1math__local9, _1math__size4
MOV _1math__sqrt_aa, _1math__local8, _1math__size4
MOV_CONST 0, _1math__local10
MOV _1math__sqrt_res, _1math__local10, _1math__size4
MOV_CONST 46340, _1math__local11
MOV _1math__sqrt_add, _1math__local11, _1math__size4
LEA _1math__local16, _1math__local15
_1math__local14:
MOV _1math__local15, _1math__sqrt_add, _1math__size4
MOV_CONST 0, _1math__local17
LT _1math__local15, _1math__local17, _1math__local15, _1math__size4
$CLEA _1math__local16, _1math__zero, _1math__local13 
$LEA _1math__zero, _1math__local12
_1math__local13:
MOV _1math__local20, _1math__sqrt_res, _1math__size4
MOV _1math__local24, _1math__sqrt_add, _1math__size4
ADD _1math__local20, _1math__local20, _1math__local24, _1math__size4
MOV _1math__local23, _1math__sqrt_res, _1math__size4
MOV _1math__local25, _1math__sqrt_add, _1math__size4
ADD _1math__local23, _1math__local23, _1math__local25, _1math__size4
MUL _1math__local20, _1math__local20, _1math__local23, _1math__size4
MOV _1math__local22, _1math__sqrt_aa, _1math__size4
LT _1math__local20, _1math__local20, _1math__local22, _1math__size4
LEA _1math__local21, _1math__local20
$CLEA _1math__local21, _1math__zero, _1math__local18 
$LEA _1math__zero, _1math__local19 
_1math__local18:
MOV _1math__local26, _1math__sqrt_res, _1math__size4
MOV _1math__local27, _1math__sqrt_add, _1math__size4
ADD _1math__local26, _1math__local26, _1math__local27, _1math__size4
MOV _1math__sqrt_res, _1math__local26, _1math__size4
_1math__local19:
MOV _1math__local28, _1math__sqrt_add, _1math__size4
MOV_CONST 2, _1math__local29
DIV _1math__local28, _1math__local28, _1math__local29, _1math__size4
MOV _1math__sqrt_add, _1math__local28, _1math__size4
$LEA _1math__zero, _1math__local14 
_1math__local12:
MOV sqrt - 8, _1math__sqrt_res, _1math__size4
LEA _1math__local30, _1math__size4
LEA _1math__local31, sqrt - 4
$MOV _1math__zero, _1math__local31, _1math__local30
; arguments
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
f:
MOV f - 8, f - 12, _1math__size4
MOV_CONST 1000, _1math__local32
MUL f - 8, f - 8, _1math__local32, _1math__size4
LEA _1math__local33, _1math__size4
LEA _1math__local34, f - 4
$MOV _1math__zero, _1math__local34, _1math__local33
_1math__local0:
.dd 0
_1math__local1:
.dd 0
_1math__local2:
.dd 0
_1math__local3:
.dd 0
_1math__local4:
.dd 0
_1math__local5:
.dd 0
_1math__local6:
.dd 0
_1math__local7:
.dd 0
_1math__sqrt_aa:
.dd 0
_1math__sqrt_res:
.dd 0
_1math__sqrt_add:
.dd 0
_1math__local8:
.dd 0
_1math__local9:
.dd 0
_1math__local10:
.dd 0
_1math__local11:
.dd 0
_1math__local15:
.dd 0
_1math__local16:
.dd 0
_1math__local17:
.dd 0
_1math__local20:
.dd 0
_1math__local21:
.dd 0
_1math__local22:
.dd 0
_1math__local23:
.dd 0
_1math__local24:
.dd 0
_1math__local25:
.dd 0
_1math__local26:
.dd 0
_1math__local27:
.dd 0
_1math__local28:
.dd 0
_1math__local29:
.dd 0
_1math__local30:
.dd 0
_1math__local31:
.dd 0
_1math__local32:
.dd 0
_1math__local33:
.dd 0
_1math__local34:
.dd 0
_1math__size4:
.dd 4
_1math__size1:
.dd 1
_1math__zero:
.dd 0

; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
phong:
MOV fmul - 12, phong - 24, _2main__size4
MOV fmul - 16, phong - 24, _2main__size4
LEA fmul - 4, _2main__local2
$LEA _2main__zero, fmul
_2main__local2:
MOV sqrt - 12, fmul - 8, _2main__size4
MOV fmul - 12, phong - 28, _2main__size4
MOV fmul - 16, phong - 28, _2main__size4
LEA fmul - 4, _2main__local4
$LEA _2main__zero, fmul
_2main__local4:
MOV _2main__local1, fmul - 8, _2main__size4
MOV fmul - 12, phong - 32, _2main__size4
MOV fmul - 16, phong - 32, _2main__size4
LEA fmul - 4, _2main__local5
$LEA _2main__zero, fmul
_2main__local5:
MOV _2main__local3, fmul - 8, _2main__size4
ADD _2main__local1, _2main__local1, _2main__local3, _2main__size4
ADD sqrt - 12, sqrt - 12, _2main__local1, _2main__size4
LEA sqrt - 4, _2main__local6
$LEA _2main__zero, sqrt
_2main__local6:
MOV _2main__local0, sqrt - 8, _2main__size4
MOV _2main__phong_l, _2main__local0, _2main__size4
MOV fdiv - 12, phong - 24, _2main__size4
MOV fdiv - 16, _2main__phong_l, _2main__size4
LEA fdiv - 4, _2main__local8
$LEA _2main__zero, fdiv
_2main__local8:
MOV _2main__local7, fdiv - 8, _2main__size4
MOV phong - 24, _2main__local7, _2main__size4
MOV fdiv - 12, phong - 28, _2main__size4
MOV fdiv - 16, _2main__phong_l, _2main__size4
LEA fdiv - 4, _2main__local10
$LEA _2main__zero, fdiv
_2main__local10:
MOV _2main__local9, fdiv - 8, _2main__size4
MOV phong - 28, _2main__local9, _2main__size4
MOV fdiv - 12, phong - 32, _2main__size4
MOV fdiv - 16, _2main__phong_l, _2main__size4
LEA fdiv - 4, _2main__local12
$LEA _2main__zero, fdiv
_2main__local12:
MOV _2main__local11, fdiv - 8, _2main__size4
MOV phong - 32, _2main__local11, _2main__size4
MOV fmul - 12, phong - 36, _2main__size4
MOV fmul - 16, phong - 36, _2main__size4
LEA fmul - 4, _2main__local15
$LEA _2main__zero, fmul
_2main__local15:
MOV sqrt - 12, fmul - 8, _2main__size4
MOV fmul - 12, phong - 40, _2main__size4
MOV fmul - 16, phong - 40, _2main__size4
LEA fmul - 4, _2main__local17
$LEA _2main__zero, fmul
_2main__local17:
MOV _2main__local14, fmul - 8, _2main__size4
MOV fmul - 12, phong - 44, _2main__size4
MOV fmul - 16, phong - 44, _2main__size4
LEA fmul - 4, _2main__local18
$LEA _2main__zero, fmul
_2main__local18:
MOV _2main__local16, fmul - 8, _2main__size4
ADD _2main__local14, _2main__local14, _2main__local16, _2main__size4
ADD sqrt - 12, sqrt - 12, _2main__local14, _2main__size4
LEA sqrt - 4, _2main__local19
$LEA _2main__zero, sqrt
_2main__local19:
MOV _2main__local13, sqrt - 8, _2main__size4
MOV _2main__phong_l, _2main__local13, _2main__size4
MOV fdiv - 12, phong - 36, _2main__size4
MOV fdiv - 16, _2main__phong_l, _2main__size4
LEA fdiv - 4, _2main__local21
$LEA _2main__zero, fdiv
_2main__local21:
MOV _2main__local20, fdiv - 8, _2main__size4
MOV phong - 36, _2main__local20, _2main__size4
MOV fdiv - 12, phong - 40, _2main__size4
MOV fdiv - 16, _2main__phong_l, _2main__size4
LEA fdiv - 4, _2main__local23
$LEA _2main__zero, fdiv
_2main__local23:
MOV _2main__local22, fdiv - 8, _2main__size4
MOV phong - 40, _2main__local22, _2main__size4
MOV fdiv - 12, phong - 44, _2main__size4
MOV fdiv - 16, _2main__phong_l, _2main__size4
LEA fdiv - 4, _2main__local25
$LEA _2main__zero, fdiv
_2main__local25:
MOV _2main__local24, fdiv - 8, _2main__size4
MOV phong - 44, _2main__local24, _2main__size4
MOV fmul - 12, phong - 12, _2main__size4
MOV fmul - 16, phong - 36, _2main__size4
LEA fmul - 4, _2main__local28
$LEA _2main__zero, fmul
_2main__local28:
MOV _2main__local26, fmul - 8, _2main__size4
MOV fmul - 12, phong - 16, _2main__size4
MOV fmul - 16, phong - 40, _2main__size4
LEA fmul - 4, _2main__local30
$LEA _2main__zero, fmul
_2main__local30:
MOV _2main__local27, fmul - 8, _2main__size4
MOV fmul - 12, phong - 20, _2main__size4
MOV fmul - 16, phong - 44, _2main__size4
LEA fmul - 4, _2main__local31
$LEA _2main__zero, fmul
_2main__local31:
MOV _2main__local29, fmul - 8, _2main__size4
ADD _2main__local27, _2main__local27, _2main__local29, _2main__size4
ADD _2main__local26, _2main__local26, _2main__local27, _2main__size4
MOV _2main__phong_diffuse, _2main__local26, _2main__size4
MOV fmul - 12, _2main__phong_diffuse, _2main__size4
MOV_CONST 400, fmul - 16
LEA fmul - 4, _2main__local33
$LEA _2main__zero, fmul
_2main__local33:
MOV _2main__local32, fmul - 8, _2main__size4
MOV _2main__phong_diffuse, _2main__local32, _2main__size4
MOV _2main__local36, _2main__phong_diffuse, _2main__size4
MOV_CONST 0, _2main__local38
LT _2main__local36, _2main__local36, _2main__local38, _2main__size4
LEA _2main__local37, _2main__local36
$CLEA _2main__local37, _2main__zero, _2main__local34 
$LEA _2main__zero, _2main__local35 
_2main__local34:
MOV_CONST 0, _2main__local39
MOV _2main__phong_diffuse, _2main__local39, _2main__size4
_2main__local35:
MOV _2main__local40, phong - 12, _2main__size4
MOV _2main__local41, phong - 24, _2main__size4
SUB _2main__local40, _2main__local40, _2main__local41, _2main__size4
MOV _2main__phong_x, _2main__local40, _2main__size4
MOV _2main__local42, phong - 16, _2main__size4
MOV _2main__local43, phong - 28, _2main__size4
SUB _2main__local42, _2main__local42, _2main__local43, _2main__size4
MOV _2main__phong_y, _2main__local42, _2main__size4
MOV _2main__local44, phong - 20, _2main__size4
MOV _2main__local45, phong - 32, _2main__size4
SUB _2main__local44, _2main__local44, _2main__local45, _2main__size4
MOV _2main__phong_z, _2main__local44, _2main__size4
MOV fmul - 12, _2main__phong_x, _2main__size4
MOV fmul - 16, _2main__phong_x, _2main__size4
LEA fmul - 4, _2main__local48
$LEA _2main__zero, fmul
_2main__local48:
MOV sqrt - 12, fmul - 8, _2main__size4
MOV fmul - 12, _2main__phong_y, _2main__size4
MOV fmul - 16, _2main__phong_y, _2main__size4
LEA fmul - 4, _2main__local50
$LEA _2main__zero, fmul
_2main__local50:
MOV _2main__local47, fmul - 8, _2main__size4
MOV fmul - 12, _2main__phong_z, _2main__size4
MOV fmul - 16, _2main__phong_z, _2main__size4
LEA fmul - 4, _2main__local51
$LEA _2main__zero, fmul
_2main__local51:
MOV _2main__local49, fmul - 8, _2main__size4
ADD _2main__local47, _2main__local47, _2main__local49, _2main__size4
ADD sqrt - 12, sqrt - 12, _2main__local47, _2main__size4
LEA sqrt - 4, _2main__local52
$LEA _2main__zero, sqrt
_2main__local52:
MOV _2main__local46, sqrt - 8, _2main__size4
MOV _2main__phong_l, _2main__local46, _2main__size4
MOV fdiv - 12, _2main__phong_x, _2main__size4
MOV fdiv - 16, _2main__phong_l, _2main__size4
LEA fdiv - 4, _2main__local54
$LEA _2main__zero, fdiv
_2main__local54:
MOV _2main__local53, fdiv - 8, _2main__size4
MOV _2main__phong_x, _2main__local53, _2main__size4
MOV fdiv - 12, _2main__phong_y, _2main__size4
MOV fdiv - 16, _2main__phong_l, _2main__size4
LEA fdiv - 4, _2main__local56
$LEA _2main__zero, fdiv
_2main__local56:
MOV _2main__local55, fdiv - 8, _2main__size4
MOV _2main__phong_y, _2main__local55, _2main__size4
MOV fdiv - 12, _2main__phong_z, _2main__size4
MOV fdiv - 16, _2main__phong_l, _2main__size4
LEA fdiv - 4, _2main__local58
$LEA _2main__zero, fdiv
_2main__local58:
MOV _2main__local57, fdiv - 8, _2main__size4
MOV _2main__phong_z, _2main__local57, _2main__size4
MOV fmul - 12, _2main__phong_x, _2main__size4
MOV fmul - 16, phong - 36, _2main__size4
LEA fmul - 4, _2main__local61
$LEA _2main__zero, fmul
_2main__local61:
MOV _2main__local59, fmul - 8, _2main__size4
MOV fmul - 12, _2main__phong_y, _2main__size4
MOV fmul - 16, phong - 40, _2main__size4
LEA fmul - 4, _2main__local63
$LEA _2main__zero, fmul
_2main__local63:
MOV _2main__local60, fmul - 8, _2main__size4
MOV fmul - 12, _2main__phong_z, _2main__size4
MOV fmul - 16, phong - 44, _2main__size4
LEA fmul - 4, _2main__local64
$LEA _2main__zero, fmul
_2main__local64:
MOV _2main__local62, fmul - 8, _2main__size4
ADD _2main__local60, _2main__local60, _2main__local62, _2main__size4
ADD _2main__local59, _2main__local59, _2main__local60, _2main__size4
MOV _2main__phong_blink, _2main__local59, _2main__size4
MOV _2main__local67, _2main__phong_blink, _2main__size4
MOV_CONST 0, _2main__local69
LT _2main__local67, _2main__local67, _2main__local69, _2main__size4
LEA _2main__local68, _2main__local67
$CLEA _2main__local68, _2main__zero, _2main__local65 
$LEA _2main__zero, _2main__local66 
_2main__local65:
MOV_CONST 0, _2main__local70
MOV _2main__phong_blink, _2main__local70, _2main__size4
_2main__local66:
MOV fmul - 12, _2main__phong_blink, _2main__size4
MOV fmul - 16, _2main__phong_blink, _2main__size4
LEA fmul - 4, _2main__local72
$LEA _2main__zero, fmul
_2main__local72:
MOV _2main__local71, fmul - 8, _2main__size4
MOV _2main__phong_blink, _2main__local71, _2main__size4
MOV fmul - 12, _2main__phong_blink, _2main__size4
MOV fmul - 16, _2main__phong_blink, _2main__size4
LEA fmul - 4, _2main__local74
$LEA _2main__zero, fmul
_2main__local74:
MOV _2main__local73, fmul - 8, _2main__size4
MOV _2main__phong_blink, _2main__local73, _2main__size4
MOV fmul - 12, _2main__phong_blink, _2main__size4
MOV fmul - 16, _2main__phong_blink, _2main__size4
LEA fmul - 4, _2main__local76
$LEA _2main__zero, fmul
_2main__local76:
MOV _2main__local75, fmul - 8, _2main__size4
MOV _2main__phong_l, _2main__local75, _2main__size4
MOV fmul - 12, _2main__phong_blink, _2main__size4
MOV fmul - 16, _2main__phong_l, _2main__size4
LEA fmul - 4, _2main__local78
$LEA _2main__zero, fmul
_2main__local78:
MOV _2main__local77, fmul - 8, _2main__size4
MOV _2main__phong_blink, _2main__local77, _2main__size4
MOV fmul - 12, _2main__phong_blink, _2main__size4
MOV_CONST 400, fmul - 16
LEA fmul - 4, _2main__local80
$LEA _2main__zero, fmul
_2main__local80:
MOV _2main__local79, fmul - 8, _2main__size4
MOV _2main__phong_blink, _2main__local79, _2main__size4
MOV_CONST 200, phong - 8
MOV _2main__local81, _2main__phong_diffuse, _2main__size4
MOV _2main__local82, _2main__phong_blink, _2main__size4
ADD _2main__local81, _2main__local81, _2main__local82, _2main__size4
ADD phong - 8, phong - 8, _2main__local81, _2main__size4
LEA _2main__local83, _2main__size4
LEA _2main__local84, phong - 4
$MOV _2main__zero, _2main__local84, _2main__local83
; arguments
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
main:
MOV_CONST 500, _2main__local85
MOV _2main__main_lx, _2main__local85, _2main__size4
MOV_CONST 1000, _2main__local86
MOV _2main__main_ly, _2main__local86, _2main__size4
MOV_CONST -800, _2main__local87
MOV _2main__main_lz, _2main__local87, _2main__size4
MOV fmul - 12, _2main__main_lx, _2main__size4
MOV fmul - 16, _2main__main_lx, _2main__size4
LEA fmul - 4, _2main__local90
$LEA _2main__zero, fmul
_2main__local90:
MOV sqrt - 12, fmul - 8, _2main__size4
MOV fmul - 12, _2main__main_ly, _2main__size4
MOV fmul - 16, _2main__main_ly, _2main__size4
LEA fmul - 4, _2main__local92
$LEA _2main__zero, fmul
_2main__local92:
MOV _2main__local89, fmul - 8, _2main__size4
MOV fmul - 12, _2main__main_lz, _2main__size4
MOV fmul - 16, _2main__main_lz, _2main__size4
LEA fmul - 4, _2main__local93
$LEA _2main__zero, fmul
_2main__local93:
MOV _2main__local91, fmul - 8, _2main__size4
ADD _2main__local89, _2main__local89, _2main__local91, _2main__size4
ADD sqrt - 12, sqrt - 12, _2main__local89, _2main__size4
LEA sqrt - 4, _2main__local94
$LEA _2main__zero, sqrt
_2main__local94:
MOV _2main__local88, sqrt - 8, _2main__size4
MOV _2main__main_t, _2main__local88, _2main__size4
MOV fdiv - 12, _2main__main_lx, _2main__size4
MOV fdiv - 16, _2main__main_t, _2main__size4
LEA fdiv - 4, _2main__local96
$LEA _2main__zero, fdiv
_2main__local96:
MOV _2main__local95, fdiv - 8, _2main__size4
MOV _2main__main_lx, _2main__local95, _2main__size4
MOV fdiv - 12, _2main__main_ly, _2main__size4
MOV fdiv - 16, _2main__main_t, _2main__size4
LEA fdiv - 4, _2main__local98
$LEA _2main__zero, fdiv
_2main__local98:
MOV _2main__local97, fdiv - 8, _2main__size4
MOV _2main__main_ly, _2main__local97, _2main__size4
MOV fdiv - 12, _2main__main_lz, _2main__size4
MOV fdiv - 16, _2main__main_t, _2main__size4
LEA fdiv - 4, _2main__local100
$LEA _2main__zero, fdiv
_2main__local100:
MOV _2main__local99, fdiv - 8, _2main__size4
MOV _2main__main_lz, _2main__local99, _2main__size4
MOV_CONST 0, _2main__local101
MOV _2main__main_gx, _2main__local101, _2main__size4
MOV_CONST 0, _2main__local102
MOV _2main__main_gy, _2main__local102, _2main__size4
MOV_CONST -4000, _2main__local103
MOV _2main__main_gz, _2main__local103, _2main__size4
LEA _2main__local108, _2main__local107
_2main__local106:
MOV_CONST 1, _2main__local107
$CLEA _2main__local108, _2main__zero, _2main__local105 
$LEA _2main__zero, _2main__local104
_2main__local105:
MOV_CONST 65536, _2main__local109
MOV _2main__main_start, _2main__local109, _2main__size4
MOV_CONST 65536, _2main__local110
MOV _2main__main_end, _2main__local110, _2main__size4
MOV _2main__local111, _2main__main_gz, _2main__size4
MOV_CONST 10, _2main__local112
ADD _2main__local111, _2main__local111, _2main__local112, _2main__size4
MOV _2main__main_gz, _2main__local111, _2main__size4
MOV _2main__local113, _2main__main_gx, _2main__size4
MOV_CONST 10, _2main__local114
SUB _2main__local113, _2main__local113, _2main__local114, _2main__size4
MOV _2main__main_gx, _2main__local113, _2main__size4
MOV_CONST 0, _2main__local115
MOV _2main__main_y, _2main__local115, _2main__size4
LEA _2main__local120, _2main__local119
_2main__local118:
MOV _2main__local119, _2main__main_y, _2main__size4
MOV_CONST 90, _2main__local121
LT _2main__local119, _2main__local119, _2main__local121, _2main__size4
$CLEA _2main__local120, _2main__zero, _2main__local117 
$LEA _2main__zero, _2main__local116
_2main__local117:
MOV_CONST 0, _2main__local122
MOV _2main__main_x, _2main__local122, _2main__size4
LEA _2main__local127, _2main__local126
_2main__local125:
MOV _2main__local126, _2main__main_x, _2main__size4
MOV_CONST 160, _2main__local128
LT _2main__local126, _2main__local126, _2main__local128, _2main__size4
$CLEA _2main__local127, _2main__zero, _2main__local124 
$LEA _2main__zero, _2main__local123
_2main__local124:
MOV _2main__local129, _2main__main_x, _2main__size4
MOV_CONST 80, _2main__local131
SUB _2main__local129, _2main__local129, _2main__local131, _2main__size4
MOV_CONST 12, _2main__local130
MUL _2main__local129, _2main__local129, _2main__local130, _2main__size4
MOV _2main__main_a, _2main__local129, _2main__size4
MOV_CONST 45, _2main__local132
MOV _2main__local134, _2main__main_y, _2main__size4
SUB _2main__local132, _2main__local132, _2main__local134, _2main__size4
MOV_CONST 12, _2main__local133
MUL _2main__local132, _2main__local132, _2main__local133, _2main__size4
MOV _2main__main_b, _2main__local132, _2main__size4
MOV _2main__local135, _2main__main_a, _2main__size4
MOV_CONST 2, _2main__local136
DIV _2main__local135, _2main__local135, _2main__local136, _2main__size4
MOV _2main__main_dx, _2main__local135, _2main__size4
MOV _2main__local137, _2main__main_b, _2main__size4
MOV_CONST 2, _2main__local138
DIV _2main__local137, _2main__local137, _2main__local138, _2main__size4
MOV _2main__main_dy, _2main__local137, _2main__size4
MOV_CONST 1000, _2main__local139
MOV _2main__main_dz, _2main__local139, _2main__size4
MOV intersect_ball - 12, _2main__main_gx, _2main__size4
MOV intersect_ball - 16, _2main__main_gy, _2main__size4
MOV intersect_ball - 20, _2main__main_gz, _2main__size4
MOV intersect_ball - 24, _2main__main_dx, _2main__size4
MOV intersect_ball - 28, _2main__main_dy, _2main__size4
MOV intersect_ball - 32, _2main__main_dz, _2main__size4
MOV_CONST 0, intersect_ball - 36
MOV_CONST 0, intersect_ball - 40
MOV_CONST 5000, intersect_ball - 44
MOV_CONST 1000, intersect_ball - 48
LEA intersect_ball - 4, _2main__local141
$LEA _2main__zero, intersect_ball
_2main__local141:
MOV _2main__local140, intersect_ball - 8, _2main__size4
MOV _2main__main_res, _2main__local140, _2main__size4
MOV _2main__local142, _2main__main_gx, _2main__size4
MOV fmul - 12, _2main__main_dx, _2main__size4
MOV fmul - 16, _2main__main_res, _2main__size4
LEA fmul - 4, _2main__local144
$LEA _2main__zero, fmul
_2main__local144:
MOV _2main__local143, fmul - 8, _2main__size4
ADD _2main__local142, _2main__local142, _2main__local143, _2main__size4
MOV _2main__main_px, _2main__local142, _2main__size4
MOV _2main__local145, _2main__main_gy, _2main__size4
MOV fmul - 12, _2main__main_dy, _2main__size4
MOV fmul - 16, _2main__main_res, _2main__size4
LEA fmul - 4, _2main__local147
$LEA _2main__zero, fmul
_2main__local147:
MOV _2main__local146, fmul - 8, _2main__size4
ADD _2main__local145, _2main__local145, _2main__local146, _2main__size4
MOV _2main__main_py, _2main__local145, _2main__size4
MOV _2main__local148, _2main__main_gz, _2main__size4
MOV fmul - 12, _2main__main_dz, _2main__size4
MOV fmul - 16, _2main__main_res, _2main__size4
LEA fmul - 4, _2main__local150
$LEA _2main__zero, fmul
_2main__local150:
MOV _2main__local149, fmul - 8, _2main__size4
ADD _2main__local148, _2main__local148, _2main__local149, _2main__size4
MOV _2main__main_pz, _2main__local148, _2main__size4
MOV _2main__local151, _2main__main_px, _2main__size4
MOV_CONST 0, _2main__local152
SUB _2main__local151, _2main__local151, _2main__local152, _2main__size4
MOV _2main__main_nx, _2main__local151, _2main__size4
MOV _2main__local153, _2main__main_py, _2main__size4
MOV_CONST 0, _2main__local154
SUB _2main__local153, _2main__local153, _2main__local154, _2main__size4
MOV _2main__main_ny, _2main__local153, _2main__size4
MOV _2main__local155, _2main__main_pz, _2main__size4
MOV_CONST 5000, _2main__local156
SUB _2main__local155, _2main__local155, _2main__local156, _2main__size4
MOV _2main__main_nz, _2main__local155, _2main__size4
MOV put4 - 12, _2main__main_end, _2main__size4
MOV_CONST 255, put4 - 16
MOV_CONST 255, _2main__local158
MUL put4 - 16, put4 - 16, _2main__local158, _2main__size4
LEA put4 - 4, _2main__local159
$LEA _2main__zero, put4
_2main__local159:
MOV _2main__local157, put4 - 8, _2main__size4
MOV _2main__main_t, _2main__local157, _2main__size4
MOV _2main__local162, _2main__main_res, _2main__size4
MOV_CONST 0, _2main__local164
LT _2main__local162, _2main__local164, _2main__local162, _2main__size4
LEA _2main__local163, _2main__local162
$CLEA _2main__local163, _2main__zero, _2main__local160 
$LEA _2main__zero, _2main__local161 
_2main__local160:
MOV phong - 12, _2main__main_lx, _2main__size4
MOV phong - 16, _2main__main_ly, _2main__size4
MOV phong - 20, _2main__main_lz, _2main__size4
MOV phong - 24, _2main__main_dx, _2main__size4
MOV phong - 28, _2main__main_dy, _2main__size4
MOV phong - 32, _2main__main_dz, _2main__size4
MOV phong - 36, _2main__main_nx, _2main__size4
MOV phong - 40, _2main__main_ny, _2main__size4
MOV phong - 44, _2main__main_nz, _2main__size4
LEA phong - 4, _2main__local166
$LEA _2main__zero, phong
_2main__local166:
MOV _2main__local165, phong - 8, _2main__size4
MOV _2main__main_spec, _2main__local165, _2main__size4
MOV_CONST 255, _2main__local167
MOV _2main__local169, _2main__main_spec, _2main__size4
MUL _2main__local167, _2main__local167, _2main__local169, _2main__size4
MOV_CONST 1000, _2main__local168
DIV _2main__local167, _2main__local167, _2main__local168, _2main__size4
MOV _2main__main_color, _2main__local167, _2main__size4
MOV put4 - 12, _2main__main_end, _2main__size4
MOV put4 - 16, _2main__main_color, _2main__size4
MOV_CONST 255, _2main__local171
MOV _2main__local173, _2main__main_color, _2main__size4
MUL _2main__local171, _2main__local171, _2main__local173, _2main__size4
MOV_CONST 65536, _2main__local172
MOV _2main__local174, _2main__main_color, _2main__size4
MUL _2main__local172, _2main__local172, _2main__local174, _2main__size4
ADD _2main__local171, _2main__local171, _2main__local172, _2main__size4
ADD put4 - 16, put4 - 16, _2main__local171, _2main__size4
LEA put4 - 4, _2main__local175
$LEA _2main__zero, put4
_2main__local175:
MOV _2main__local170, put4 - 8, _2main__size4
MOV _2main__main_t, _2main__local170, _2main__size4
_2main__local161:
MOV _2main__local176, _2main__main_end, _2main__size4
MOV_CONST 4, _2main__local177
ADD _2main__local176, _2main__local176, _2main__local177, _2main__size4
MOV _2main__main_end, _2main__local176, _2main__size4
MOV _2main__local178, _2main__main_x, _2main__size4
MOV_CONST 1, _2main__local179
ADD _2main__local178, _2main__local178, _2main__local179, _2main__size4
MOV _2main__main_x, _2main__local178, _2main__size4
$LEA _2main__zero, _2main__local125 
_2main__local123:
MOV _2main__local180, _2main__main_y, _2main__size4
MOV_CONST 1, _2main__local181
ADD _2main__local180, _2main__local180, _2main__local181, _2main__size4
MOV _2main__main_y, _2main__local180, _2main__size4
$LEA _2main__zero, _2main__local118 
_2main__local116:
MOV out - 12, _2main__main_start, _2main__size4
MOV out - 16, _2main__main_end, _2main__size4
MOV _2main__local183, _2main__main_start, _2main__size4
SUB out - 16, out - 16, _2main__local183, _2main__size4
LEA out - 4, _2main__local184
$LEA _2main__zero, out
_2main__local184:
MOV _2main__local182, out - 8, _2main__size4
MOV _2main__main_t, _2main__local182, _2main__size4
$LEA _2main__zero, _2main__local106 
_2main__local104:
MOV_CONST 0, main - 8
LEA _2main__local185, _2main__size4
LEA _2main__local186, main - 4
$MOV _2main__zero, _2main__local186, _2main__local185
_2main__phong_l:
.dd 0
_2main__local0:
.dd 0
_2main__local1:
.dd 0
_2main__local3:
.dd 0
_2main__local7:
.dd 0
_2main__local9:
.dd 0
_2main__local11:
.dd 0
_2main__local13:
.dd 0
_2main__local14:
.dd 0
_2main__local16:
.dd 0
_2main__local20:
.dd 0
_2main__local22:
.dd 0
_2main__local24:
.dd 0
_2main__phong_diffuse:
.dd 0
_2main__local26:
.dd 0
_2main__local27:
.dd 0
_2main__local29:
.dd 0
_2main__local32:
.dd 0
_2main__local36:
.dd 0
_2main__local37:
.dd 0
_2main__local38:
.dd 0
_2main__local39:
.dd 0
_2main__phong_x:
.dd 0
_2main__phong_y:
.dd 0
_2main__phong_z:
.dd 0
_2main__local40:
.dd 0
_2main__local41:
.dd 0
_2main__local42:
.dd 0
_2main__local43:
.dd 0
_2main__local44:
.dd 0
_2main__local45:
.dd 0
_2main__local46:
.dd 0
_2main__local47:
.dd 0
_2main__local49:
.dd 0
_2main__local53:
.dd 0
_2main__local55:
.dd 0
_2main__local57:
.dd 0
_2main__phong_blink:
.dd 0
_2main__local59:
.dd 0
_2main__local60:
.dd 0
_2main__local62:
.dd 0
_2main__local67:
.dd 0
_2main__local68:
.dd 0
_2main__local69:
.dd 0
_2main__local70:
.dd 0
_2main__local71:
.dd 0
_2main__local73:
.dd 0
_2main__local75:
.dd 0
_2main__local77:
.dd 0
_2main__local79:
.dd 0
_2main__local81:
.dd 0
_2main__local82:
.dd 0
_2main__local83:
.dd 0
_2main__local84:
.dd 0
_2main__main_res:
.dd 0
_2main__main_t:
.dd 0
_2main__main_x:
.dd 0
_2main__main_y:
.dd 0
_2main__main_gx:
.dd 0
_2main__main_gy:
.dd 0
_2main__main_gz:
.dd 0
_2main__main_lx:
.dd 0
_2main__main_ly:
.dd 0
_2main__main_lz:
.dd 0
_2main__local85:
.dd 0
_2main__local86:
.dd 0
_2main__local87:
.dd 0
_2main__local88:
.dd 0
_2main__local89:
.dd 0
_2main__local91:
.dd 0
_2main__local95:
.dd 0
_2main__local97:
.dd 0
_2main__local99:
.dd 0
_2main__local101:
.dd 0
_2main__local102:
.dd 0
_2main__local103:
.dd 0
_2main__local107:
.dd 0
_2main__local108:
.dd 0
_2main__main_start:
.dd 0
_2main__main_end:
.dd 0
_2main__local109:
.dd 0
_2main__local110:
.dd 0
_2main__local111:
.dd 0
_2main__local112:
.dd 0
_2main__local113:
.dd 0
_2main__local114:
.dd 0
_2main__local115:
.dd 0
_2main__local119:
.dd 0
_2main__local120:
.dd 0
_2main__local121:
.dd 0
_2main__local122:
.dd 0
_2main__local126:
.dd 0
_2main__local127:
.dd 0
_2main__local128:
.dd 0
_2main__main_a:
.dd 0
_2main__main_b:
.dd 0
_2main__local129:
.dd 0
_2main__local130:
.dd 0
_2main__local131:
.dd 0
_2main__local132:
.dd 0
_2main__local133:
.dd 0
_2main__local134:
.dd 0
_2main__main_dx:
.dd 0
_2main__main_dy:
.dd 0
_2main__main_dz:
.dd 0
_2main__main_px:
.dd 0
_2main__main_py:
.dd 0
_2main__main_pz:
.dd 0
_2main__main_nx:
.dd 0
_2main__main_ny:
.dd 0
_2main__main_nz:
.dd 0
_2main__local135:
.dd 0
_2main__local136:
.dd 0
_2main__local137:
.dd 0
_2main__local138:
.dd 0
_2main__local139:
.dd 0
_2main__local140:
.dd 0
_2main__local142:
.dd 0
_2main__local143:
.dd 0
_2main__local145:
.dd 0
_2main__local146:
.dd 0
_2main__local148:
.dd 0
_2main__local149:
.dd 0
_2main__local151:
.dd 0
_2main__local152:
.dd 0
_2main__local153:
.dd 0
_2main__local154:
.dd 0
_2main__local155:
.dd 0
_2main__local156:
.dd 0
_2main__local157:
.dd 0
_2main__local158:
.dd 0
_2main__local162:
.dd 0
_2main__local163:
.dd 0
_2main__local164:
.dd 0
_2main__main_spec:
.dd 0
_2main__local165:
.dd 0
_2main__main_color:
.dd 0
_2main__local167:
.dd 0
_2main__local168:
.dd 0
_2main__local169:
.dd 0
_2main__local170:
.dd 0
_2main__local171:
.dd 0
_2main__local172:
.dd 0
_2main__local173:
.dd 0
_2main__local174:
.dd 0
_2main__local176:
.dd 0
_2main__local177:
.dd 0
_2main__local178:
.dd 0
_2main__local179:
.dd 0
_2main__local180:
.dd 0
_2main__local181:
.dd 0
_2main__local182:
.dd 0
_2main__local183:
.dd 0
_2main__local185:
.dd 0
_2main__local186:
.dd 0
_2main__size4:
.dd 4
_2main__size1:
.dd 1
_2main__zero:
.dd 0


; int get4(int) function:
; 
; ptr - pointer to write data
; value - data to write
; 
; writes only 4 byte slices

; arguments
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE

get4:

; read data from memory
LEA _3io__size4_ptr, _3io__size4
LEA _3io__value_ptr, put4 - 8
$MOV _3io__value_ptr, put4 - 12, _3io__size4_ptr

; return to caller
LEA _3io__ptr_ptr, put4 - 4
$MOV _3io__zero, _3io__ptr_ptr, _3io__size4_ptr


; int get1(int) function:
; 
; ptr - pointer to write data
; value - data to write
; 
; writes only 1 byte slices

; arguments
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE

get1:

; write data to memory
LEA _3io__size1_ptr, _3io__size1
LEA _3io__size4_ptr, _3io__size4
LEA _3io__value_ptr, put1 - 8
$MOV _3io__value_ptr, put1 - 12, _3io__size1_ptr

; return to caller
LEA _3io__ptr_ptr, put1 - 4
$MOV _3io__zero, _3io__ptr_ptr, _3io__size4_ptr



; [void=int] put4(int, int) function:
; 
; ptr - pointer to write data
; value - data to write
; 
; writes only 4 byte slices

; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE

put4:

; write data to memory
LEA _3io__size4_ptr, _3io__size4
LEA _3io__value_ptr, put4 - 16
$MOV put4 - 12, _3io__value_ptr, _3io__size4_ptr

; return to caller
LEA _3io__ptr_ptr, put4 - 4
$MOV _3io__zero, _3io__ptr_ptr, _3io__size4_ptr


; [void=int] put1(int, int) function:
; 
; ptr - pointer to write data
; value - data to write
; 
; writes only 1 byte slices

; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE

put1:

; write data to memory
LEA _3io__size1_ptr, _3io__size1
LEA _3io__size4_ptr, _3io__size4
LEA _3io__value_ptr, put1 - 16
$MOV put1 - 12, _3io__value_ptr, _3io__size1_ptr

; return to caller
LEA _3io__ptr_ptr, put1 - 4
$MOV _3io__zero, _3io__ptr_ptr, _3io__size4_ptr


; [void=int] out(int, int) function:
; 
; ptr - pointer to output data
; count - count of data to write
; 
; writes data to first port
;

; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE

out:

; send output data
LEA _3io__ptr_ptr, out - 16
$OUT 1, out - 12, _3io__ptr_ptr

; return to caller
LEA _3io__size4_ptr, _3io__size4
LEA _3io__ptr_ptr, out - 4
$MOV _3io__zero, _3io__ptr_ptr, _3io__size4_ptr

_3io__ptr_ptr:
.dd 0
_3io__value_ptr:
.dd 0
_3io__size4_ptr:
.dd 0
_3io__size1_ptr:
.dd 0


_3io__size4:
.dd 4
_3io__size1:
.dd 4
_3io__zero:
.dd 0


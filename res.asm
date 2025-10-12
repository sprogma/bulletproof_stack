
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
MOV fmul - 16, phong - 12, _2main__size4
LEA fmul - 4, _2main__local28
$LEA _2main__zero, fmul
_2main__local28:
MOV sqrt - 12, fmul - 8, _2main__size4
MOV fmul - 12, phong - 16, _2main__size4
MOV fmul - 16, phong - 16, _2main__size4
LEA fmul - 4, _2main__local30
$LEA _2main__zero, fmul
_2main__local30:
MOV _2main__local27, fmul - 8, _2main__size4
MOV fmul - 12, phong - 20, _2main__size4
MOV fmul - 16, phong - 20, _2main__size4
LEA fmul - 4, _2main__local31
$LEA _2main__zero, fmul
_2main__local31:
MOV _2main__local29, fmul - 8, _2main__size4
ADD _2main__local27, _2main__local27, _2main__local29, _2main__size4
ADD sqrt - 12, sqrt - 12, _2main__local27, _2main__size4
LEA sqrt - 4, _2main__local32
$LEA _2main__zero, sqrt
_2main__local32:
MOV _2main__local26, sqrt - 8, _2main__size4
MOV _2main__phong_l, _2main__local26, _2main__size4
MOV _2main__local35, _2main__phong_l, _2main__size4
MOV_CONST 1, _2main__local37
LT _2main__local35, _2main__local35, _2main__local37, _2main__size4
LEA _2main__local36, _2main__local35
$CLEA _2main__local36, _2main__zero, _2main__local33 
$LEA _2main__zero, _2main__local34 
_2main__local33:
MOV_CONST 0, phong - 8
LEA _2main__local38, _2main__size4
LEA _2main__local39, phong - 4
$MOV _2main__zero, _2main__local39, _2main__local38
_2main__local34:
MOV fdiv - 12, phong - 12, _2main__size4
MOV fdiv - 16, _2main__phong_l, _2main__size4
LEA fdiv - 4, _2main__local41
$LEA _2main__zero, fdiv
_2main__local41:
MOV _2main__local40, fdiv - 8, _2main__size4
MOV phong - 12, _2main__local40, _2main__size4
MOV fdiv - 12, phong - 16, _2main__size4
MOV fdiv - 16, _2main__phong_l, _2main__size4
LEA fdiv - 4, _2main__local43
$LEA _2main__zero, fdiv
_2main__local43:
MOV _2main__local42, fdiv - 8, _2main__size4
MOV phong - 16, _2main__local42, _2main__size4
MOV fdiv - 12, phong - 20, _2main__size4
MOV fdiv - 16, _2main__phong_l, _2main__size4
LEA fdiv - 4, _2main__local45
$LEA _2main__zero, fdiv
_2main__local45:
MOV _2main__local44, fdiv - 8, _2main__size4
MOV phong - 20, _2main__local44, _2main__size4
MOV fmul - 12, phong - 12, _2main__size4
MOV fmul - 16, phong - 36, _2main__size4
LEA fmul - 4, _2main__local48
$LEA _2main__zero, fmul
_2main__local48:
MOV _2main__local46, fmul - 8, _2main__size4
MOV fmul - 12, phong - 16, _2main__size4
MOV fmul - 16, phong - 40, _2main__size4
LEA fmul - 4, _2main__local50
$LEA _2main__zero, fmul
_2main__local50:
MOV _2main__local47, fmul - 8, _2main__size4
MOV fmul - 12, phong - 20, _2main__size4
MOV fmul - 16, phong - 44, _2main__size4
LEA fmul - 4, _2main__local51
$LEA _2main__zero, fmul
_2main__local51:
MOV _2main__local49, fmul - 8, _2main__size4
ADD _2main__local47, _2main__local47, _2main__local49, _2main__size4
ADD _2main__local46, _2main__local46, _2main__local47, _2main__size4
MOV _2main__phong_diffuse, _2main__local46, _2main__size4
MOV fmul - 12, _2main__phong_diffuse, _2main__size4
MOV_CONST 400, fmul - 16
LEA fmul - 4, _2main__local53
$LEA _2main__zero, fmul
_2main__local53:
MOV _2main__local52, fmul - 8, _2main__size4
MOV _2main__phong_diffuse, _2main__local52, _2main__size4
MOV _2main__local56, _2main__phong_diffuse, _2main__size4
MOV_CONST 0, _2main__local58
LT _2main__local56, _2main__local56, _2main__local58, _2main__size4
LEA _2main__local57, _2main__local56
$CLEA _2main__local57, _2main__zero, _2main__local54 
$LEA _2main__zero, _2main__local55 
_2main__local54:
MOV_CONST 0, _2main__local59
MOV _2main__phong_diffuse, _2main__local59, _2main__size4
_2main__local55:
MOV_CONST 0, _2main__local60
MOV _2main__phong_blink, _2main__local60, _2main__size4
MOV _2main__local63, phong - 12, _2main__size4
MOV _2main__local67, phong - 36, _2main__size4
MUL _2main__local63, _2main__local63, _2main__local67, _2main__size4
MOV _2main__local66, phong - 16, _2main__size4
MOV _2main__local69, phong - 40, _2main__size4
MUL _2main__local66, _2main__local66, _2main__local69, _2main__size4
MOV _2main__local68, phong - 20, _2main__size4
MOV _2main__local70, phong - 44, _2main__size4
MUL _2main__local68, _2main__local68, _2main__local70, _2main__size4
ADD _2main__local66, _2main__local66, _2main__local68, _2main__size4
ADD _2main__local63, _2main__local63, _2main__local66, _2main__size4
MOV_CONST 0, _2main__local65
LT _2main__local63, _2main__local65, _2main__local63, _2main__size4
LEA _2main__local64, _2main__local63
$CLEA _2main__local64, _2main__zero, _2main__local61 
$LEA _2main__zero, _2main__local62 
_2main__local61:
MOV _2main__local71, phong - 12, _2main__size4
MOV _2main__local72, phong - 24, _2main__size4
SUB _2main__local71, _2main__local71, _2main__local72, _2main__size4
MOV _2main__phong_x, _2main__local71, _2main__size4
MOV _2main__local73, phong - 16, _2main__size4
MOV _2main__local74, phong - 28, _2main__size4
SUB _2main__local73, _2main__local73, _2main__local74, _2main__size4
MOV _2main__phong_y, _2main__local73, _2main__size4
MOV _2main__local75, phong - 20, _2main__size4
MOV _2main__local76, phong - 32, _2main__size4
SUB _2main__local75, _2main__local75, _2main__local76, _2main__size4
MOV _2main__phong_z, _2main__local75, _2main__size4
MOV fmul - 12, _2main__phong_x, _2main__size4
MOV fmul - 16, _2main__phong_x, _2main__size4
LEA fmul - 4, _2main__local79
$LEA _2main__zero, fmul
_2main__local79:
MOV sqrt - 12, fmul - 8, _2main__size4
MOV fmul - 12, _2main__phong_y, _2main__size4
MOV fmul - 16, _2main__phong_y, _2main__size4
LEA fmul - 4, _2main__local81
$LEA _2main__zero, fmul
_2main__local81:
MOV _2main__local78, fmul - 8, _2main__size4
MOV fmul - 12, _2main__phong_z, _2main__size4
MOV fmul - 16, _2main__phong_z, _2main__size4
LEA fmul - 4, _2main__local82
$LEA _2main__zero, fmul
_2main__local82:
MOV _2main__local80, fmul - 8, _2main__size4
ADD _2main__local78, _2main__local78, _2main__local80, _2main__size4
ADD sqrt - 12, sqrt - 12, _2main__local78, _2main__size4
LEA sqrt - 4, _2main__local83
$LEA _2main__zero, sqrt
_2main__local83:
MOV _2main__local77, sqrt - 8, _2main__size4
MOV _2main__phong_l, _2main__local77, _2main__size4
MOV _2main__local86, _2main__phong_l, _2main__size4
MOV_CONST 0, _2main__local88
LT _2main__local86, _2main__local88, _2main__local86, _2main__size4
LEA _2main__local87, _2main__local86
$CLEA _2main__local87, _2main__zero, _2main__local84 
$LEA _2main__zero, _2main__local85 
_2main__local84:
MOV fdiv - 12, _2main__phong_x, _2main__size4
MOV fdiv - 16, _2main__phong_l, _2main__size4
LEA fdiv - 4, _2main__local90
$LEA _2main__zero, fdiv
_2main__local90:
MOV _2main__local89, fdiv - 8, _2main__size4
MOV _2main__phong_x, _2main__local89, _2main__size4
MOV fdiv - 12, _2main__phong_y, _2main__size4
MOV fdiv - 16, _2main__phong_l, _2main__size4
LEA fdiv - 4, _2main__local92
$LEA _2main__zero, fdiv
_2main__local92:
MOV _2main__local91, fdiv - 8, _2main__size4
MOV _2main__phong_y, _2main__local91, _2main__size4
MOV fdiv - 12, _2main__phong_z, _2main__size4
MOV fdiv - 16, _2main__phong_l, _2main__size4
LEA fdiv - 4, _2main__local94
$LEA _2main__zero, fdiv
_2main__local94:
MOV _2main__local93, fdiv - 8, _2main__size4
MOV _2main__phong_z, _2main__local93, _2main__size4
_2main__local85:
MOV fmul - 12, _2main__phong_x, _2main__size4
MOV fmul - 16, phong - 36, _2main__size4
LEA fmul - 4, _2main__local97
$LEA _2main__zero, fmul
_2main__local97:
MOV _2main__local95, fmul - 8, _2main__size4
MOV fmul - 12, _2main__phong_y, _2main__size4
MOV fmul - 16, phong - 40, _2main__size4
LEA fmul - 4, _2main__local99
$LEA _2main__zero, fmul
_2main__local99:
MOV _2main__local96, fmul - 8, _2main__size4
MOV fmul - 12, _2main__phong_z, _2main__size4
MOV fmul - 16, phong - 44, _2main__size4
LEA fmul - 4, _2main__local100
$LEA _2main__zero, fmul
_2main__local100:
MOV _2main__local98, fmul - 8, _2main__size4
ADD _2main__local96, _2main__local96, _2main__local98, _2main__size4
ADD _2main__local95, _2main__local95, _2main__local96, _2main__size4
MOV _2main__phong_blink, _2main__local95, _2main__size4
MOV _2main__local103, _2main__phong_blink, _2main__size4
MOV_CONST 0, _2main__local105
LT _2main__local103, _2main__local103, _2main__local105, _2main__size4
LEA _2main__local104, _2main__local103
$CLEA _2main__local104, _2main__zero, _2main__local101 
$LEA _2main__zero, _2main__local102 
_2main__local101:
MOV_CONST 0, _2main__local106
MOV _2main__phong_blink, _2main__local106, _2main__size4
_2main__local102:
MOV fmul - 12, _2main__phong_blink, _2main__size4
MOV fmul - 16, _2main__phong_blink, _2main__size4
LEA fmul - 4, _2main__local108
$LEA _2main__zero, fmul
_2main__local108:
MOV _2main__local107, fmul - 8, _2main__size4
MOV _2main__phong_blink, _2main__local107, _2main__size4
MOV fmul - 12, _2main__phong_blink, _2main__size4
MOV fmul - 16, _2main__phong_blink, _2main__size4
LEA fmul - 4, _2main__local110
$LEA _2main__zero, fmul
_2main__local110:
MOV _2main__local109, fmul - 8, _2main__size4
MOV _2main__phong_blink, _2main__local109, _2main__size4
MOV fmul - 12, _2main__phong_blink, _2main__size4
MOV fmul - 16, _2main__phong_blink, _2main__size4
LEA fmul - 4, _2main__local112
$LEA _2main__zero, fmul
_2main__local112:
MOV _2main__local111, fmul - 8, _2main__size4
MOV _2main__phong_blink, _2main__local111, _2main__size4
MOV fmul - 12, _2main__phong_blink, _2main__size4
MOV_CONST 400, fmul - 16
LEA fmul - 4, _2main__local114
$LEA _2main__zero, fmul
_2main__local114:
MOV _2main__local113, fmul - 8, _2main__size4
MOV _2main__phong_blink, _2main__local113, _2main__size4
_2main__local62:
MOV_CONST 200, _2main__local115
MOV _2main__local116, _2main__phong_diffuse, _2main__size4
MOV _2main__local117, _2main__phong_blink, _2main__size4
ADD _2main__local116, _2main__local116, _2main__local117, _2main__size4
ADD _2main__local115, _2main__local115, _2main__local116, _2main__size4
MOV _2main__phong_ans, _2main__local115, _2main__size4
MOV _2main__local120, _2main__phong_ans, _2main__size4
MOV_CONST 1000, _2main__local122
LT _2main__local120, _2main__local122, _2main__local120, _2main__size4
LEA _2main__local121, _2main__local120
$CLEA _2main__local121, _2main__zero, _2main__local118 
$LEA _2main__zero, _2main__local119 
_2main__local118:
MOV_CONST 1000, _2main__local123
MOV _2main__phong_ans, _2main__local123, _2main__size4
_2main__local119:
MOV phong - 8, _2main__phong_ans, _2main__size4
LEA _2main__local124, _2main__size4
LEA _2main__local125, phong - 4
$MOV _2main__zero, _2main__local125, _2main__local124
; arguments
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
main:
MOV_CONST 1000, _2main__local126
MOV _2main__main_lx, _2main__local126, _2main__size4
MOV_CONST 0, _2main__local127
MOV _2main__main_ly, _2main__local127, _2main__size4
MOV_CONST 0, _2main__local128
MOV _2main__main_lz, _2main__local128, _2main__size4
MOV_CONST 50, _2main__local129
MOV_CONST 100, _2main__local130
MUL _2main__local129, _2main__local129, _2main__local130, _2main__size4
MOV _2main__main_gx, _2main__local129, _2main__size4
MOV_CONST 0, _2main__local131
MOV _2main__main_ggdx, _2main__local131, _2main__size4
MOV_CONST 10, _2main__local132
MOV_CONST 100, _2main__local133
MUL _2main__local132, _2main__local132, _2main__local133, _2main__size4
MOV _2main__main_gy, _2main__local132, _2main__size4
MOV_CONST -8000, _2main__local134
MOV_CONST 50, _2main__local135
MOV_CONST 100, _2main__local136
MUL _2main__local135, _2main__local135, _2main__local136, _2main__size4
ADD _2main__local134, _2main__local134, _2main__local135, _2main__size4
MOV _2main__main_gz, _2main__local134, _2main__size4
MOV_CONST 0, _2main__local137
MOV _2main__main_tim, _2main__local137, _2main__size4
LEA _2main__local142, _2main__local141
_2main__local140:
MOV_CONST 1, _2main__local141
$CLEA _2main__local142, _2main__zero, _2main__local139 
$LEA _2main__zero, _2main__local138
_2main__local139:
MOV_CONST 65536, _2main__local143
MOV _2main__main_start, _2main__local143, _2main__size4
MOV_CONST 65536, _2main__local144
MOV _2main__main_end, _2main__local144, _2main__size4
MOV _2main__local145, _2main__main_tim, _2main__size4
MOV_CONST 1, _2main__local146
ADD _2main__local145, _2main__local145, _2main__local146, _2main__size4
MOV _2main__main_tim, _2main__local145, _2main__size4
MOV _2main__local147, _2main__main_lx, _2main__size4
MOV _2main__main_k1, _2main__local147, _2main__size4
MOV _2main__local148, _2main__main_ly, _2main__size4
MOV _2main__main_k2, _2main__local148, _2main__size4
MOV _2main__local149, _2main__main_lz, _2main__size4
MOV _2main__main_k3, _2main__local149, _2main__size4
MOV _2main__local152, _2main__main_tim, _2main__size4
MOV _2main__local155, _2main__main_tim, _2main__size4
MOV_CONST 100, _2main__local157
DIV _2main__local155, _2main__local155, _2main__local157, _2main__size4
MOV_CONST 100, _2main__local156
MUL _2main__local155, _2main__local155, _2main__local156, _2main__size4
SUB _2main__local152, _2main__local152, _2main__local155, _2main__size4
MOV_CONST 50, _2main__local154
LT _2main__local152, _2main__local152, _2main__local154, _2main__size4
LEA _2main__local153, _2main__local152
$CLEA _2main__local153, _2main__zero, _2main__local150 
MOV fmul - 12, _2main__main_k1, _2main__size4
MOV_CONST 995, fmul - 16
LEA fmul - 4, _2main__local160
$LEA _2main__zero, fmul
_2main__local160:
MOV _2main__local158, fmul - 8, _2main__size4
MOV fmul - 12, _2main__main_k2, _2main__size4
MOV_CONST -89, fmul - 16
LEA fmul - 4, _2main__local162
$LEA _2main__zero, fmul
_2main__local162:
MOV _2main__local159, fmul - 8, _2main__size4
MOV fmul - 12, _2main__main_k3, _2main__size4
MOV_CONST 19, fmul - 16
LEA fmul - 4, _2main__local163
$LEA _2main__zero, fmul
_2main__local163:
MOV _2main__local161, fmul - 8, _2main__size4
ADD _2main__local159, _2main__local159, _2main__local161, _2main__size4
ADD _2main__local158, _2main__local158, _2main__local159, _2main__size4
MOV _2main__main_lx, _2main__local158, _2main__size4
MOV fmul - 12, _2main__main_k1, _2main__size4
MOV_CONST 89, fmul - 16
LEA fmul - 4, _2main__local166
$LEA _2main__zero, fmul
_2main__local166:
MOV _2main__local164, fmul - 8, _2main__size4
MOV fmul - 12, _2main__main_k2, _2main__size4
MOV_CONST 995, fmul - 16
LEA fmul - 4, _2main__local168
$LEA _2main__zero, fmul
_2main__local168:
MOV _2main__local165, fmul - 8, _2main__size4
MOV fmul - 12, _2main__main_k3, _2main__size4
MOV_CONST -19, fmul - 16
LEA fmul - 4, _2main__local169
$LEA _2main__zero, fmul
_2main__local169:
MOV _2main__local167, fmul - 8, _2main__size4
ADD _2main__local165, _2main__local165, _2main__local167, _2main__size4
ADD _2main__local164, _2main__local164, _2main__local165, _2main__size4
MOV _2main__main_ly, _2main__local164, _2main__size4
MOV fmul - 12, _2main__main_k1, _2main__size4
MOV_CONST -21, fmul - 16
LEA fmul - 4, _2main__local172
$LEA _2main__zero, fmul
_2main__local172:
MOV _2main__local170, fmul - 8, _2main__size4
MOV fmul - 12, _2main__main_k2, _2main__size4
MOV_CONST -18, fmul - 16
LEA fmul - 4, _2main__local174
$LEA _2main__zero, fmul
_2main__local174:
MOV _2main__local171, fmul - 8, _2main__size4
MOV fmul - 12, _2main__main_k3, _2main__size4
MOV_CONST 999, fmul - 16
LEA fmul - 4, _2main__local175
$LEA _2main__zero, fmul
_2main__local175:
MOV _2main__local173, fmul - 8, _2main__size4
ADD _2main__local171, _2main__local171, _2main__local173, _2main__size4
ADD _2main__local170, _2main__local170, _2main__local171, _2main__size4
MOV _2main__main_lz, _2main__local170, _2main__size4
$LEA _2main__zero, _2main__local151 
_2main__local150:
MOV fmul - 12, _2main__main_k1, _2main__size4
MOV_CONST 993, fmul - 16
LEA fmul - 4, _2main__local178
$LEA _2main__zero, fmul
_2main__local178:
MOV _2main__local176, fmul - 8, _2main__size4
MOV fmul - 12, _2main__main_k2, _2main__size4
MOV_CONST -59, fmul - 16
LEA fmul - 4, _2main__local180
$LEA _2main__zero, fmul
_2main__local180:
MOV _2main__local177, fmul - 8, _2main__size4
MOV fmul - 12, _2main__main_k3, _2main__size4
MOV_CONST 99, fmul - 16
LEA fmul - 4, _2main__local181
$LEA _2main__zero, fmul
_2main__local181:
MOV _2main__local179, fmul - 8, _2main__size4
ADD _2main__local177, _2main__local177, _2main__local179, _2main__size4
ADD _2main__local176, _2main__local176, _2main__local177, _2main__size4
MOV _2main__main_lx, _2main__local176, _2main__size4
MOV fmul - 12, _2main__main_k1, _2main__size4
MOV_CONST 65, fmul - 16
LEA fmul - 4, _2main__local184
$LEA _2main__zero, fmul
_2main__local184:
MOV _2main__local182, fmul - 8, _2main__size4
MOV fmul - 12, _2main__main_k2, _2main__size4
MOV_CONST 996, fmul - 16
LEA fmul - 4, _2main__local186
$LEA _2main__zero, fmul
_2main__local186:
MOV _2main__local183, fmul - 8, _2main__size4
MOV fmul - 12, _2main__main_k3, _2main__size4
MOV_CONST -59, fmul - 16
LEA fmul - 4, _2main__local187
$LEA _2main__zero, fmul
_2main__local187:
MOV _2main__local185, fmul - 8, _2main__size4
ADD _2main__local183, _2main__local183, _2main__local185, _2main__size4
ADD _2main__local182, _2main__local182, _2main__local183, _2main__size4
MOV _2main__main_ly, _2main__local182, _2main__size4
MOV fmul - 12, _2main__main_k1, _2main__size4
MOV_CONST -95, fmul - 16
LEA fmul - 4, _2main__local190
$LEA _2main__zero, fmul
_2main__local190:
MOV _2main__local188, fmul - 8, _2main__size4
MOV fmul - 12, _2main__main_k2, _2main__size4
MOV_CONST 65, fmul - 16
LEA fmul - 4, _2main__local192
$LEA _2main__zero, fmul
_2main__local192:
MOV _2main__local189, fmul - 8, _2main__size4
MOV fmul - 12, _2main__main_k3, _2main__size4
MOV_CONST 993, fmul - 16
LEA fmul - 4, _2main__local193
$LEA _2main__zero, fmul
_2main__local193:
MOV _2main__local191, fmul - 8, _2main__size4
ADD _2main__local189, _2main__local189, _2main__local191, _2main__size4
ADD _2main__local188, _2main__local188, _2main__local189, _2main__size4
MOV _2main__main_lz, _2main__local188, _2main__size4
_2main__local151:
MOV _2main__local196, _2main__main_tim, _2main__size4
MOV _2main__local199, _2main__main_tim, _2main__size4
MOV_CONST 400, _2main__local201
DIV _2main__local199, _2main__local199, _2main__local201, _2main__size4
MOV_CONST 400, _2main__local200
MUL _2main__local199, _2main__local199, _2main__local200, _2main__size4
SUB _2main__local196, _2main__local196, _2main__local199, _2main__size4
MOV_CONST 200, _2main__local198
LT _2main__local196, _2main__local196, _2main__local198, _2main__size4
LEA _2main__local197, _2main__local196
$CLEA _2main__local197, _2main__zero, _2main__local194 
MOV _2main__local202, _2main__main_gx, _2main__size4
MOV_CONST 50, _2main__local203
ADD _2main__local202, _2main__local202, _2main__local203, _2main__size4
MOV _2main__main_gx, _2main__local202, _2main__size4
MOV _2main__local204, _2main__main_gy, _2main__size4
MOV_CONST 10, _2main__local205
ADD _2main__local204, _2main__local204, _2main__local205, _2main__size4
MOV _2main__main_gy, _2main__local204, _2main__size4
MOV _2main__local206, _2main__main_gz, _2main__size4
MOV_CONST 50, _2main__local207
ADD _2main__local206, _2main__local206, _2main__local207, _2main__size4
MOV _2main__main_gz, _2main__local206, _2main__size4
$LEA _2main__zero, _2main__local195 
_2main__local194:
MOV _2main__local208, _2main__main_gx, _2main__size4
MOV_CONST 50, _2main__local209
SUB _2main__local208, _2main__local208, _2main__local209, _2main__size4
MOV _2main__main_gx, _2main__local208, _2main__size4
MOV _2main__local210, _2main__main_gy, _2main__size4
MOV_CONST 10, _2main__local211
SUB _2main__local210, _2main__local210, _2main__local211, _2main__size4
MOV _2main__main_gy, _2main__local210, _2main__size4
MOV _2main__local212, _2main__main_gz, _2main__size4
MOV_CONST 50, _2main__local213
SUB _2main__local212, _2main__local212, _2main__local213, _2main__size4
MOV _2main__main_gz, _2main__local212, _2main__size4
_2main__local195:
MOV fmul - 12, _2main__main_lx, _2main__size4
MOV fmul - 16, _2main__main_lx, _2main__size4
LEA fmul - 4, _2main__local217
$LEA _2main__zero, fmul
_2main__local217:
MOV sqrt - 12, fmul - 8, _2main__size4
MOV fmul - 12, _2main__main_ly, _2main__size4
MOV fmul - 16, _2main__main_ly, _2main__size4
LEA fmul - 4, _2main__local219
$LEA _2main__zero, fmul
_2main__local219:
MOV _2main__local216, fmul - 8, _2main__size4
MOV fmul - 12, _2main__main_lz, _2main__size4
MOV fmul - 16, _2main__main_lz, _2main__size4
LEA fmul - 4, _2main__local220
$LEA _2main__zero, fmul
_2main__local220:
MOV _2main__local218, fmul - 8, _2main__size4
ADD _2main__local216, _2main__local216, _2main__local218, _2main__size4
ADD sqrt - 12, sqrt - 12, _2main__local216, _2main__size4
LEA sqrt - 4, _2main__local221
$LEA _2main__zero, sqrt
_2main__local221:
MOV _2main__local214, sqrt - 8, _2main__size4
MOV_CONST 3, _2main__local215
DIV _2main__local214, _2main__local214, _2main__local215, _2main__size4
MOV _2main__main_t, _2main__local214, _2main__size4
MOV fdiv - 12, _2main__main_lx, _2main__size4
MOV fdiv - 16, _2main__main_t, _2main__size4
LEA fdiv - 4, _2main__local223
$LEA _2main__zero, fdiv
_2main__local223:
MOV _2main__local222, fdiv - 8, _2main__size4
MOV _2main__main_lx, _2main__local222, _2main__size4
MOV fdiv - 12, _2main__main_ly, _2main__size4
MOV fdiv - 16, _2main__main_t, _2main__size4
LEA fdiv - 4, _2main__local225
$LEA _2main__zero, fdiv
_2main__local225:
MOV _2main__local224, fdiv - 8, _2main__size4
MOV _2main__main_ly, _2main__local224, _2main__size4
MOV fdiv - 12, _2main__main_lz, _2main__size4
MOV fdiv - 16, _2main__main_t, _2main__size4
LEA fdiv - 4, _2main__local227
$LEA _2main__zero, fdiv
_2main__local227:
MOV _2main__local226, fdiv - 8, _2main__size4
MOV _2main__main_lz, _2main__local226, _2main__size4
MOV_CONST 0, _2main__local228
MOV _2main__main_y, _2main__local228, _2main__size4
LEA _2main__local233, _2main__local232
_2main__local231:
MOV _2main__local232, _2main__main_y, _2main__size4
MOV_CONST 90, _2main__local234
LT _2main__local232, _2main__local232, _2main__local234, _2main__size4
$CLEA _2main__local233, _2main__zero, _2main__local230 
$LEA _2main__zero, _2main__local229
_2main__local230:
MOV_CONST 0, _2main__local235
MOV _2main__main_x, _2main__local235, _2main__size4
LEA _2main__local240, _2main__local239
_2main__local238:
MOV _2main__local239, _2main__main_x, _2main__size4
MOV_CONST 160, _2main__local241
LT _2main__local239, _2main__local239, _2main__local241, _2main__size4
$CLEA _2main__local240, _2main__zero, _2main__local237 
$LEA _2main__zero, _2main__local236
_2main__local237:
MOV _2main__local242, _2main__main_x, _2main__size4
MOV_CONST 80, _2main__local244
SUB _2main__local242, _2main__local242, _2main__local244, _2main__size4
MOV_CONST 12, _2main__local243
MUL _2main__local242, _2main__local242, _2main__local243, _2main__size4
MOV _2main__main_a, _2main__local242, _2main__size4
MOV_CONST 45, _2main__local245
MOV _2main__local247, _2main__main_y, _2main__size4
SUB _2main__local245, _2main__local245, _2main__local247, _2main__size4
MOV_CONST 12, _2main__local246
MUL _2main__local245, _2main__local245, _2main__local246, _2main__size4
MOV _2main__main_b, _2main__local245, _2main__size4
MOV _2main__local248, _2main__main_a, _2main__size4
MOV_CONST 2, _2main__local250
MUL _2main__local248, _2main__local248, _2main__local250, _2main__size4
MOV_CONST 3, _2main__local249
DIV _2main__local248, _2main__local248, _2main__local249, _2main__size4
MOV _2main__main_dx, _2main__local248, _2main__size4
MOV _2main__local251, _2main__main_b, _2main__size4
MOV_CONST 2, _2main__local253
MUL _2main__local251, _2main__local251, _2main__local253, _2main__size4
MOV_CONST 3, _2main__local252
DIV _2main__local251, _2main__local251, _2main__local252, _2main__size4
MOV _2main__main_dy, _2main__local251, _2main__size4
MOV_CONST 1000, _2main__local254
MOV _2main__main_dz, _2main__local254, _2main__size4
MOV intersect_ball - 12, _2main__main_gx, _2main__size4
MOV intersect_ball - 16, _2main__main_gy, _2main__size4
MOV intersect_ball - 20, _2main__main_gz, _2main__size4
MOV intersect_ball - 24, _2main__main_dx, _2main__size4
MOV intersect_ball - 28, _2main__main_dy, _2main__size4
MOV intersect_ball - 32, _2main__main_dz, _2main__size4
MOV_CONST -1200, intersect_ball - 36
MOV_CONST -600, intersect_ball - 40
MOV_CONST 0, intersect_ball - 44
MOV_CONST 1500, intersect_ball - 48
LEA intersect_ball - 4, _2main__local256
$LEA _2main__zero, intersect_ball
_2main__local256:
MOV _2main__local255, intersect_ball - 8, _2main__size4
MOV _2main__main_res1, _2main__local255, _2main__size4
MOV put4 - 12, _2main__main_end, _2main__size4
MOV_CONST 0, put4 - 16
LEA put4 - 4, _2main__local258
$LEA _2main__zero, put4
_2main__local258:
MOV _2main__local257, put4 - 8, _2main__size4
MOV _2main__main_t, _2main__local257, _2main__size4
MOV _2main__local261, _2main__main_res1, _2main__size4
MOV_CONST 0, _2main__local263
LT _2main__local261, _2main__local263, _2main__local261, _2main__size4
LEA _2main__local262, _2main__local261
$CLEA _2main__local262, _2main__zero, _2main__local259 
$LEA _2main__zero, _2main__local260 
_2main__local259:
MOV _2main__local264, _2main__main_gx, _2main__size4
MOV fmul - 12, _2main__main_dx, _2main__size4
MOV fmul - 16, _2main__main_res1, _2main__size4
LEA fmul - 4, _2main__local266
$LEA _2main__zero, fmul
_2main__local266:
MOV _2main__local265, fmul - 8, _2main__size4
ADD _2main__local264, _2main__local264, _2main__local265, _2main__size4
MOV _2main__main_px, _2main__local264, _2main__size4
MOV _2main__local267, _2main__main_gy, _2main__size4
MOV fmul - 12, _2main__main_dy, _2main__size4
MOV fmul - 16, _2main__main_res1, _2main__size4
LEA fmul - 4, _2main__local269
$LEA _2main__zero, fmul
_2main__local269:
MOV _2main__local268, fmul - 8, _2main__size4
ADD _2main__local267, _2main__local267, _2main__local268, _2main__size4
MOV _2main__main_py, _2main__local267, _2main__size4
MOV _2main__local270, _2main__main_gz, _2main__size4
MOV fmul - 12, _2main__main_dz, _2main__size4
MOV fmul - 16, _2main__main_res1, _2main__size4
LEA fmul - 4, _2main__local272
$LEA _2main__zero, fmul
_2main__local272:
MOV _2main__local271, fmul - 8, _2main__size4
ADD _2main__local270, _2main__local270, _2main__local271, _2main__size4
MOV _2main__main_pz, _2main__local270, _2main__size4
MOV _2main__local273, _2main__main_px, _2main__size4
MOV_CONST 1200, _2main__local274
ADD _2main__local273, _2main__local273, _2main__local274, _2main__size4
MOV _2main__main_nx, _2main__local273, _2main__size4
MOV _2main__local275, _2main__main_py, _2main__size4
MOV_CONST 600, _2main__local276
ADD _2main__local275, _2main__local275, _2main__local276, _2main__size4
MOV _2main__main_ny, _2main__local275, _2main__size4
MOV _2main__local277, _2main__main_pz, _2main__size4
MOV_CONST 0, _2main__local278
SUB _2main__local277, _2main__local277, _2main__local278, _2main__size4
MOV _2main__main_nz, _2main__local277, _2main__size4
MOV _2main__local279, _2main__main_lx, _2main__size4
MOV _2main__local280, _2main__main_px, _2main__size4
SUB _2main__local279, _2main__local279, _2main__local280, _2main__size4
MOV _2main__main_ldx, _2main__local279, _2main__size4
MOV _2main__local281, _2main__main_ly, _2main__size4
MOV _2main__local282, _2main__main_py, _2main__size4
SUB _2main__local281, _2main__local281, _2main__local282, _2main__size4
MOV _2main__main_ldy, _2main__local281, _2main__size4
MOV _2main__local283, _2main__main_lz, _2main__size4
MOV _2main__local284, _2main__main_pz, _2main__size4
SUB _2main__local283, _2main__local283, _2main__local284, _2main__size4
MOV _2main__main_ldz, _2main__local283, _2main__size4
MOV phong - 12, _2main__main_ldx, _2main__size4
MOV phong - 16, _2main__main_ldy, _2main__size4
MOV phong - 20, _2main__main_ldz, _2main__size4
MOV phong - 24, _2main__main_dx, _2main__size4
MOV phong - 28, _2main__main_dy, _2main__size4
MOV phong - 32, _2main__main_dz, _2main__size4
MOV phong - 36, _2main__main_nx, _2main__size4
MOV phong - 40, _2main__main_ny, _2main__size4
MOV phong - 44, _2main__main_nz, _2main__size4
LEA phong - 4, _2main__local286
$LEA _2main__zero, phong
_2main__local286:
MOV _2main__local285, phong - 8, _2main__size4
MOV _2main__main_spec, _2main__local285, _2main__size4
MOV_CONST 255, _2main__local287
MOV _2main__local289, _2main__main_spec, _2main__size4
MUL _2main__local287, _2main__local287, _2main__local289, _2main__size4
MOV_CONST 1000, _2main__local288
DIV _2main__local287, _2main__local287, _2main__local288, _2main__size4
MOV _2main__main_color, _2main__local287, _2main__size4
MOV put4 - 12, _2main__main_end, _2main__size4
MOV put4 - 16, _2main__main_color, _2main__size4
MOV_CONST 255, _2main__local291
MOV _2main__local293, _2main__main_color, _2main__size4
MUL _2main__local291, _2main__local291, _2main__local293, _2main__size4
MOV_CONST 65536, _2main__local292
MOV _2main__local294, _2main__main_color, _2main__size4
MUL _2main__local292, _2main__local292, _2main__local294, _2main__size4
ADD _2main__local291, _2main__local291, _2main__local292, _2main__size4
ADD put4 - 16, put4 - 16, _2main__local291, _2main__size4
LEA put4 - 4, _2main__local295
$LEA _2main__zero, put4
_2main__local295:
MOV _2main__local290, put4 - 8, _2main__size4
MOV _2main__main_t, _2main__local290, _2main__size4
_2main__local260:
MOV intersect_ball - 12, _2main__main_gx, _2main__size4
MOV intersect_ball - 16, _2main__main_gy, _2main__size4
MOV intersect_ball - 20, _2main__main_gz, _2main__size4
MOV intersect_ball - 24, _2main__main_dx, _2main__size4
MOV intersect_ball - 28, _2main__main_dy, _2main__size4
MOV intersect_ball - 32, _2main__main_dz, _2main__size4
MOV_CONST 1500, intersect_ball - 36
MOV_CONST 700, intersect_ball - 40
MOV_CONST 800, intersect_ball - 44
MOV_CONST 1000, intersect_ball - 48
LEA intersect_ball - 4, _2main__local297
$LEA _2main__zero, intersect_ball
_2main__local297:
MOV _2main__local296, intersect_ball - 8, _2main__size4
MOV _2main__main_res3, _2main__local296, _2main__size4
MOV _2main__local300, _2main__main_res3, _2main__size4
MOV _2main__local303, _2main__main_res1, _2main__size4
LT _2main__local300, _2main__local300, _2main__local303, _2main__size4
MOV _2main__local302, _2main__main_res1, _2main__size4
MOV_CONST 0, _2main__local304
LT _2main__local302, _2main__local302, _2main__local304, _2main__size4
ADD _2main__local300, _2main__local300, _2main__local302, _2main__size4
LEA _2main__local301, _2main__local300
$CLEA _2main__local301, _2main__zero, _2main__local298 
$LEA _2main__zero, _2main__local299 
_2main__local298:
MOV _2main__local307, _2main__main_res3, _2main__size4
MOV_CONST 0, _2main__local309
LT _2main__local307, _2main__local309, _2main__local307, _2main__size4
LEA _2main__local308, _2main__local307
$CLEA _2main__local308, _2main__zero, _2main__local305 
$LEA _2main__zero, _2main__local306 
_2main__local305:
MOV _2main__local310, _2main__main_gx, _2main__size4
MOV fmul - 12, _2main__main_dx, _2main__size4
MOV fmul - 16, _2main__main_res3, _2main__size4
LEA fmul - 4, _2main__local312
$LEA _2main__zero, fmul
_2main__local312:
MOV _2main__local311, fmul - 8, _2main__size4
ADD _2main__local310, _2main__local310, _2main__local311, _2main__size4
MOV _2main__main_px, _2main__local310, _2main__size4
MOV _2main__local313, _2main__main_gy, _2main__size4
MOV fmul - 12, _2main__main_dy, _2main__size4
MOV fmul - 16, _2main__main_res3, _2main__size4
LEA fmul - 4, _2main__local315
$LEA _2main__zero, fmul
_2main__local315:
MOV _2main__local314, fmul - 8, _2main__size4
ADD _2main__local313, _2main__local313, _2main__local314, _2main__size4
MOV _2main__main_py, _2main__local313, _2main__size4
MOV _2main__local316, _2main__main_gz, _2main__size4
MOV fmul - 12, _2main__main_dz, _2main__size4
MOV fmul - 16, _2main__main_res3, _2main__size4
LEA fmul - 4, _2main__local318
$LEA _2main__zero, fmul
_2main__local318:
MOV _2main__local317, fmul - 8, _2main__size4
ADD _2main__local316, _2main__local316, _2main__local317, _2main__size4
MOV _2main__main_pz, _2main__local316, _2main__size4
MOV _2main__local319, _2main__main_px, _2main__size4
MOV_CONST 1500, _2main__local320
SUB _2main__local319, _2main__local319, _2main__local320, _2main__size4
MOV _2main__main_nx, _2main__local319, _2main__size4
MOV _2main__local321, _2main__main_py, _2main__size4
MOV_CONST 700, _2main__local322
SUB _2main__local321, _2main__local321, _2main__local322, _2main__size4
MOV _2main__main_ny, _2main__local321, _2main__size4
MOV _2main__local323, _2main__main_pz, _2main__size4
MOV_CONST 800, _2main__local324
SUB _2main__local323, _2main__local323, _2main__local324, _2main__size4
MOV _2main__main_nz, _2main__local323, _2main__size4
MOV _2main__local325, _2main__main_lx, _2main__size4
MOV _2main__local326, _2main__main_px, _2main__size4
SUB _2main__local325, _2main__local325, _2main__local326, _2main__size4
MOV _2main__main_ldx, _2main__local325, _2main__size4
MOV _2main__local327, _2main__main_ly, _2main__size4
MOV _2main__local328, _2main__main_py, _2main__size4
SUB _2main__local327, _2main__local327, _2main__local328, _2main__size4
MOV _2main__main_ldy, _2main__local327, _2main__size4
MOV _2main__local329, _2main__main_lz, _2main__size4
MOV _2main__local330, _2main__main_pz, _2main__size4
SUB _2main__local329, _2main__local329, _2main__local330, _2main__size4
MOV _2main__main_ldz, _2main__local329, _2main__size4
MOV phong - 12, _2main__main_ldx, _2main__size4
MOV phong - 16, _2main__main_ldy, _2main__size4
MOV phong - 20, _2main__main_ldz, _2main__size4
MOV phong - 24, _2main__main_dx, _2main__size4
MOV phong - 28, _2main__main_dy, _2main__size4
MOV phong - 32, _2main__main_dz, _2main__size4
MOV phong - 36, _2main__main_nx, _2main__size4
MOV phong - 40, _2main__main_ny, _2main__size4
MOV phong - 44, _2main__main_nz, _2main__size4
LEA phong - 4, _2main__local332
$LEA _2main__zero, phong
_2main__local332:
MOV _2main__local331, phong - 8, _2main__size4
MOV _2main__main_spec, _2main__local331, _2main__size4
MOV_CONST 255, _2main__local333
MOV _2main__local335, _2main__main_spec, _2main__size4
MUL _2main__local333, _2main__local333, _2main__local335, _2main__size4
MOV_CONST 1000, _2main__local334
DIV _2main__local333, _2main__local333, _2main__local334, _2main__size4
MOV _2main__main_color, _2main__local333, _2main__size4
MOV put4 - 12, _2main__main_end, _2main__size4
MOV put4 - 16, _2main__main_color, _2main__size4
MOV_CONST 65536, _2main__local337
MOV _2main__local338, _2main__main_color, _2main__size4
MUL _2main__local337, _2main__local337, _2main__local338, _2main__size4
ADD put4 - 16, put4 - 16, _2main__local337, _2main__size4
LEA put4 - 4, _2main__local339
$LEA _2main__zero, put4
_2main__local339:
MOV _2main__local336, put4 - 8, _2main__size4
MOV _2main__main_t, _2main__local336, _2main__size4
_2main__local306:
_2main__local299:
MOV intersect_ball - 12, _2main__main_gx, _2main__size4
MOV intersect_ball - 16, _2main__main_gy, _2main__size4
MOV intersect_ball - 20, _2main__main_gz, _2main__size4
MOV intersect_ball - 24, _2main__main_dx, _2main__size4
MOV intersect_ball - 28, _2main__main_dy, _2main__size4
MOV intersect_ball - 32, _2main__main_dz, _2main__size4
MOV_CONST 2, intersect_ball - 36
MOV _2main__local341, _2main__main_lx, _2main__size4
MUL intersect_ball - 36, intersect_ball - 36, _2main__local341, _2main__size4
MOV_CONST 2, intersect_ball - 40
MOV _2main__local342, _2main__main_ly, _2main__size4
MUL intersect_ball - 40, intersect_ball - 40, _2main__local342, _2main__size4
MOV_CONST 5000, intersect_ball - 44
MOV_CONST 2, _2main__local343
MOV _2main__local344, _2main__main_lz, _2main__size4
MUL _2main__local343, _2main__local343, _2main__local344, _2main__size4
ADD intersect_ball - 44, intersect_ball - 44, _2main__local343, _2main__size4
MOV_CONST 160, intersect_ball - 48
LEA intersect_ball - 4, _2main__local345
$LEA _2main__zero, intersect_ball
_2main__local345:
MOV _2main__local340, intersect_ball - 8, _2main__size4
MOV _2main__main_res2, _2main__local340, _2main__size4
MOV _2main__local348, _2main__main_res2, _2main__size4
MOV _2main__local351, _2main__main_res1, _2main__size4
LT _2main__local348, _2main__local348, _2main__local351, _2main__size4
MOV _2main__local350, _2main__main_res1, _2main__size4
MOV_CONST 0, _2main__local352
LT _2main__local350, _2main__local350, _2main__local352, _2main__size4
ADD _2main__local348, _2main__local348, _2main__local350, _2main__size4
LEA _2main__local349, _2main__local348
$CLEA _2main__local349, _2main__zero, _2main__local346 
$LEA _2main__zero, _2main__local347 
_2main__local346:
MOV _2main__local355, _2main__main_res2, _2main__size4
MOV _2main__local358, _2main__main_res3, _2main__size4
LT _2main__local355, _2main__local355, _2main__local358, _2main__size4
MOV _2main__local357, _2main__main_res3, _2main__size4
MOV_CONST 0, _2main__local359
LT _2main__local357, _2main__local357, _2main__local359, _2main__size4
ADD _2main__local355, _2main__local355, _2main__local357, _2main__size4
LEA _2main__local356, _2main__local355
$CLEA _2main__local356, _2main__zero, _2main__local353 
$LEA _2main__zero, _2main__local354 
_2main__local353:
MOV _2main__local362, _2main__main_res2, _2main__size4
MOV_CONST 0, _2main__local364
LT _2main__local362, _2main__local364, _2main__local362, _2main__size4
LEA _2main__local363, _2main__local362
$CLEA _2main__local363, _2main__zero, _2main__local360 
$LEA _2main__zero, _2main__local361 
_2main__local360:
MOV put4 - 12, _2main__main_end, _2main__size4
MOV_CONST 255, put4 - 16
MOV_CONST 65536, _2main__local366
MUL put4 - 16, put4 - 16, _2main__local366, _2main__size4
LEA put4 - 4, _2main__local367
$LEA _2main__zero, put4
_2main__local367:
MOV _2main__local365, put4 - 8, _2main__size4
MOV _2main__main_t, _2main__local365, _2main__size4
_2main__local361:
_2main__local354:
_2main__local347:
MOV _2main__local368, _2main__main_end, _2main__size4
MOV_CONST 4, _2main__local369
ADD _2main__local368, _2main__local368, _2main__local369, _2main__size4
MOV _2main__main_end, _2main__local368, _2main__size4
MOV _2main__local370, _2main__main_x, _2main__size4
MOV_CONST 1, _2main__local371
ADD _2main__local370, _2main__local370, _2main__local371, _2main__size4
MOV _2main__main_x, _2main__local370, _2main__size4
$LEA _2main__zero, _2main__local238 
_2main__local236:
MOV _2main__local372, _2main__main_y, _2main__size4
MOV_CONST 1, _2main__local373
ADD _2main__local372, _2main__local372, _2main__local373, _2main__size4
MOV _2main__main_y, _2main__local372, _2main__size4
$LEA _2main__zero, _2main__local231 
_2main__local229:
MOV out - 12, _2main__main_start, _2main__size4
MOV out - 16, _2main__main_end, _2main__size4
MOV _2main__local375, _2main__main_start, _2main__size4
SUB out - 16, out - 16, _2main__local375, _2main__size4
LEA out - 4, _2main__local376
$LEA _2main__zero, out
_2main__local376:
MOV _2main__local374, out - 8, _2main__size4
MOV _2main__main_t, _2main__local374, _2main__size4
$LEA _2main__zero, _2main__local140 
_2main__local138:
MOV_CONST 0, main - 8
LEA _2main__local377, _2main__size4
LEA _2main__local378, main - 4
$MOV _2main__zero, _2main__local378, _2main__local377
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
_2main__local26:
.dd 0
_2main__local27:
.dd 0
_2main__local29:
.dd 0
_2main__local35:
.dd 0
_2main__local36:
.dd 0
_2main__local37:
.dd 0
_2main__local38:
.dd 0
_2main__local39:
.dd 0
_2main__local40:
.dd 0
_2main__local42:
.dd 0
_2main__local44:
.dd 0
_2main__phong_diffuse:
.dd 0
_2main__local46:
.dd 0
_2main__local47:
.dd 0
_2main__local49:
.dd 0
_2main__local52:
.dd 0
_2main__local56:
.dd 0
_2main__local57:
.dd 0
_2main__local58:
.dd 0
_2main__local59:
.dd 0
_2main__phong_blink:
.dd 0
_2main__local60:
.dd 0
_2main__local63:
.dd 0
_2main__local64:
.dd 0
_2main__local65:
.dd 0
_2main__local66:
.dd 0
_2main__local67:
.dd 0
_2main__local68:
.dd 0
_2main__local69:
.dd 0
_2main__local70:
.dd 0
_2main__phong_x:
.dd 0
_2main__phong_y:
.dd 0
_2main__phong_z:
.dd 0
_2main__local71:
.dd 0
_2main__local72:
.dd 0
_2main__local73:
.dd 0
_2main__local74:
.dd 0
_2main__local75:
.dd 0
_2main__local76:
.dd 0
_2main__local77:
.dd 0
_2main__local78:
.dd 0
_2main__local80:
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
_2main__local93:
.dd 0
_2main__local95:
.dd 0
_2main__local96:
.dd 0
_2main__local98:
.dd 0
_2main__local103:
.dd 0
_2main__local104:
.dd 0
_2main__local105:
.dd 0
_2main__local106:
.dd 0
_2main__local107:
.dd 0
_2main__local109:
.dd 0
_2main__local111:
.dd 0
_2main__local113:
.dd 0
_2main__phong_ans:
.dd 0
_2main__local115:
.dd 0
_2main__local116:
.dd 0
_2main__local117:
.dd 0
_2main__local120:
.dd 0
_2main__local121:
.dd 0
_2main__local122:
.dd 0
_2main__local123:
.dd 0
_2main__local124:
.dd 0
_2main__local125:
.dd 0
_2main__main_res1:
.dd 0
_2main__main_res2:
.dd 0
_2main__main_res3:
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
_2main__main_ldx:
.dd 0
_2main__main_ldy:
.dd 0
_2main__main_ldz:
.dd 0
_2main__main_tim:
.dd 0
_2main__main_ggdx:
.dd 0
_2main__local126:
.dd 0
_2main__local127:
.dd 0
_2main__local128:
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
_2main__local135:
.dd 0
_2main__local136:
.dd 0
_2main__local137:
.dd 0
_2main__local141:
.dd 0
_2main__local142:
.dd 0
_2main__main_start:
.dd 0
_2main__main_end:
.dd 0
_2main__local143:
.dd 0
_2main__local144:
.dd 0
_2main__local145:
.dd 0
_2main__local146:
.dd 0
_2main__main_k1:
.dd 0
_2main__main_k2:
.dd 0
_2main__main_k3:
.dd 0
_2main__local147:
.dd 0
_2main__local148:
.dd 0
_2main__local149:
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
_2main__local159:
.dd 0
_2main__local161:
.dd 0
_2main__local164:
.dd 0
_2main__local165:
.dd 0
_2main__local167:
.dd 0
_2main__local170:
.dd 0
_2main__local171:
.dd 0
_2main__local173:
.dd 0
_2main__local176:
.dd 0
_2main__local177:
.dd 0
_2main__local179:
.dd 0
_2main__local182:
.dd 0
_2main__local183:
.dd 0
_2main__local185:
.dd 0
_2main__local188:
.dd 0
_2main__local189:
.dd 0
_2main__local191:
.dd 0
_2main__local196:
.dd 0
_2main__local197:
.dd 0
_2main__local198:
.dd 0
_2main__local199:
.dd 0
_2main__local200:
.dd 0
_2main__local201:
.dd 0
_2main__local202:
.dd 0
_2main__local203:
.dd 0
_2main__local204:
.dd 0
_2main__local205:
.dd 0
_2main__local206:
.dd 0
_2main__local207:
.dd 0
_2main__local208:
.dd 0
_2main__local209:
.dd 0
_2main__local210:
.dd 0
_2main__local211:
.dd 0
_2main__local212:
.dd 0
_2main__local213:
.dd 0
_2main__local214:
.dd 0
_2main__local215:
.dd 0
_2main__local216:
.dd 0
_2main__local218:
.dd 0
_2main__local222:
.dd 0
_2main__local224:
.dd 0
_2main__local226:
.dd 0
_2main__local228:
.dd 0
_2main__local232:
.dd 0
_2main__local233:
.dd 0
_2main__local234:
.dd 0
_2main__local235:
.dd 0
_2main__local239:
.dd 0
_2main__local240:
.dd 0
_2main__local241:
.dd 0
_2main__main_a:
.dd 0
_2main__main_b:
.dd 0
_2main__local242:
.dd 0
_2main__local243:
.dd 0
_2main__local244:
.dd 0
_2main__local245:
.dd 0
_2main__local246:
.dd 0
_2main__local247:
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
_2main__main_ldx:
.dd 0
_2main__main_ldy:
.dd 0
_2main__main_ldz:
.dd 0
_2main__local248:
.dd 0
_2main__local249:
.dd 0
_2main__local250:
.dd 0
_2main__local251:
.dd 0
_2main__local252:
.dd 0
_2main__local253:
.dd 0
_2main__local254:
.dd 0
_2main__local255:
.dd 0
_2main__local257:
.dd 0
_2main__local261:
.dd 0
_2main__local262:
.dd 0
_2main__local263:
.dd 0
_2main__local264:
.dd 0
_2main__local265:
.dd 0
_2main__local267:
.dd 0
_2main__local268:
.dd 0
_2main__local270:
.dd 0
_2main__local271:
.dd 0
_2main__local273:
.dd 0
_2main__local274:
.dd 0
_2main__local275:
.dd 0
_2main__local276:
.dd 0
_2main__local277:
.dd 0
_2main__local278:
.dd 0
_2main__local279:
.dd 0
_2main__local280:
.dd 0
_2main__local281:
.dd 0
_2main__local282:
.dd 0
_2main__local283:
.dd 0
_2main__local284:
.dd 0
_2main__main_spec:
.dd 0
_2main__local285:
.dd 0
_2main__main_color:
.dd 0
_2main__local287:
.dd 0
_2main__local288:
.dd 0
_2main__local289:
.dd 0
_2main__local290:
.dd 0
_2main__local291:
.dd 0
_2main__local292:
.dd 0
_2main__local293:
.dd 0
_2main__local294:
.dd 0
_2main__local296:
.dd 0
_2main__local300:
.dd 0
_2main__local301:
.dd 0
_2main__local302:
.dd 0
_2main__local303:
.dd 0
_2main__local304:
.dd 0
_2main__local307:
.dd 0
_2main__local308:
.dd 0
_2main__local309:
.dd 0
_2main__local310:
.dd 0
_2main__local311:
.dd 0
_2main__local313:
.dd 0
_2main__local314:
.dd 0
_2main__local316:
.dd 0
_2main__local317:
.dd 0
_2main__local319:
.dd 0
_2main__local320:
.dd 0
_2main__local321:
.dd 0
_2main__local322:
.dd 0
_2main__local323:
.dd 0
_2main__local324:
.dd 0
_2main__local325:
.dd 0
_2main__local326:
.dd 0
_2main__local327:
.dd 0
_2main__local328:
.dd 0
_2main__local329:
.dd 0
_2main__local330:
.dd 0
_2main__main_spec:
.dd 0
_2main__local331:
.dd 0
_2main__main_color:
.dd 0
_2main__local333:
.dd 0
_2main__local334:
.dd 0
_2main__local335:
.dd 0
_2main__local336:
.dd 0
_2main__local337:
.dd 0
_2main__local338:
.dd 0
_2main__local340:
.dd 0
_2main__local341:
.dd 0
_2main__local342:
.dd 0
_2main__local343:
.dd 0
_2main__local344:
.dd 0
_2main__local348:
.dd 0
_2main__local349:
.dd 0
_2main__local350:
.dd 0
_2main__local351:
.dd 0
_2main__local352:
.dd 0
_2main__local355:
.dd 0
_2main__local356:
.dd 0
_2main__local357:
.dd 0
_2main__local358:
.dd 0
_2main__local359:
.dd 0
_2main__local362:
.dd 0
_2main__local363:
.dd 0
_2main__local364:
.dd 0
_2main__local365:
.dd 0
_2main__local366:
.dd 0
_2main__local368:
.dd 0
_2main__local369:
.dd 0
_2main__local370:
.dd 0
_2main__local371:
.dd 0
_2main__local372:
.dd 0
_2main__local373:
.dd 0
_2main__local374:
.dd 0
_2main__local375:
.dd 0
_2main__local377:
.dd 0
_2main__local378:
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


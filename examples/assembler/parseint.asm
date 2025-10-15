_start:
.dd 0xBEBEBEBE
; return
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
parseint:

; 1. skip spaces
; skip all left spaces
_skipping_first_spaces:
MOV_CONST 32, _tmp1
MOV_CONST 0, _tmp2
LEA _tmp1_ptr, _tmp2
LEA _tmp2_ptr, size1
$MOV _tmp1_ptr, _start, _tmp2_ptr
EQ _tmp3, _tmp1, _tmp2, size4
INV _tmp3, _tmp3, size4
ANY _tmp3, _tmp3, size4
LEA _tmp1_ptr, _tmp3
$CLEA _tmp1_ptr, zero, _end_first_loop
INC _start, _start, size4
$LEA zero, _skipping_first_spaces
_end_first_loop:

; check for sign: +, - or no sign

; so, check first letter:
MOV_CONST 0, _tmp2
LEA _tmp2_ptr, _tmp2
LEA _tmp3_ptr, size1
$MOV _tmp2_ptr, _start, _tmp3_ptr
; check it on '-'
MOV_CONST 45, _tmp1
EQ _tmp1, _tmp1, _tmp2, size4
ALL _tmp1, _tmp1, size4
LEA _tmp1_ptr, _tmp1
$CLEA _tmp1_ptr, zero, _minus
; check it on '+'
MOV_CONST 43, _tmp1
EQ _tmp1, _tmp1, _tmp2, size4
ALL _tmp1, _tmp1, size4
LEA _tmp1_ptr, _tmp1
$CLEA _tmp1_ptr, zero, _plus
; so, there is no sign
$LEA zero, _no_sign

_no_sign:
MOV_CONST 0, _is_negative
$LEA zero, _second_part
_plus:
MOV_CONST 0, _is_negative
ADD _start, _start, size1, size4 ; skip this sign
$LEA zero, _second_part
_minus:
MOV_CONST -1, _is_negative
ADD _start, _start, size1, size4 ; skip this sign
$LEA zero, _second_part

_second_part:
; skip all left spaces
_skipping_second_spaces:
MOV_CONST 32, _tmp1
MOV_CONST 0, _tmp2
LEA _tmp1_ptr, _tmp2
LEA _tmp2_ptr, size1
$MOV _tmp1_ptr, _start, _tmp2_ptr
EQ _tmp3, _tmp1, _tmp2, size4
INV _tmp3, _tmp3, size4
ANY _tmp3, _tmp3, size4
LEA _tmp1_ptr, _tmp3
$CLEA _tmp1_ptr, zero, _end_second_loop
INC _start, _start, size4
$LEA zero, _skipping_second_spaces
_end_second_loop:

; after identifying size of element, parse all numbers, 
; and paste their values to resulting code
; print next number

MOV_CONST 60, _tmp1
OUT 1, _tmp1, size1
OUT 1, _tmp1, size1
OUT 1, _tmp1, size1
; print all line except it:
MOV_CONST 3, _tmp1
LEA _tmp1_ptr, _tmp1
$OUT 1, _start, _tmp1_ptr
MOV_CONST 62, _tmp1
OUT 1, _tmp1, size1
MOV_CONST 10, _tmp1
OUT 1, _tmp1, size1


LEA _tmp2_ptr, parseint - 4
LEA _tmp1_ptr, size4
$MOV zero, _tmp2_ptr, _tmp1_ptr



_is_negative:
.dd 0
_tmp1_ptr:
.dd 0
_tmp2_ptr:
.dd 0
_tmp3_ptr:
.dd 0
_tmp4_ptr:
.dd 0
_tmp1:
.dd 0
_tmp2:
.dd 0
_tmp3:
.dd 0
_tmp4:
.dd 0

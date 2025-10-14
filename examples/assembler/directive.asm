_end:
.dd 0xBEBEBEBE
_start:
.dd 0xBEBEBEBE
; returns
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
compile_directive:

; directive is proved to be nonempty [it have '.']

; skip all left spaces
_skipping_spaces:
MOV_CONST 32, _tmp1
MOV_CONST 0, _tmp2
LEA _tmp1_ptr, _tmp2
LEA _tmp2_ptr, size1
$MOV _tmp1_ptr, _start, _tmp2_ptr
EQ _tmp3, _tmp1, _tmp2, size4
INV _tmp3, _tmp3, size4
ANY _tmp3, _tmp3, size4
LEA _tmp1_ptr, _tmp3
$CLEA _tmp1_ptr, zero, _end_loop
INC _start, _start, size4
$LEA zero, _skipping_spaces
_end_loop:


; select directive:
; .align: UNSUPPORTED
; .db .dw .dd -> ok

; so, check third letter:
MOV_CONST 2, _tmp1
MOV_CONST 0, _tmp2
LEA _tmp2_ptr, _tmp2
LEA _tmp3_ptr, size1
ADD _tmp1_ptr, _start, _tmp1, size4
$MOV _tmp2_ptr, _tmp1_ptr, _tmp3_ptr
; check it on 'b'
MOV_CONST 98, _tmp1
EQ _tmp1, _tmp1, _tmp2, size4
ALL _tmp1, _tmp1, size4
LEA _tmp1_ptr, _tmp1
$CLEA _tmp1_ptr, zero, _byte
; check it on 'w'
MOV_CONST 119, _tmp1
EQ _tmp1, _tmp1, _tmp2, size4
ALL _tmp1, _tmp1, size4
LEA _tmp1_ptr, _tmp1
$CLEA _tmp1_ptr, zero, _word
; check it on 'd'
MOV_CONST 100, _tmp1
EQ _tmp1, _tmp1, _tmp2, size4
ALL _tmp1, _tmp1, size4
LEA _tmp1_ptr, _tmp1
$CLEA _tmp1_ptr, zero, _dword
; else: error
MOV_CONST 69, _tmp1
OUT 2, _tmp1, size1
MOV_CONST 82, _tmp1
OUT 2, _tmp1, size1
OUT 2, _tmp1, size1
MOV_CONST 10, _tmp1
OUT 2, _tmp1, size1
.dd 0xFF



; after identifying size of element, parse all numbers, 
; and paste their values to resulting code

_byte:
MOV_CONST 66, _tmp1
OUT 1, _tmp1, size1
$LEA zero, _return
_word:
MOV_CONST 87, _tmp1
OUT 1, _tmp1, size1
$LEA zero, _return
_dword:
MOV_CONST 68, _tmp1
OUT 1, _tmp1, size1
$LEA zero, _return

_return:

MOV_CONST 68, _tmp1
OUT 1, _tmp1, size1

MOV_CONST 60, _tmp1
OUT 1, _tmp1, size1
; print all line except it:
SUB _tmp1, _end, _start, size4
LEA _tmp1_ptr, _tmp1
$OUT 1, _start, _tmp1_ptr
MOV_CONST 62, _tmp1
OUT 1, _tmp1, size1
MOV_CONST 10, _tmp1
OUT 1, _tmp1, size1

; set NOP as something:
MOV_CONST 0x80, _tmp1
LEA _tmp1_ptr, _tmp1
LEA _tmp2_ptr, size1
$MOV result_end, _tmp1_ptr, _tmp2_ptr
ADD result_end, result_end, size1, size4


LEA parseint - 4, _parseint_ret
$LEA zero, parseint
_parseint_ret:


LEA _tmp2_ptr, compile_directive - 4
LEA _tmp1_ptr, size4
$MOV zero, _tmp2_ptr, _tmp1_ptr

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

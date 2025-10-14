_end:
.dd 0xBEBEBEBE
_start:
.dd 0xBEBEBEBE
; returns
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
compile_command:

; command is proved to be nonempty

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


MOV_CONST 36, _tmp1
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


LEA _tmp2_ptr, compile_command - 4
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

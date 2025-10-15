; input pointer
.dd 0xBEBEBEBE
; return data
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
encode_line:

MOV _start, encode_line - 12, size4
MOV _end, _start, size4
; find end of line
_check:
MOV_CONST 0, _tmp1
LEA _tmp1_ptr, _tmp1
LEA _tmp2_ptr, size1
$MOV _tmp1_ptr, _end, _tmp2_ptr
; if '\n' - end parsing
MOV_CONST 10, _tmp2
EQ _tmp3, _tmp1, _tmp2, size4
ALL _tmp3, _tmp3, size4
LEA _tmp3_ptr, _tmp3
$CLEA _tmp3_ptr, zero, _continue
; if '\0' - return 0
MOV_CONST 0, _tmp2
EQ _tmp3, _tmp1, _tmp2, size4
ALL _tmp3, _tmp3, size4
LEA _tmp3_ptr, _tmp3
$CLEA _tmp3_ptr, zero, _return_1
; else - select next character
INC _end, _end, size4
$LEA zero, _check
_continue:

; now, end - points on \n:
; call process line
MOV process_line - 12, _start, size4
MOV process_line - 16, _end, size4
LEA process_line - 4, _process_ret
$LEA zero, process_line
_process_ret:

; save new value in parameter [strange behaviour]
INC encode_line - 12, _end, size4

$LEA zero, _return_0

_return_0:
; return pointer on next symbol after _end
MOV_CONST 0, encode_line - 8
LEA _tmp2_ptr, encode_line - 4
LEA _tmp1_ptr, size4
$MOV zero, _tmp2_ptr, _tmp1_ptr

_return_1:
; return pointer on next symbol after _end
MOV_CONST -1, encode_line - 8
LEA _tmp2_ptr, encode_line - 4
LEA _tmp1_ptr, size4
$MOV zero, _tmp2_ptr, _tmp1_ptr


_start:
.dd 0
_end:
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

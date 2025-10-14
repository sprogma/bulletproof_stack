_end:
.dd 0xBEBEBEBE
_start:
.dd 0xBEBEBEBE
; ret vals
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
process_line:

; build line:
; 1. if line contains ':' -> this is label
; 2. if line contains '.' -> this is directive, owerwise this is command
MOV_CONST 32, _was_nonspace
MOV _i, _start, size4
_search_loop:
; load char
MOV_CONST 0, _tmp3
LEA _tmp3_ptr, _tmp3
LEA _tmp4_ptr, size1
$MOV _tmp3_ptr, _i, _tmp4_ptr
; if i >= end: no ":" and no "." in line
LT _tmp1, _i, _end, size4
INV _tmp1, _tmp1, size4
LEA _tmp1_ptr, _tmp1
$CLEA _tmp1_ptr, zero, _not_found
; compare char with ':'
MOV_CONST 58, _tmp2
EQ _tmp1, _tmp2, _tmp3, size4
ALL _tmp1, _tmp1, size4
LEA _tmp1_ptr, _tmp1
$CLEA _tmp1_ptr, zero, _found
; compare char with '.'
MOV_CONST 46, _tmp2
EQ _tmp1, _tmp2, _tmp3, size4
ALL _tmp1, _tmp1, size4
LEA _tmp1_ptr, _tmp1
$CLEA _tmp1_ptr, zero, _found_directive
; else - next iteration
OR _was_nonspace, _was_nonspace, _tmp3, size4
INC _i, _i, size4
$LEA zero, _search_loop

_found_directive:
; compile directive
MOV compile_directive - 12, _start, size4
MOV compile_directive - 16, _end, size4
LEA compile_directive - 4, _directive_ret
$LEA zero, compile_directive
_directive_ret:
$LEA zero, _return

_found:
; compile label
MOV compile_label - 12, _start, size4
MOV compile_label - 16, _end, size4
LEA compile_label - 4, _label_ret
$LEA zero, compile_label
_label_ret:
$LEA zero, _return

_not_found:
MOV_CONST 32, _tmp1
EQ _tmp2, _was_nonspace, _tmp1, size4
ALL _tmp2, _tmp2, size4
LEA _tmp2_ptr, _tmp2
; skip empty lines [from only spaces]
$CLEA _tmp2_ptr, zero, _return
; else:
; compile command
MOV compile_command - 12, _start, size4
MOV compile_command - 16, _end, size4
LEA compile_command - 4, _command_ret
$LEA zero, compile_command
_command_ret:
$LEA zero, _return

_return:
; return
LEA _tmp2_ptr, process_line - 4
LEA _tmp1_ptr, size4
$MOV zero, _tmp2_ptr, _tmp1_ptr

_i:
.dd 0
_was_nonspace:
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

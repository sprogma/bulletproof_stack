.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
read_all_file:

MOV input_end, input_base, size4

_read_any:
MOV_CONST 0, _tmp1
IN 1, _tmp1, size1
; 0 if EOF
INV _tmp2, _tmp1, size4
ALL _tmp2, _tmp2, size4
LEA _tmp2_ptr, _tmp2
$CLEA _tmp2_ptr, zero, _end_read
; 59 is code of ';'
MOV_CONST 59, _tmp2
EQ _tmp2, _tmp2, _tmp1, size4
ALL _tmp2, _tmp2, size4
LEA _tmp2_ptr, _tmp2
$CLEA _tmp2_ptr, zero, _read_comment
; else - read next key
$LEA zero, _push_key

; if this is ';' then skip all to EOF or newline
_read_comment:
MOV_CONST 0, _tmp1
IN 1, _tmp1, size1
; 0 if EOF
INV _tmp2, _tmp1, size4
ALL _tmp2, _tmp2, size4
LEA _tmp2_ptr, _tmp2
$CLEA _tmp2_ptr, zero, _end_read
; else if '\n' - return to normal read
MOV_CONST 10, _tmp2
EQ _tmp2, _tmp2, _tmp1, size4
ALL _tmp2, _tmp2, size4
LEA _tmp2_ptr, _tmp2
$CLEA _tmp2_ptr, zero, _push_key
; else - read next key
$LEA zero, _read_comment

_push_key:
; push key to result
LEA _tmp1_ptr, _tmp1
LEA _tmp2_ptr, size1
$MOV input_end, _tmp1_ptr, _tmp2_ptr
ADD input_end, input_end, size1, size4
; next iteration
$LEA zero, _read_any

_end_read:
; push '\n' to result
MOV_CONST 10, _tmp1
LEA _tmp1_ptr, _tmp1
LEA _tmp2_ptr, size1
$MOV input_end, _tmp1_ptr, _tmp2_ptr
ADD input_end, input_end, size1, size4
; return to main
LEA _tmp2_ptr, read_all_file - 4
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

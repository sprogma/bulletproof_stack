.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
main:


MOV result_end, result_base, size4
MOV labels_end, labels_base, size4

; read all file to input_base
LEA read_all_file - 4, _read_all_file_ret_ptr
$LEA zero, read_all_file
_read_all_file_ret_ptr:

; print result
SUB _tmp1, input_end, input_base, size4
LEA _tmp1_ptr, _tmp1
$OUT 1, input_base, _tmp1_ptr

; encode each line
MOV encode_line - 12, input_base, size4
_encoding_loop:
LEA encode_line - 4, _encode_line_ret_ptr
$LEA zero, encode_line
_encode_line_ret_ptr:
LEA _tmp1_ptr, encode_line - 8
$CLEA _tmp1_ptr, zero, _end_encoding
$LEA zero, _encoding_loop

_end_encoding:

; print encoded code
SUB _tmp1, result_end, result_base, size4
LEA _tmp1_ptr, _tmp1
$OUT 2, result_base, _tmp1_ptr


LEA _tmp2_ptr, main - 4
LEA _tmp1_ptr, size4
$MOV zero, _tmp2_ptr, _tmp1_ptr



labels_base:
.dd 0x10000
labels_end:
.dd 0x10000
; label structure:
; struct [layout in bytes]:
;   [3:0]  .dd: offset
;   [7:4]  .dd: name_length
;   [127:8] .db: name
; total: 128 bytes [0x80 bytes]
label_size: ; constant, don't change
.dd 128

result_base:
.dd 0x20000
result_end:
.dd 0

input_base:
.dd 0x30000
input_end:
.dd 0



_tmp1:
.dd 0
_tmp2:
.dd 0
_tmp1_ptr:
.dd 0
_tmp2_ptr:
.dd 0



size8:
.dd 8
size4:
.dd 4
size1:
.dd 1
zero:
.dd 0

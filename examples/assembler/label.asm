_end:
.dd 0xBEBEBEBE
_start:
.dd 0xBEBEBEBE
; returns
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
compile_label:

; lable is proved to be nonempty
; but may be simply ":" - not check this, for now. [UB]

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


; find label length:
MOV _label_end, _start, size4
; while _label_end != ':' && _label_end != ' '
; _label_end++
_find_end:
; read value
MOV_CONST 0, _tmp2
LEA _tmp1_ptr, _tmp2
LEA _tmp2_ptr, size1
$MOV _tmp1_ptr, _label_end, _tmp2_ptr
; if _label_end == ' '
MOV_CONST 32, _tmp1
EQ _tmp3, _tmp1, _tmp2, size4
ALL _tmp3, _tmp3, size4
LEA _tmp1_ptr, _tmp3
$CLEA _tmp1_ptr, zero, _end_find_end
; if _label_end == ':'
MOV_CONST 58, _tmp1
EQ _tmp3, _tmp1, _tmp2, size4
ALL _tmp3, _tmp3, size4
LEA _tmp1_ptr, _tmp3
$CLEA _tmp1_ptr, zero, _end_find_end
; next iteration
INC _label_end, _label_end, size4
$LEA zero, _find_end
_end_find_end:

; now, print result

MOV_CONST 33, _tmp1
OUT 1, _tmp1, size1

MOV_CONST 60, _tmp1
OUT 1, _tmp1, size1
; print all line except it:
SUB _tmp1, _label_end, _start, size4
LEA _tmp1_ptr, _tmp1
$OUT 1, _start, _tmp1_ptr
MOV_CONST 62, _tmp1
OUT 1, _tmp1, size1
MOV_CONST 10, _tmp1
OUT 1, _tmp1, size1

; calculate label name's length:
SUB _this_label_length, _label_end, _start, size4

; search for this label?
MOV _i, labels_base, size4
_search_loop:
; do while _i < labels_end
LT _tmp1, _i, labels_end, size4
INV _tmp1, _tmp1, size4
LEA _tmp1_ptr, _tmp1
$CLEA _tmp1_ptr, zero, _not_found
; if this element equals: found [compare _i and _start, _label_end]
; 1. check if lengths are same:
LEA _tmp1_ptr, _this_label_length
LEA _tmp2_ptr, _tmp2
LEA _tmp3_ptr, size4
ADD _tmp4_ptr, _i, size4, size4
$EQ _tmp2_ptr, _tmp4_ptr, _tmp1_ptr, _tmp3_ptr
INV _tmp2, _tmp2, size4
ANY _tmp2, _tmp2, size4
LEA _tmp2_ptr, _tmp2
$CLEA _tmp2_ptr, zero, _next_iteration
; 2. check if values are same
LEA _tmp2_ptr, _tmp_buffer
LEA _tmp1_ptr, _this_label_length
ADD _tmp3_ptr, _i, size8, size4
$EQ _tmp2_ptr, _tmp3_ptr, _start, _tmp1_ptr
ALL _tmp2, _tmp_buffer, _this_label_length
LEA _tmp2_ptr, _tmp2
$CLEA _tmp2_ptr, zero, _found
; else: next element
_next_iteration:
ADD _i, _i, label_size, size4
$LEA zero, _search_loop



; found label with this name
_found:
MOV_CONST 70, _tmp1
OUT 1, _tmp1, size1
MOV_CONST 10, _tmp1
OUT 1, _tmp1, size1

; ignore label, not add it
LEA _tmp2_ptr, compile_label - 4
LEA _tmp1_ptr, size4
$MOV zero, _tmp2_ptr, _tmp1_ptr



; not found label with this name
_not_found:
MOV_CONST 78, _tmp1
OUT 1, _tmp1, size1

; insert this label to end of labels array
MOV _i, labels_end, size4
ADD labels_end, labels_end, label_size, size4
; set offset:
LEA _tmp1_ptr, result_end
LEA _tmp2_ptr, result_base
LEA _tmp3_ptr, size4
$SUB _i, _tmp1_ptr, _tmp2_ptr, _tmp3_ptr
; set length
LEA _tmp1_ptr, _this_label_length
LEA _tmp2_ptr, size4
ADD _tmp3_ptr, _i, size4, size4
$MOV _tmp3_ptr, _tmp1_ptr, _tmp2_ptr
; copy label value:
LEA _tmp1_ptr, _this_label_length
ADD _tmp2_ptr, _i, size8, size4
$MOV _tmp2_ptr, _start, _tmp1_ptr

MOV_CONST 65, _tmp1
OUT 1, _tmp1, size1
MOV_CONST 10, _tmp1
OUT 1, _tmp1, size1

; return
LEA _tmp2_ptr, compile_label - 4
LEA _tmp1_ptr, size4
$MOV zero, _tmp2_ptr, _tmp1_ptr


_this_label_length:
.dd 0
_i:
.dd 0
_label_end:
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

; 128 bytes gap: to compare name
_tmp_buffer:
.db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

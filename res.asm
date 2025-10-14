
LEA main - 4, end_proc
$LEA __ld_zero, main
end_proc:
; like HLT instruction
.db 0xFF
__ld_zero:
.dd 0
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
main:


MOV result_end, result_base, size4
MOV labels_end, labels_base, size4

; read all file to input_base
LEA read_all_file - 4, _0main__read_all_file_ret_ptr
$LEA zero, read_all_file
_0main__read_all_file_ret_ptr:

; print result
SUB _0main__tmp1, input_end, input_base, size4
LEA _0main__tmp1_ptr, _0main__tmp1
$OUT 1, input_base, _0main__tmp1_ptr

; encode each line
MOV encode_line - 12, input_base, size4
_0main__encoding_loop:
LEA encode_line - 4, _0main__encode_line_ret_ptr
$LEA zero, encode_line
_0main__encode_line_ret_ptr:
LEA _0main__tmp1_ptr, encode_line - 8
$CLEA _0main__tmp1_ptr, zero, _0main__end_encoding
$LEA zero, _0main__encoding_loop

_0main__end_encoding:

; print encoded code
SUB _0main__tmp1, result_end, result_base, size4
LEA _0main__tmp1_ptr, _0main__tmp1
$OUT 2, result_base, _0main__tmp1_ptr


LEA _0main__tmp2_ptr, main - 4
LEA _0main__tmp1_ptr, size4
$MOV zero, _0main__tmp2_ptr, _0main__tmp1_ptr



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



_0main__tmp1:
.dd 0
_0main__tmp2:
.dd 0
_0main__tmp1_ptr:
.dd 0
_0main__tmp2_ptr:
.dd 0



size8:
.dd 8
size4:
.dd 4
size1:
.dd 1
zero:
.dd 0

.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
read_all_file:

MOV input_end, input_base, size4

_1read__read_any:
MOV_CONST 0, _1read__tmp1
IN 1, _1read__tmp1, size1
; 0 if EOF
INV _1read__tmp2, _1read__tmp1, size4
ALL _1read__tmp2, _1read__tmp2, size4
LEA _1read__tmp2_ptr, _1read__tmp2
$CLEA _1read__tmp2_ptr, zero, _1read__end_read
; 59 is code of ';'
MOV_CONST 59, _1read__tmp2
EQ _1read__tmp2, _1read__tmp2, _1read__tmp1, size4
ALL _1read__tmp2, _1read__tmp2, size4
LEA _1read__tmp2_ptr, _1read__tmp2
$CLEA _1read__tmp2_ptr, zero, _1read__read_comment
; else - read next key
$LEA zero, _1read__push_key

; if this is ';' then skip all to EOF or newline
_1read__read_comment:
MOV_CONST 0, _1read__tmp1
IN 1, _1read__tmp1, size1
; 0 if EOF
INV _1read__tmp2, _1read__tmp1, size4
ALL _1read__tmp2, _1read__tmp2, size4
LEA _1read__tmp2_ptr, _1read__tmp2
$CLEA _1read__tmp2_ptr, zero, _1read__end_read
; else if '\n' - return to normal read
MOV_CONST 10, _1read__tmp2
EQ _1read__tmp2, _1read__tmp2, _1read__tmp1, size4
ALL _1read__tmp2, _1read__tmp2, size4
LEA _1read__tmp2_ptr, _1read__tmp2
$CLEA _1read__tmp2_ptr, zero, _1read__push_key
; else - read next key
$LEA zero, _1read__read_comment

_1read__push_key:
; push key to result
LEA _1read__tmp1_ptr, _1read__tmp1
LEA _1read__tmp2_ptr, size1
$MOV input_end, _1read__tmp1_ptr, _1read__tmp2_ptr
ADD input_end, input_end, size1, size4
; next iteration
$LEA zero, _1read__read_any

_1read__end_read:
; push '\n' to result
MOV_CONST 10, _1read__tmp1
LEA _1read__tmp1_ptr, _1read__tmp1
LEA _1read__tmp2_ptr, size1
$MOV input_end, _1read__tmp1_ptr, _1read__tmp2_ptr
ADD input_end, input_end, size1, size4
; return to main
LEA _1read__tmp2_ptr, read_all_file - 4
LEA _1read__tmp1_ptr, size4
$MOV zero, _1read__tmp2_ptr, _1read__tmp1_ptr



_1read__tmp1_ptr:
.dd 0
_1read__tmp2_ptr:
.dd 0
_1read__tmp3_ptr:
.dd 0
_1read__tmp4_ptr:
.dd 0
_1read__tmp1:
.dd 0
_1read__tmp2:
.dd 0
_1read__tmp3:
.dd 0
_1read__tmp4:
.dd 0

; input pointer
.dd 0xBEBEBEBE
; return data
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
encode_line:

MOV _2encode__start, encode_line - 12, size4
MOV _2encode__end, _2encode__start, size4
; find end of line
_2encode__check:
MOV_CONST 0, _2encode__tmp1
LEA _2encode__tmp1_ptr, _2encode__tmp1
LEA _2encode__tmp2_ptr, size1
$MOV _2encode__tmp1_ptr, _2encode__end, _2encode__tmp2_ptr
; if '\n' - end parsing
MOV_CONST 10, _2encode__tmp2
EQ _2encode__tmp3, _2encode__tmp1, _2encode__tmp2, size4
ALL _2encode__tmp3, _2encode__tmp3, size4
LEA _2encode__tmp3_ptr, _2encode__tmp3
$CLEA _2encode__tmp3_ptr, zero, _2encode__continue
; if '\0' - return 0
MOV_CONST 0, _2encode__tmp2
EQ _2encode__tmp3, _2encode__tmp1, _2encode__tmp2, size4
ALL _2encode__tmp3, _2encode__tmp3, size4
LEA _2encode__tmp3_ptr, _2encode__tmp3
$CLEA _2encode__tmp3_ptr, zero, _2encode__return_1
; else - select next character
INC _2encode__end, _2encode__end, size4
$LEA zero, _2encode__check
_2encode__continue:

; now, end - points on \n:
; call process line
MOV process_line - 12, _2encode__start, size4
MOV process_line - 16, _2encode__end, size4
LEA process_line - 4, _2encode__process_ret
$LEA zero, process_line
_2encode__process_ret:

; save new value in parameter [strange behaviour]
INC encode_line - 12, _2encode__end, size4

$LEA zero, _2encode__return_0

_2encode__return_0:
; return pointer on next symbol after _2encode__end
MOV_CONST 0, encode_line - 8
LEA _2encode__tmp2_ptr, encode_line - 4
LEA _2encode__tmp1_ptr, size4
$MOV zero, _2encode__tmp2_ptr, _2encode__tmp1_ptr

_2encode__return_1:
; return pointer on next symbol after _2encode__end
MOV_CONST -1, encode_line - 8
LEA _2encode__tmp2_ptr, encode_line - 4
LEA _2encode__tmp1_ptr, size4
$MOV zero, _2encode__tmp2_ptr, _2encode__tmp1_ptr


_2encode__start:
.dd 0
_2encode__end:
.dd 0



_2encode__tmp1_ptr:
.dd 0
_2encode__tmp2_ptr:
.dd 0
_2encode__tmp3_ptr:
.dd 0
_2encode__tmp4_ptr:
.dd 0
_2encode__tmp1:
.dd 0
_2encode__tmp2:
.dd 0
_2encode__tmp3:
.dd 0
_2encode__tmp4:
.dd 0

_3process__end:
.dd 0xBEBEBEBE
_3process__start:
.dd 0xBEBEBEBE
; ret vals
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
process_line:

; build line:
; 1. if line contains ':' -> this is label
; 2. if line contains '.' -> this is directive, owerwise this is command
MOV_CONST 32, _3process__was_nonspace
MOV _3process__i, _3process__start, size4
_3process__search_loop:
; load char
MOV_CONST 0, _3process__tmp3
LEA _3process__tmp3_ptr, _3process__tmp3
LEA _3process__tmp4_ptr, size1
$MOV _3process__tmp3_ptr, _3process__i, _3process__tmp4_ptr
; if i >= end: no ":" and no "." in line
LT _3process__tmp1, _3process__i, _3process__end, size4
INV _3process__tmp1, _3process__tmp1, size4
LEA _3process__tmp1_ptr, _3process__tmp1
$CLEA _3process__tmp1_ptr, zero, _3process__not_found
; compare char with ':'
MOV_CONST 58, _3process__tmp2
EQ _3process__tmp1, _3process__tmp2, _3process__tmp3, size4
ALL _3process__tmp1, _3process__tmp1, size4
LEA _3process__tmp1_ptr, _3process__tmp1
$CLEA _3process__tmp1_ptr, zero, _3process__found
; compare char with '.'
MOV_CONST 46, _3process__tmp2
EQ _3process__tmp1, _3process__tmp2, _3process__tmp3, size4
ALL _3process__tmp1, _3process__tmp1, size4
LEA _3process__tmp1_ptr, _3process__tmp1
$CLEA _3process__tmp1_ptr, zero, _3process__found_directive
; else - next iteration
OR _3process__was_nonspace, _3process__was_nonspace, _3process__tmp3, size4
INC _3process__i, _3process__i, size4
$LEA zero, _3process__search_loop

_3process__found_directive:
; compile directive
MOV compile_directive - 12, _3process__start, size4
MOV compile_directive - 16, _3process__end, size4
LEA compile_directive - 4, _3process__directive_ret
$LEA zero, compile_directive
_3process__directive_ret:
$LEA zero, _3process__return

_3process__found:
; compile label
MOV compile_label - 12, _3process__start, size4
MOV compile_label - 16, _3process__end, size4
LEA compile_label - 4, _3process__label_ret
$LEA zero, compile_label
_3process__label_ret:
$LEA zero, _3process__return

_3process__not_found:
MOV_CONST 32, _3process__tmp1
EQ _3process__tmp2, _3process__was_nonspace, _3process__tmp1, size4
ALL _3process__tmp2, _3process__tmp2, size4
LEA _3process__tmp2_ptr, _3process__tmp2
; skip empty lines [from only spaces]
$CLEA _3process__tmp2_ptr, zero, _3process__return
; else:
; compile command
MOV compile_command - 12, _3process__start, size4
MOV compile_command - 16, _3process__end, size4
LEA compile_command - 4, _3process__command_ret
$LEA zero, compile_command
_3process__command_ret:
$LEA zero, _3process__return

_3process__return:
; return
LEA _3process__tmp2_ptr, process_line - 4
LEA _3process__tmp1_ptr, size4
$MOV zero, _3process__tmp2_ptr, _3process__tmp1_ptr

_3process__i:
.dd 0
_3process__was_nonspace:
.dd 0

_3process__tmp1_ptr:
.dd 0
_3process__tmp2_ptr:
.dd 0
_3process__tmp3_ptr:
.dd 0
_3process__tmp4_ptr:
.dd 0
_3process__tmp1:
.dd 0
_3process__tmp2:
.dd 0
_3process__tmp3:
.dd 0
_3process__tmp4:
.dd 0

_4label__end:
.dd 0xBEBEBEBE
_4label__start:
.dd 0xBEBEBEBE
; returns
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
compile_label:

; lable is proved to be nonempty
; but may be simply ":" - not check this, for now. [UB]

; skip all left spaces
_4label__skipping_spaces:
MOV_CONST 32, _4label__tmp1
MOV_CONST 0, _4label__tmp2
LEA _4label__tmp1_ptr, _4label__tmp2
LEA _4label__tmp2_ptr, size1
$MOV _4label__tmp1_ptr, _4label__start, _4label__tmp2_ptr
EQ _4label__tmp3, _4label__tmp1, _4label__tmp2, size4
INV _4label__tmp3, _4label__tmp3, size4
ANY _4label__tmp3, _4label__tmp3, size4
LEA _4label__tmp1_ptr, _4label__tmp3
$CLEA _4label__tmp1_ptr, zero, _4label__end_loop
INC _4label__start, _4label__start, size4
$LEA zero, _4label__skipping_spaces
_4label__end_loop:


; find label length:
MOV _4label__label_end, _4label__start, size4
; while _4label__label_end != ':' && _4label__label_end != ' '
; _4label__label_end++
_4label__find_end:
; read value
MOV_CONST 0, _4label__tmp2
LEA _4label__tmp1_ptr, _4label__tmp2
LEA _4label__tmp2_ptr, size1
$MOV _4label__tmp1_ptr, _4label__label_end, _4label__tmp2_ptr
; if _4label__label_end == ' '
MOV_CONST 32, _4label__tmp1
EQ _4label__tmp3, _4label__tmp1, _4label__tmp2, size4
ALL _4label__tmp3, _4label__tmp3, size4
LEA _4label__tmp1_ptr, _4label__tmp3
$CLEA _4label__tmp1_ptr, zero, _4label__end_find_end
; if _4label__label_end == ':'
MOV_CONST 58, _4label__tmp1
EQ _4label__tmp3, _4label__tmp1, _4label__tmp2, size4
ALL _4label__tmp3, _4label__tmp3, size4
LEA _4label__tmp1_ptr, _4label__tmp3
$CLEA _4label__tmp1_ptr, zero, _4label__end_find_end
; next iteration
INC _4label__label_end, _4label__label_end, size4
$LEA zero, _4label__find_end
_4label__end_find_end:

; now, print result

MOV_CONST 33, _4label__tmp1
OUT 1, _4label__tmp1, size1

MOV_CONST 60, _4label__tmp1
OUT 1, _4label__tmp1, size1
; print all line except it:
SUB _4label__tmp1, _4label__label_end, _4label__start, size4
LEA _4label__tmp1_ptr, _4label__tmp1
$OUT 1, _4label__start, _4label__tmp1_ptr
MOV_CONST 62, _4label__tmp1
OUT 1, _4label__tmp1, size1
MOV_CONST 10, _4label__tmp1
OUT 1, _4label__tmp1, size1

; calculate label name's length:
SUB _4label__this_label_length, _4label__label_end, _4label__start, size4

; search for this label?
MOV _4label__i, labels_base, size4
_4label__search_loop:
; do while _4label__i < labels_end
LT _4label__tmp1, _4label__i, labels_end, size4
INV _4label__tmp1, _4label__tmp1, size4
LEA _4label__tmp1_ptr, _4label__tmp1
$CLEA _4label__tmp1_ptr, zero, _4label__not_found
; if this element equals: found [compare _4label__i and _4label__start, _4label__label_end]
; 1. check if lengths are same:
LEA _4label__tmp1_ptr, _4label__this_label_length
LEA _4label__tmp2_ptr, _4label__tmp2
LEA _4label__tmp3_ptr, size4
ADD _4label__tmp4_ptr, _4label__i, size4, size4
$EQ _4label__tmp2_ptr, _4label__tmp4_ptr, _4label__tmp1_ptr, _4label__tmp3_ptr
INV _4label__tmp2, _4label__tmp2, size4
ANY _4label__tmp2, _4label__tmp2, size4
LEA _4label__tmp2_ptr, _4label__tmp2
$CLEA _4label__tmp2_ptr, zero, _4label__next_iteration
; 2. check if values are same
LEA _4label__tmp2_ptr, _4label__tmp_buffer
LEA _4label__tmp1_ptr, _4label__this_label_length
ADD _4label__tmp3_ptr, _4label__i, size8, size4
$EQ _4label__tmp2_ptr, _4label__tmp3_ptr, _4label__start, _4label__tmp1_ptr
ALL _4label__tmp2, _4label__tmp_buffer, _4label__this_label_length
LEA _4label__tmp2_ptr, _4label__tmp2
$CLEA _4label__tmp2_ptr, zero, _4label__found
; else: next element
_4label__next_iteration:
ADD _4label__i, _4label__i, label_size, size4
$LEA zero, _4label__search_loop



; found label with this name
_4label__found:
MOV_CONST 70, _4label__tmp1
OUT 1, _4label__tmp1, size1
MOV_CONST 10, _4label__tmp1
OUT 1, _4label__tmp1, size1

; ignore label, not add it
LEA _4label__tmp2_ptr, compile_label - 4
LEA _4label__tmp1_ptr, size4
$MOV zero, _4label__tmp2_ptr, _4label__tmp1_ptr



; not found label with this name
_4label__not_found:
MOV_CONST 78, _4label__tmp1
OUT 1, _4label__tmp1, size1

; insert this label to end of labels array
MOV _4label__i, labels_end, size4
ADD labels_end, labels_end, label_size, size4
; set offset:
LEA _4label__tmp1_ptr, result_end
LEA _4label__tmp2_ptr, result_base
LEA _4label__tmp3_ptr, size4
$SUB _4label__i, _4label__tmp1_ptr, _4label__tmp2_ptr, _4label__tmp3_ptr
; set length
LEA _4label__tmp1_ptr, _4label__this_label_length
LEA _4label__tmp2_ptr, size4
ADD _4label__tmp3_ptr, _4label__i, size4, size4
$MOV _4label__tmp3_ptr, _4label__tmp1_ptr, _4label__tmp2_ptr
; copy label value:
LEA _4label__tmp1_ptr, _4label__this_label_length
ADD _4label__tmp2_ptr, _4label__i, size8, size4
$MOV _4label__tmp2_ptr, _4label__start, _4label__tmp1_ptr

MOV_CONST 65, _4label__tmp1
OUT 1, _4label__tmp1, size1
MOV_CONST 10, _4label__tmp1
OUT 1, _4label__tmp1, size1

; return
LEA _4label__tmp2_ptr, compile_label - 4
LEA _4label__tmp1_ptr, size4
$MOV zero, _4label__tmp2_ptr, _4label__tmp1_ptr


_4label__this_label_length:
.dd 0
_4label__i:
.dd 0
_4label__label_end:
.dd 0
_4label__tmp1_ptr:
.dd 0
_4label__tmp2_ptr:
.dd 0
_4label__tmp3_ptr:
.dd 0
_4label__tmp4_ptr:
.dd 0
_4label__tmp1:
.dd 0
_4label__tmp2:
.dd 0
_4label__tmp3:
.dd 0
_4label__tmp4:
.dd 0

; 128 bytes gap: to compare name
_4label__tmp_buffer:
.db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

_5command__end:
.dd 0xBEBEBEBE
_5command__start:
.dd 0xBEBEBEBE
; returns
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
compile_command:

; command is proved to be nonempty

; skip all left spaces
_5command__skipping_spaces:
MOV_CONST 32, _5command__tmp1
MOV_CONST 0, _5command__tmp2
LEA _5command__tmp1_ptr, _5command__tmp2
LEA _5command__tmp2_ptr, size1
$MOV _5command__tmp1_ptr, _5command__start, _5command__tmp2_ptr
EQ _5command__tmp3, _5command__tmp1, _5command__tmp2, size4
INV _5command__tmp3, _5command__tmp3, size4
ANY _5command__tmp3, _5command__tmp3, size4
LEA _5command__tmp1_ptr, _5command__tmp3
$CLEA _5command__tmp1_ptr, zero, _5command__end_loop
INC _5command__start, _5command__start, size4
$LEA zero, _5command__skipping_spaces
_5command__end_loop:


MOV_CONST 36, _5command__tmp1
OUT 1, _5command__tmp1, size1

MOV_CONST 60, _5command__tmp1
OUT 1, _5command__tmp1, size1
; print all line except it:
SUB _5command__tmp1, _5command__end, _5command__start, size4
LEA _5command__tmp1_ptr, _5command__tmp1
$OUT 1, _5command__start, _5command__tmp1_ptr
MOV_CONST 62, _5command__tmp1
OUT 1, _5command__tmp1, size1
MOV_CONST 10, _5command__tmp1
OUT 1, _5command__tmp1, size1

; set NOP as something:
MOV_CONST 0x80, _5command__tmp1
LEA _5command__tmp1_ptr, _5command__tmp1
LEA _5command__tmp2_ptr, size1
$MOV result_end, _5command__tmp1_ptr, _5command__tmp2_ptr
ADD result_end, result_end, size1, size4


LEA _5command__tmp2_ptr, compile_command - 4
LEA _5command__tmp1_ptr, size4
$MOV zero, _5command__tmp2_ptr, _5command__tmp1_ptr

_5command__tmp1_ptr:
.dd 0
_5command__tmp2_ptr:
.dd 0
_5command__tmp3_ptr:
.dd 0
_5command__tmp4_ptr:
.dd 0
_5command__tmp1:
.dd 0
_5command__tmp2:
.dd 0
_5command__tmp3:
.dd 0
_5command__tmp4:
.dd 0

_6directive__end:
.dd 0xBEBEBEBE
_6directive__start:
.dd 0xBEBEBEBE
; returns
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
compile_directive:

; directive is proved to be nonempty [it have '.']

; skip all left spaces
_6directive__skipping_spaces:
MOV_CONST 32, _6directive__tmp1
MOV_CONST 0, _6directive__tmp2
LEA _6directive__tmp1_ptr, _6directive__tmp2
LEA _6directive__tmp2_ptr, size1
$MOV _6directive__tmp1_ptr, _6directive__start, _6directive__tmp2_ptr
EQ _6directive__tmp3, _6directive__tmp1, _6directive__tmp2, size4
INV _6directive__tmp3, _6directive__tmp3, size4
ANY _6directive__tmp3, _6directive__tmp3, size4
LEA _6directive__tmp1_ptr, _6directive__tmp3
$CLEA _6directive__tmp1_ptr, zero, _6directive__end_loop
INC _6directive__start, _6directive__start, size4
$LEA zero, _6directive__skipping_spaces
_6directive__end_loop:


MOV_CONST 68, _6directive__tmp1
OUT 1, _6directive__tmp1, size1

MOV_CONST 60, _6directive__tmp1
OUT 1, _6directive__tmp1, size1
; print all line except it:
SUB _6directive__tmp1, _6directive__end, _6directive__start, size4
LEA _6directive__tmp1_ptr, _6directive__tmp1
$OUT 1, _6directive__start, _6directive__tmp1_ptr
MOV_CONST 62, _6directive__tmp1
OUT 1, _6directive__tmp1, size1
MOV_CONST 10, _6directive__tmp1
OUT 1, _6directive__tmp1, size1

; set NOP as something:
MOV_CONST 0x80, _6directive__tmp1
LEA _6directive__tmp1_ptr, _6directive__tmp1
LEA _6directive__tmp2_ptr, size1
$MOV result_end, _6directive__tmp1_ptr, _6directive__tmp2_ptr
ADD result_end, result_end, size1, size4


LEA _6directive__tmp2_ptr, compile_directive - 4
LEA _6directive__tmp1_ptr, size4
$MOV zero, _6directive__tmp2_ptr, _6directive__tmp1_ptr

_6directive__tmp1_ptr:
.dd 0
_6directive__tmp2_ptr:
.dd 0
_6directive__tmp3_ptr:
.dd 0
_6directive__tmp4_ptr:
.dd 0
_6directive__tmp1:
.dd 0
_6directive__tmp2:
.dd 0
_6directive__tmp3:
.dd 0
_6directive__tmp4:
.dd 0



LEA main - 4, end_proc
$LEA __ld_zero, main
end_proc:
; like HLT instruction
.db 0xFF
__ld_zero:
.dd 0
; arguments
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
main:
MOV_CONST 5, _0a__main_x
MOV_CONST 7, _0a__main_y
MOV add - 12, _0a__main_x, _0a__size4
MOV add - 16, _0a__main_y, _0a__size4
LEA add - 4, _0a__local0
$LEA _0a__zero, add
_0a__local0:
MOV main - 8, add - 8, _0a__size4
LEA _0a__local1, _0a__size4
LEA _0a__local2, main - 4
$MOV _0a__zero, _0a__local2, _0a__local1
_0a__main_x:
.dd 0
_0a__main_y:
.dd 0
_0a__local1:
.dd 0
_0a__local2:
.dd 0
_0a__size4:
.dd 4
_0a__size1:
.dd 1
_0a__int_tmp:
.dd 0
_0a__byte_tmp:
.db 0
_0a__zero:
.db 0

; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
add:
MOV add - 8, add - 12, _1b__size4
MOV _1b__local0, add - 16, _1b__size4
ADD add - 8, add - 8, _1b__local0, _1b__size4
LEA _1b__local1, _1b__size4
LEA _1b__local2, add - 4
$MOV _1b__zero, _1b__local2, _1b__local1
_1b__local0:
.dd 0
_1b__local1:
.dd 0
_1b__local2:
.dd 0
_1b__size4:
.dd 4
_1b__size1:
.dd 1
_1b__int_tmp:
.dd 0
_1b__byte_tmp:
.db 0
_1b__zero:
.db 0


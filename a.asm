;a:
;MOV_CONST 12, a
;MOV_CONST 13, a+0
;MOV_CONST 14, a-0
$LEA zero, next
NOP
NOP
next:
$MOV_CONST 0x4000, zero
zero:
.db 0
.db 0
.db 0
.db 0
base:
.db 4
.db 0
.db 0
.db 0
next_abs:
.db 0xBE
.db 0xBE
.db 0xBE
.db 0xBE
base_abs:
.db 0xBE
.db 0xBE
.db 0xBE
.db 0xBE

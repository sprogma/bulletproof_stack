MOV_CONST 10, a
MOV_CONST 1, b
loop:
MUL b, b, a, size4
DEC a, a, size4
LEA l1, tmp
ANY tmp, a, size4
$CLEA l1, zero, loop
OUT 1, b, size4
.db 0xFF

a:
.dd 0
b:
.dd 0
tmp:
.dd 0
l1:
.dd 0
size4:
.dd 4
zero:
.dd 0

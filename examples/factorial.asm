main:
LEA counter_ptr, counter

start:
MUL res, res, counter, base
DEC counter, counter, base
$CLEA counter_ptr, zero, start

OUT 1, counter_ptr, base 
.db 0xFF

counter:
.dd 10
res:
.dd 1
zero:
.dd 0
counter_ptr:
.dd 0
base:
.dd 4

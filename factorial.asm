LEA counter_ptr, counter

start:
MUL res, res, counter, base
DEC counter, counter, base
$CLEA counter_ptr, zero, start

.db 0xFF

counter:
.dd 4
res:
.dd 4
zero:
.dd 0
counter_ptr:
.dd 0
base:
.dd 4

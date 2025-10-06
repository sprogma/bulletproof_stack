; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
add:
MOV add - 8, add - 12, _size4
MOV _local0, add - 16, _size4
ADD add - 8, add - 8, _local0, _size4
LEA _local1, _size4
LEA _local2, add - 4
$MOV _zero, _local2, _local1
_local0:
.dd 0
_local1:
.dd 0
_local2:
.dd 0
_size4:
.dd 4
_size1:
.dd 1
_zero:
.dd 0

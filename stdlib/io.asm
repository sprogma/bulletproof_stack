
; [void=int] put4(int, int) function:
; 
; ptr - pointer to write data
; value - data to write
; 
; writes only 4 byte slices

; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE

put4:

; write data to memory
LEA _size4_ptr, _size4
LEA _value_ptr, put4 - 16
$MOV put4 - 12, _value_ptr, _size4_ptr

; return to caller
LEA _ptr_ptr, put4 - 4
$MOV _zero, _ptr_ptr, _size4_ptr


; [void=int] put1(int, int) function:
; 
; ptr - pointer to write data
; value - data to write
; 
; writes only 1 byte slices

; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE

put1:

; write data to memory
LEA _size1_ptr, _size1
LEA _size4_ptr, _size4
LEA _value_ptr, put1 - 16
$MOV put1 - 12, _value_ptr, _size1_ptr

; return to caller
LEA _ptr_ptr, put1 - 4
$MOV _zero, _ptr_ptr, _size4_ptr


; [void=int] out(int, int) function:
; 
; ptr - pointer to output data
; count - count of data to write
; 
; writes data to first port
;

; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE

out:

; send output data
LEA _ptr_ptr, out - 16
$OUT 1, out - 12, _ptr_ptr

; return to caller
LEA _size4_ptr, _size4
LEA _ptr_ptr, out - 4
$MOV _zero, _ptr_ptr, _size4_ptr

_ptr_ptr:
.dd 0
_value_ptr:
.dd 0
_size4_ptr:
.dd 0
_size1_ptr:
.dd 0


_size4:
.dd 4
_size1:
.dd 4
_zero:
.dd 0

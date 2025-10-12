; arguments
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
main:
MOV _local2, _main_b, _size4
MOV_CONST 1, _local4
EQ _local2, _local2, _local4, _size4
ALL _local2, _local2, _size4
LEA _local3, _local2
$CLEA _local3, _zero, _local0 
MOV _local7, _main_a, _size4
MOV_CONST 26, _local9
EQ _local7, _local7, _local9, _size4
ALL _local7, _local7, _size4
LEA _local8, _local7
$CLEA _local8, _zero, _local5 
$LEA _zero, _local6 
_local5:
MOV_CONST 1, _local10
MOV _main_t, _local10, _size4
_local6:
MOV _local13, _main_a, _size4
MOV_CONST 4, _local15
EQ _local13, _local13, _local15, _size4
ALL _local13, _local13, _size4
LEA _local14, _local13
$CLEA _local14, _zero, _local11 
$LEA _zero, _local12 
_local11:
MOV_CONST 2, _local16
MOV _main_t, _local16, _size4
_local12:
MOV _local19, _main_a, _size4
MOV_CONST 22, _local21
EQ _local19, _local19, _local21, _size4
ALL _local19, _local19, _size4
LEA _local20, _local19
$CLEA _local20, _zero, _local17 
$LEA _zero, _local18 
_local17:
MOV_CONST 3, _local22
MOV _main_t, _local22, _size4
_local18:
MOV _local25, _main_a, _size4
MOV_CONST 7, _local27
EQ _local25, _local25, _local27, _size4
ALL _local25, _local25, _size4
LEA _local26, _local25
$CLEA _local26, _zero, _local23 
$LEA _zero, _local24 
_local23:
MOV_CONST 4, _local28
MOV _main_t, _local28, _size4
_local24:
MOV _local31, _main_a, _size4
MOV_CONST 44, _local33
EQ _local31, _local31, _local33, _size4
ALL _local31, _local31, _size4
LEA _local32, _local31
$CLEA _local32, _zero, _local29 
$LEA _zero, _local30 
_local29:
MOV_CONST -1, _local34
MOV _main_t, _local34, _size4
_local30:
$LEA _zero, _local1 
_local0:
MOV _local37, _main_a, _size4
MOV_CONST 26, _local39
EQ _local37, _local37, _local39, _size4
ALL _local37, _local37, _size4
LEA _local38, _local37
$CLEA _local38, _zero, _local35 
$LEA _zero, _local36 
_local35:
MOV_CONST 1, _local40
MOV _main_t, _local40, _size4
_local36:
MOV _local43, _main_a, _size4
MOV_CONST 4, _local45
EQ _local43, _local43, _local45, _size4
ALL _local43, _local43, _size4
LEA _local44, _local43
$CLEA _local44, _zero, _local41 
$LEA _zero, _local42 
_local41:
MOV_CONST 2, _local46
MOV _main_t, _local46, _size4
_local42:
MOV _local49, _main_a, _size4
MOV_CONST 22, _local51
EQ _local49, _local49, _local51, _size4
ALL _local49, _local49, _size4
LEA _local50, _local49
$CLEA _local50, _zero, _local47 
$LEA _zero, _local48 
_local47:
MOV_CONST 3, _local52
MOV _main_t, _local52, _size4
_local48:
MOV _local55, _main_a, _size4
MOV_CONST 7, _local57
EQ _local55, _local55, _local57, _size4
ALL _local55, _local55, _size4
LEA _local56, _local55
$CLEA _local56, _zero, _local53 
$LEA _zero, _local54 
_local53:
MOV_CONST 4, _local58
MOV _main_t, _local58, _size4
_local54:
MOV _local61, _main_a, _size4
MOV_CONST 44, _local63
EQ _local61, _local61, _local63, _size4
ALL _local61, _local61, _size4
LEA _local62, _local61
$CLEA _local62, _zero, _local59 
$LEA _zero, _local60 
_local59:
MOV_CONST -1, _local64
MOV _main_t, _local64, _size4
_local60:
_local1:
_main_a:
.dd 0
_main_b:
.dd 0
_main_t:
.dd 0
_local2:
.dd 0
_local3:
.dd 0
_local4:
.dd 0
_local7:
.dd 0
_local8:
.dd 0
_local9:
.dd 0
_local10:
.dd 0
_local13:
.dd 0
_local14:
.dd 0
_local15:
.dd 0
_local16:
.dd 0
_local19:
.dd 0
_local20:
.dd 0
_local21:
.dd 0
_local22:
.dd 0
_local25:
.dd 0
_local26:
.dd 0
_local27:
.dd 0
_local28:
.dd 0
_local31:
.dd 0
_local32:
.dd 0
_local33:
.dd 0
_local34:
.dd 0
_local37:
.dd 0
_local38:
.dd 0
_local39:
.dd 0
_local40:
.dd 0
_local43:
.dd 0
_local44:
.dd 0
_local45:
.dd 0
_local46:
.dd 0
_local49:
.dd 0
_local50:
.dd 0
_local51:
.dd 0
_local52:
.dd 0
_local55:
.dd 0
_local56:
.dd 0
_local57:
.dd 0
_local58:
.dd 0
_local61:
.dd 0
_local62:
.dd 0
_local63:
.dd 0
_local64:
.dd 0
_size4:
.dd 4
_size1:
.dd 1
_zero:
.dd 0

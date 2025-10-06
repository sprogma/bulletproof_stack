LEA _aa0_a_ptr, _aa0_a
LEA _size4_ptr, _size4
$LEA _zero, main
_aa0_a_ptr:
.dd 0
_size4_ptr:
.dd 0
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
aa0:
MOV _local2, _aa0_s, _size4
MOV_CONST 0, _local4
EQ _local2, _local2, _local4, _size4
ALL _local2, _local2, _size4
LEA _local3, _local2
$CLEA _local3, _zero, _local0 
$LEA _zero, _local1 
_local0:
MOV_CONST 20480, _aa0_s
_local1:
MOV _aa0_e, _aa0_s, _size4
MOV_CONST 88200, _local5
ADD _aa0_e, _aa0_e, _local5, _size4
LEA _local10, _local9
_local8:
MOV _local9, _aa0_s, _size4
MOV _local11, _aa0_e, _size4
EQ _local9, _local9, _local11, _size4
ALL _local9, _local9, _size4
INV _local9, _local9, _size4
$CLEA _local10, _zero, _local7 
$LEA _zero, _local6
_local7:
MOV _aa0_a, _aa0_a, _size4
MOV_CONST 7809, _local12
ADD _aa0_a, _aa0_a, _local12, _size4
$MOV _aa0_s, _aa0_a_ptr, _size4_ptr
MOV _aa0_s, _aa0_s, _size4
MOV_CONST 4, _local13
ADD _aa0_s, _aa0_s, _local13, _size4
$LEA _zero, _local8 
_local6:
MOV_CONST 0, aa0 - 8
LEA _size4_ptr, _size4
LEA _local14, aa0 - 4
$MOV _zero, _local14, _size4_ptr
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
aa1:
MOV _local17, _aa0_s, _size4
MOV_CONST 0, _local19
EQ _local17, _local17, _local19, _size4
ALL _local17, _local17, _size4
LEA _local18, _local17
$CLEA _local18, _zero, _local15 
$LEA _zero, _local16 
_local15:
MOV_CONST 20480, _aa0_s
_local16:
MOV _aa1_e, _aa0_s, _size4
MOV_CONST 88200, _local20
ADD _aa1_e, _aa1_e, _local20, _size4
LEA _local25, _local24
_local23:
MOV _local24, _aa0_s, _size4
MOV _local26, _aa1_e, _size4
EQ _local24, _local24, _local26, _size4
ALL _local24, _local24, _size4
INV _local24, _local24, _size4
$CLEA _local25, _zero, _local22 
$LEA _zero, _local21
_local22:
MOV _aa0_a, _aa0_a, _size4
MOV_CONST 12809, _local27
ADD _aa0_a, _aa0_a, _local27, _size4
$MOV _aa0_s, _aa0_a_ptr, _size4_ptr
MOV _aa0_s, _aa0_s, _size4
MOV_CONST 4, _local28
ADD _aa0_s, _aa0_s, _local28, _size4
$LEA _zero, _local23 
_local21:
MOV_CONST 0, aa1 - 8
LEA _size4_ptr, _size4
LEA _local29, aa1 - 4
$MOV _zero, _local29, _size4_ptr
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
aa2:
MOV _local32, _aa0_s, _size4
MOV_CONST 0, _local34
EQ _local32, _local32, _local34, _size4
ALL _local32, _local32, _size4
LEA _local33, _local32
$CLEA _local33, _zero, _local30 
$LEA _zero, _local31 
_local30:
MOV_CONST 20480, _aa0_s
_local31:
MOV _aa2_e, _aa0_s, _size4
MOV_CONST 88200, _local35
ADD _aa2_e, _aa2_e, _local35, _size4
LEA _local40, _local39
_local38:
MOV _local39, _aa0_s, _size4
MOV _local41, _aa2_e, _size4
EQ _local39, _local39, _local41, _size4
ALL _local39, _local39, _size4
INV _local39, _local39, _size4
$CLEA _local40, _zero, _local37 
$LEA _zero, _local36
_local37:
MOV _aa0_a, _aa0_a, _size4
MOV_CONST 19809, _local42
ADD _aa0_a, _aa0_a, _local42, _size4
$MOV _aa0_s, _aa0_a_ptr, _size4_ptr
MOV _aa0_s, _aa0_s, _size4
MOV_CONST 4, _local43
ADD _aa0_s, _aa0_s, _local43, _size4
$LEA _zero, _local38 
_local36:
MOV_CONST 0, aa2 - 8
LEA _size4_ptr, _size4
LEA _local44, aa2 - 4
$MOV _zero, _local44, _size4_ptr
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
main:
LEA aa2 - 4, _local45
$LEA _zero, aa2
_local45:
MOV _main_x, aa2 - 8, _size4
LEA aa0 - 4, _local46
$LEA _zero, aa0
_local46:
MOV _main_x, aa0 - 8, _size4
LEA aa2 - 4, _local47
$LEA _zero, aa2
_local47:
MOV _main_x, aa2 - 8, _size4
LEA aa0 - 4, _local48
$LEA _zero, aa0
_local48:
MOV _main_x, aa0 - 8, _size4
LEA aa2 - 4, _local49
$LEA _zero, aa2
_local49:
MOV _main_x, aa2 - 8, _size4
LEA aa1 - 4, _local50
$LEA _zero, aa1
_local50:
MOV _main_x, aa1 - 8, _size4
LEA aa1 - 4, _local51
$LEA _zero, aa1
_local51:
MOV _main_x, aa1 - 8, _size4
LEA aa1 - 4, _local52
$LEA _zero, aa1
_local52:
MOV _main_x, aa1 - 8, _size4
LEA aa0 - 4, _local53
$LEA _zero, aa0
_local53:
MOV _main_x, aa0 - 8, _size4
LEA aa1 - 4, _local54
$LEA _zero, aa1
_local54:
MOV _main_x, aa1 - 8, _size4
LEA aa0 - 4, _local55
$LEA _zero, aa0
_local55:
MOV _main_x, aa0 - 8, _size4
LEA aa1 - 4, _local56
$LEA _zero, aa1
_local56:
MOV _main_x, aa1 - 8, _size4
LEA aa2 - 4, _local57
$LEA _zero, aa2
_local57:
MOV _main_x, aa2 - 8, _size4
LEA aa2 - 4, _local58
$LEA _zero, aa2
_local58:
MOV _main_x, aa2 - 8, _size4
LEA aa2 - 4, _local59
$LEA _zero, aa2
_local59:
MOV _main_x, aa2 - 8, _size4
LEA aa0 - 4, _local60
$LEA _zero, aa0
_local60:
MOV _main_x, aa0 - 8, _size4
LEA aa2 - 4, _local61
$LEA _zero, aa2
_local61:
MOV _main_x, aa2 - 8, _size4
LEA aa0 - 4, _local62
$LEA _zero, aa0
_local62:
MOV _main_x, aa0 - 8, _size4
LEA aa2 - 4, _local63
$LEA _zero, aa2
_local63:
MOV _main_x, aa2 - 8, _size4
LEA aa1 - 4, _local64
$LEA _zero, aa1
_local64:
MOV _main_x, aa1 - 8, _size4
LEA aa1 - 4, _local65
$LEA _zero, aa1
_local65:
MOV _main_x, aa1 - 8, _size4
LEA aa1 - 4, _local66
$LEA _zero, aa1
_local66:
MOV _main_x, aa1 - 8, _size4
LEA aa0 - 4, _local67
$LEA _zero, aa0
_local67:
MOV _main_x, aa0 - 8, _size4
LEA aa1 - 4, _local68
$LEA _zero, aa1
_local68:
MOV _main_x, aa1 - 8, _size4
LEA aa0 - 4, _local69
$LEA _zero, aa0
_local69:
MOV _main_x, aa0 - 8, _size4
LEA aa1 - 4, _local70
$LEA _zero, aa1
_local70:
MOV _main_x, aa1 - 8, _size4
LEA aa2 - 4, _local71
$LEA _zero, aa2
_local71:
MOV _main_x, aa2 - 8, _size4


MOV_CONST 20480, _aa0_s
OUT 1, _aa0_s, count


this:
$LEA _zero, this


.db 0xFF

count:
.dd 2381400
_aa0_e:
.dd 0
_aa0_s:
.dd 0
_aa0_a:
.dd 0
_local2:
.dd 0
_local3:
.dd 0
_local4:
.dd 0
_local5:
.dd 0
_local9:
.dd 0
_local10:
.dd 0
_local11:
.dd 0
_local12:
.dd 0
_local13:
.dd 0
_local14:
.dd 0
_aa1_e:
.dd 0
_local17:
.dd 0
_local18:
.dd 0
_local19:
.dd 0
_local20:
.dd 0
_local24:
.dd 0
_local25:
.dd 0
_local26:
.dd 0
_local27:
.dd 0
_local28:
.dd 0
_local29:
.dd 0
_aa2_e:
.dd 0
_local32:
.dd 0
_local33:
.dd 0
_local34:
.dd 0
_local35:
.dd 0
_local39:
.dd 0
_local40:
.dd 0
_local41:
.dd 0
_local42:
.dd 0
_local43:
.dd 0
_local44:
.dd 0
_main_x:
.dd 0
_size4:
.dd 4
_size1:
.dd 1
_int_tmp:
.dd 0
_byte_tmp:
.db 0
_zero:
.db 0


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
MOV_CONST 19478309, _local12
ADD _aa0_a, _aa0_a, _local12, _size4
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
MOV _local17, _aa1_s, _size4
MOV_CONST 0, _local19
EQ _local17, _local17, _local19, _size4
ALL _local17, _local17, _size4
LEA _local18, _local17
$CLEA _local18, _zero, _local15 
$LEA _zero, _local16 
_local15:
MOV_CONST 20480, _aa1_s
_local16:
MOV _aa1_e, _aa1_s, _size4
MOV_CONST 88200, _local20
ADD _aa1_e, _aa1_e, _local20, _size4
LEA _local25, _local24
_local23:
MOV _local24, _aa1_s, _size4
MOV _local26, _aa1_e, _size4
EQ _local24, _local24, _local26, _size4
ALL _local24, _local24, _size4
INV _local24, _local24, _size4
$CLEA _local25, _zero, _local22 
$LEA _zero, _local21
_local22:
MOV _aa1_a, _aa1_a, _size4
MOV_CONST 29478309, _local27
ADD _aa1_a, _aa1_a, _local27, _size4
MOV _aa1_s, _aa1_s, _size4
MOV_CONST 4, _local28
ADD _aa1_s, _aa1_s, _local28, _size4
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
MOV _local32, _aa2_s, _size4
MOV_CONST 0, _local34
EQ _local32, _local32, _local34, _size4
ALL _local32, _local32, _size4
LEA _local33, _local32
$CLEA _local33, _zero, _local30 
$LEA _zero, _local31 
_local30:
MOV_CONST 20480, _aa2_s
_local31:
MOV _aa2_e, _aa2_s, _size4
MOV_CONST 88200, _local35
ADD _aa2_e, _aa2_e, _local35, _size4
LEA _local40, _local39
_local38:
MOV _local39, _aa2_s, _size4
MOV _local41, _aa2_e, _size4
EQ _local39, _local39, _local41, _size4
ALL _local39, _local39, _size4
INV _local39, _local39, _size4
$CLEA _local40, _zero, _local37 
$LEA _zero, _local36
_local37:
MOV _aa2_a, _aa2_a, _size4
MOV_CONST 12368709, _local42
ADD _aa2_a, _aa2_a, _local42, _size4
MOV _aa2_s, _aa2_s, _size4
MOV_CONST 4, _local43
ADD _aa2_s, _aa2_s, _local43, _size4
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
aa3:
MOV _local47, _aa3_s, _size4
MOV_CONST 0, _local49
EQ _local47, _local47, _local49, _size4
ALL _local47, _local47, _size4
LEA _local48, _local47
$CLEA _local48, _zero, _local45 
$LEA _zero, _local46 
_local45:
MOV_CONST 20480, _aa3_s
_local46:
MOV _aa3_e, _aa3_s, _size4
MOV_CONST 88200, _local50
ADD _aa3_e, _aa3_e, _local50, _size4
LEA _local55, _local54
_local53:
MOV _local54, _aa3_s, _size4
MOV _local56, _aa3_e, _size4
EQ _local54, _local54, _local56, _size4
ALL _local54, _local54, _size4
INV _local54, _local54, _size4
$CLEA _local55, _zero, _local52 
$LEA _zero, _local51
_local52:
MOV_CONST 0, _aa3_a
MOV _aa3_s, _aa3_s, _size4
MOV_CONST 4, _local57
ADD _aa3_s, _aa3_s, _local57, _size4
$LEA _zero, _local53 
_local51:
MOV_CONST 0, aa3 - 8
LEA _size4_ptr, _size4
LEA _local58, aa3 - 4
$MOV _zero, _local58, _size4_ptr
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
aa4:
MOV _local61, _aa4_s, _size4
MOV_CONST 0, _local63
EQ _local61, _local61, _local63, _size4
ALL _local61, _local61, _size4
LEA _local62, _local61
$CLEA _local62, _zero, _local59 
$LEA _zero, _local60 
_local59:
MOV_CONST 20480, _aa4_s
_local60:
MOV _aa4_e, _aa4_s, _size4
MOV_CONST 88200, _local64
ADD _aa4_e, _aa4_e, _local64, _size4
LEA _local69, _local68
_local67:
MOV _local68, _aa4_s, _size4
MOV _local70, _aa4_e, _size4
EQ _local68, _local68, _local70, _size4
ALL _local68, _local68, _size4
INV _local68, _local68, _size4
$CLEA _local69, _zero, _local66 
$LEA _zero, _local65
_local66:
MOV_CONST 0, _aa4_a
MOV _aa4_s, _aa4_s, _size4
MOV_CONST 4, _local71
ADD _aa4_s, _aa4_s, _local71, _size4
$LEA _zero, _local67 
_local65:
MOV_CONST 0, aa4 - 8
LEA _size4_ptr, _size4
LEA _local72, aa4 - 4
$MOV _zero, _local72, _size4_ptr
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
aa5:
MOV _local75, _aa5_s, _size4
MOV_CONST 0, _local77
EQ _local75, _local75, _local77, _size4
ALL _local75, _local75, _size4
LEA _local76, _local75
$CLEA _local76, _zero, _local73 
$LEA _zero, _local74 
_local73:
MOV_CONST 20480, _aa5_s
_local74:
MOV _aa5_e, _aa5_s, _size4
MOV_CONST 88200, _local78
ADD _aa5_e, _aa5_e, _local78, _size4
LEA _local83, _local82
_local81:
MOV _local82, _aa5_s, _size4
MOV _local84, _aa5_e, _size4
EQ _local82, _local82, _local84, _size4
ALL _local82, _local82, _size4
INV _local82, _local82, _size4
$CLEA _local83, _zero, _local80 
$LEA _zero, _local79
_local80:
MOV_CONST 0, _aa5_a
MOV _aa5_s, _aa5_s, _size4
MOV_CONST 4, _local85
ADD _aa5_s, _aa5_s, _local85, _size4
$LEA _zero, _local81 
_local79:
MOV_CONST 0, aa5 - 8
LEA _size4_ptr, _size4
LEA _local86, aa5 - 4
$MOV _zero, _local86, _size4_ptr
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE


main:
LEA aa1 - 4, _local87
$LEA _zero, aa1
_local87:
MOV _main_x, aa1 - 8, _size4
LEA aa1 - 4, _local88
$LEA _zero, aa1
_local88:
MOV _main_x, aa1 - 8, _size4
LEA aa3 - 4, _local89
$LEA _zero, aa3
_local89:
MOV _main_x, aa3 - 8, _size4
LEA aa1 - 4, _local90
$LEA _zero, aa1
_local90:
MOV _main_x, aa1 - 8, _size4
LEA aa1 - 4, _local91
$LEA _zero, aa1
_local91:
MOV _main_x, aa1 - 8, _size4
LEA aa3 - 4, _local92
$LEA _zero, aa3
_local92:
MOV _main_x, aa3 - 8, _size4
LEA aa1 - 4, _local93
$LEA _zero, aa1
_local93:
MOV _main_x, aa1 - 8, _size4
LEA aa1 - 4, _local94
$LEA _zero, aa1
_local94:
MOV _main_x, aa1 - 8, _size4
LEA aa3 - 4, _local95
$LEA _zero, aa3
_local95:
MOV _main_x, aa3 - 8, _size4
LEA aa0 - 4, _local96
$LEA _zero, aa0
_local96:
MOV _main_x, aa0 - 8, _size4
LEA aa0 - 4, _local97
$LEA _zero, aa0
_local97:
MOV _main_x, aa0 - 8, _size4
LEA aa2 - 4, _local98
$LEA _zero, aa2
_local98:
MOV _main_x, aa2 - 8, _size4
LEA aa1 - 4, _local99
$LEA _zero, aa1
_local99:
MOV _main_x, aa1 - 8, _size4
LEA aa1 - 4, _local100
$LEA _zero, aa1
_local100:
MOV _main_x, aa1 - 8, _size4
LEA aa3 - 4, _local101
$LEA _zero, aa3
_local101:
MOV _main_x, aa3 - 8, _size4
LEA aa0 - 4, _local102
$LEA _zero, aa0
_local102:
MOV _main_x, aa0 - 8, _size4
LEA aa0 - 4, _local103
$LEA _zero, aa0
_local103:
MOV _main_x, aa0 - 8, _size4
LEA aa2 - 4, _local104
$LEA _zero, aa2
_local104:
MOV _main_x, aa2 - 8, _size4
LEA aa1 - 4, _local105
$LEA _zero, aa1
_local105:
MOV _main_x, aa1 - 8, _size4
LEA aa1 - 4, _local106
$LEA _zero, aa1
_local106:
MOV _main_x, aa1 - 8, _size4
LEA aa3 - 4, _local107
$LEA _zero, aa3
_local107:
MOV _main_x, aa3 - 8, _size4
LEA aa4 - 4, _local108
$LEA _zero, aa4
_local108:
MOV _main_x, aa4 - 8, _size4
LEA aa4 - 4, _local109
$LEA _zero, aa4
_local109:
MOV _main_x, aa4 - 8, _size4
LEA aa3 - 4, _local110
$LEA _zero, aa3
_local110:
MOV _main_x, aa3 - 8, _size4
LEA aa4 - 4, _local111
$LEA _zero, aa4
_local111:
MOV _main_x, aa4 - 8, _size4
LEA aa4 - 4, _local112
$LEA _zero, aa4
_local112:
MOV _main_x, aa4 - 8, _size4
LEA aa3 - 4, _local113
$LEA _zero, aa3
_local113:
MOV _main_x, aa3 - 8, _size4
LEA aa4 - 4, _local114
$LEA _zero, aa4
_local114:
MOV _main_x, aa4 - 8, _size4
LEA aa4 - 4, _local115
$LEA _zero, aa4
_local115:
MOV _main_x, aa4 - 8, _size4
LEA aa3 - 4, _local116
$LEA _zero, aa3
_local116:
MOV _main_x, aa3 - 8, _size4
LEA aa5 - 4, _local117
$LEA _zero, aa5
_local117:
MOV _main_x, aa5 - 8, _size4
LEA aa5 - 4, _local118
$LEA _zero, aa5
_local118:
MOV _main_x, aa5 - 8, _size4
LEA aa4 - 4, _local119
$LEA _zero, aa4
_local119:
MOV _main_x, aa4 - 8, _size4
LEA aa2 - 4, _local120
$LEA _zero, aa2
_local120:
MOV _main_x, aa2 - 8, _size4
LEA aa2 - 4, _local121
$LEA _zero, aa2
_local121:
MOV _main_x, aa2 - 8, _size4
LEA aa3 - 4, _local122
$LEA _zero, aa3
_local122:
MOV _main_x, aa3 - 8, _size4
LEA aa0 - 4, _local123
$LEA _zero, aa0
_local123:
MOV _main_x, aa0 - 8, _size4
LEA aa0 - 4, _local124
$LEA _zero, aa0
_local124:
MOV _main_x, aa0 - 8, _size4
LEA aa2 - 4, _local125
$LEA _zero, aa2
_local125:
MOV _main_x, aa2 - 8, _size4
LEA aa1 - 4, _local126
$LEA _zero, aa1
_local126:
MOV _main_x, aa1 - 8, _size4
LEA aa1 - 4, _local127
$LEA _zero, aa1
_local127:
MOV _main_x, aa1 - 8, _size4
LEA aa3 - 4, _local128
$LEA _zero, aa3
_local128:
MOV _main_x, aa3 - 8, _size4
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
_aa1_s:
.dd 0
_aa1_a:
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
_aa2_s:
.dd 0
_aa2_a:
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
_aa3_e:
.dd 0
_aa3_s:
.dd 0
_aa3_a:
.dd 0
_local47:
.dd 0
_local48:
.dd 0
_local49:
.dd 0
_local50:
.dd 0
_local54:
.dd 0
_local55:
.dd 0
_local56:
.dd 0
_local57:
.dd 0
_local58:
.dd 0
_aa4_e:
.dd 0
_aa4_s:
.dd 0
_aa4_a:
.dd 0
_local61:
.dd 0
_local62:
.dd 0
_local63:
.dd 0
_local64:
.dd 0
_local68:
.dd 0
_local69:
.dd 0
_local70:
.dd 0
_local71:
.dd 0
_local72:
.dd 0
_aa5_e:
.dd 0
_aa5_s:
.dd 0
_aa5_a:
.dd 0
_local75:
.dd 0
_local76:
.dd 0
_local77:
.dd 0
_local78:
.dd 0
_local82:
.dd 0
_local83:
.dd 0
_local84:
.dd 0
_local85:
.dd 0
_local86:
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

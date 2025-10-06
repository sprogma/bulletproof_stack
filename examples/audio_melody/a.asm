LEA _aa0_a_ptr, _aa0_a
LEA _size4_ptr, _size4
$LEA _zero, main

.align 4
_aa0_a_ptr:
.dd 0
_size4_ptr:
.dd 0
.align 4
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
MOV_CONST 44100, _local5
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
.align 4
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
MOV_CONST 44100, _local20
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
MOV_CONST 29478309, _local27
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
.align 4
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
MOV_CONST 44100, _local35
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
MOV_CONST 39478309, _local42
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
aa3:
MOV _local32, _aa0_s, _size4
MOV_CONST 0, _local34
EQ _local32, _local32, _local34, _size4
ALL _local32, _local32, _size4
LEA _local33, _local32
$CLEA _local33, _zero, _local_aa3_30 
$LEA _zero, _local_aa3_31 
_local_aa3_30:
MOV_CONST 20480, _aa0_s
_local_aa3_31:
MOV _aa2_e, _aa0_s, _size4
MOV_CONST 44100, _local35
ADD _aa2_e, _aa2_e, _local35, _size4
LEA _local40, _local39
_local_aa3_38:
MOV _local39, _aa0_s, _size4
MOV _local41, _aa2_e, _size4
EQ _local39, _local39, _local41, _size4
ALL _local39, _local39, _size4
INV _local39, _local39, _size4
$CLEA _local40, _zero, _local_aa3_37 
$LEA _zero, _local_aa3_36
_local_aa3_37:
MOV _aa0_a, _aa0_a, _size4
MOV_CONST 0, _local42
ADD _aa0_a, _aa0_a, _local42, _size4
$MOV _aa0_s, _aa0_a_ptr, _size4_ptr
MOV _aa0_s, _aa0_s, _size4
MOV_CONST 4, _local43
ADD _aa0_s, _aa0_s, _local43, _size4
$LEA _zero, _local_aa3_38 
_local_aa3_36:
MOV_CONST 0, aa3 - 8
LEA _size4_ptr, _size4
LEA _local44, aa3 - 4
$MOV _zero, _local44, _size4_ptr

.align 4
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
aa4:
MOV _local32, _aa0_s, _size4
MOV_CONST 0, _local34
EQ _local32, _local32, _local34, _size4
ALL _local32, _local32, _size4
LEA _local33, _local32
$CLEA _local33, _zero, _local_aa4_30 
$LEA _zero, _local_aa4_31 
_local_aa4_30:
MOV_CONST 20480, _aa0_s
_local_aa4_31:
MOV _aa2_e, _aa0_s, _size4
MOV_CONST 44100, _local35
ADD _aa2_e, _aa2_e, _local35, _size4
LEA _local40, _local39
_local_aa4_38:
MOV _local39, _aa0_s, _size4
MOV _local41, _aa2_e, _size4
EQ _local39, _local39, _local41, _size4
ALL _local39, _local39, _size4
INV _local39, _local39, _size4
$CLEA _local40, _zero, _local_aa4_37 
$LEA _zero, _local_aa4_36
_local_aa4_37:
MOV _aa0_a, _aa0_a, _size4
MOV_CONST 49478309, _local42
ADD _aa0_a, _aa0_a, _local42, _size4
$MOV _aa0_s, _aa0_a_ptr, _size4_ptr
MOV _aa0_s, _aa0_s, _size4
MOV_CONST 4, _local43
ADD _aa0_s, _aa0_s, _local43, _size4
$LEA _zero, _local_aa4_38 
_local_aa4_36:
MOV_CONST 0, aa4 - 8
LEA _size4_ptr, _size4
LEA _local44, aa4 - 4
$MOV _zero, _local44, _size4_ptr

.align 4
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
aa5:
MOV _local32, _aa0_s, _size4
MOV_CONST 0, _local34
EQ _local32, _local32, _local34, _size4
ALL _local32, _local32, _size4
LEA _local33, _local32
$CLEA _local33, _zero, _local_aa5_30 
$LEA _zero, _local_aa5_31 
_local_aa5_30:
MOV_CONST 20480, _aa0_s
_local_aa5_31:
MOV _aa2_e, _aa0_s, _size4
MOV_CONST 44100, _local35
ADD _aa2_e, _aa2_e, _local35, _size4
LEA _local40, _local39
_local_aa5_38:
MOV _local39, _aa0_s, _size4
MOV _local41, _aa2_e, _size4
EQ _local39, _local39, _local41, _size4
ALL _local39, _local39, _size4
INV _local39, _local39, _size4
$CLEA _local40, _zero, _local_aa5_37 
$LEA _zero, _local_aa5_36
_local_aa5_37:
MOV _aa0_a, _aa0_a, _size4
MOV_CONST 53478309, _local42
ADD _aa0_a, _aa0_a, _local42, _size4
$MOV _aa0_s, _aa0_a_ptr, _size4_ptr
MOV _aa0_s, _aa0_s, _size4
MOV_CONST 4, _local43
ADD _aa0_s, _aa0_s, _local43, _size4
$LEA _zero, _local_aa5_38 
_local_aa5_36:
MOV_CONST 0, aa5 - 8
LEA _size4_ptr, _size4
LEA _local44, aa5 - 4
$MOV _zero, _local44, _size4_ptr

.align 4
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
LEA aa3 - 4, _local107a
$LEA _zero, aa3
_local107a:
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
LEA aa2 - 4, _local119
$LEA _zero, aa2
_local119:
MOV _main_x, aa2 - 8, _size4
LEA aa1 - 4, _local120
$LEA _zero, aa1
_local120:
MOV _main_x, aa1 - 8, _size4
LEA aa1 - 4, _local121
$LEA _zero, aa1
_local121:
MOV _main_x, aa1 - 8, _size4
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


replay:
MOV_CONST 20480, _aa0_s
OUT 1, _aa0_s, count

this:
LEA local_queue_ptr, local_queue
IN 1, local_queue, _size4
$CLEA local_queue_ptr, _zero, this
$LEA _zero, replay

.db 0xFF


.align 4
local_queue_ptr:
.dd 0
local_queue:
.dd 0


.align 4
count:
.dd 1940400
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
_zero:
.dd 0
_byte_tmp:
.db 0

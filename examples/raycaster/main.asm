; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
phong:
MOV fmul - 12, phong - 24, _size4
MOV fmul - 16, phong - 24, _size4
LEA fmul - 4, _local2
$LEA _zero, fmul
_local2:
MOV sqrt - 12, fmul - 8, _size4
MOV fmul - 12, phong - 28, _size4
MOV fmul - 16, phong - 28, _size4
LEA fmul - 4, _local4
$LEA _zero, fmul
_local4:
MOV _local1, fmul - 8, _size4
MOV fmul - 12, phong - 32, _size4
MOV fmul - 16, phong - 32, _size4
LEA fmul - 4, _local5
$LEA _zero, fmul
_local5:
MOV _local3, fmul - 8, _size4
ADD _local1, _local1, _local3, _size4
ADD sqrt - 12, sqrt - 12, _local1, _size4
LEA sqrt - 4, _local6
$LEA _zero, sqrt
_local6:
MOV _local0, sqrt - 8, _size4
MOV _phong_l, _local0, _size4
MOV fdiv - 12, phong - 24, _size4
MOV fdiv - 16, _phong_l, _size4
LEA fdiv - 4, _local8
$LEA _zero, fdiv
_local8:
MOV _local7, fdiv - 8, _size4
MOV phong - 24, _local7, _size4
MOV fdiv - 12, phong - 28, _size4
MOV fdiv - 16, _phong_l, _size4
LEA fdiv - 4, _local10
$LEA _zero, fdiv
_local10:
MOV _local9, fdiv - 8, _size4
MOV phong - 28, _local9, _size4
MOV fdiv - 12, phong - 32, _size4
MOV fdiv - 16, _phong_l, _size4
LEA fdiv - 4, _local12
$LEA _zero, fdiv
_local12:
MOV _local11, fdiv - 8, _size4
MOV phong - 32, _local11, _size4
MOV fmul - 12, phong - 36, _size4
MOV fmul - 16, phong - 36, _size4
LEA fmul - 4, _local15
$LEA _zero, fmul
_local15:
MOV sqrt - 12, fmul - 8, _size4
MOV fmul - 12, phong - 40, _size4
MOV fmul - 16, phong - 40, _size4
LEA fmul - 4, _local17
$LEA _zero, fmul
_local17:
MOV _local14, fmul - 8, _size4
MOV fmul - 12, phong - 44, _size4
MOV fmul - 16, phong - 44, _size4
LEA fmul - 4, _local18
$LEA _zero, fmul
_local18:
MOV _local16, fmul - 8, _size4
ADD _local14, _local14, _local16, _size4
ADD sqrt - 12, sqrt - 12, _local14, _size4
LEA sqrt - 4, _local19
$LEA _zero, sqrt
_local19:
MOV _local13, sqrt - 8, _size4
MOV _phong_l, _local13, _size4
MOV fdiv - 12, phong - 36, _size4
MOV fdiv - 16, _phong_l, _size4
LEA fdiv - 4, _local21
$LEA _zero, fdiv
_local21:
MOV _local20, fdiv - 8, _size4
MOV phong - 36, _local20, _size4
MOV fdiv - 12, phong - 40, _size4
MOV fdiv - 16, _phong_l, _size4
LEA fdiv - 4, _local23
$LEA _zero, fdiv
_local23:
MOV _local22, fdiv - 8, _size4
MOV phong - 40, _local22, _size4
MOV fdiv - 12, phong - 44, _size4
MOV fdiv - 16, _phong_l, _size4
LEA fdiv - 4, _local25
$LEA _zero, fdiv
_local25:
MOV _local24, fdiv - 8, _size4
MOV phong - 44, _local24, _size4
MOV fmul - 12, phong - 12, _size4
MOV fmul - 16, phong - 12, _size4
LEA fmul - 4, _local28
$LEA _zero, fmul
_local28:
MOV sqrt - 12, fmul - 8, _size4
MOV fmul - 12, phong - 16, _size4
MOV fmul - 16, phong - 16, _size4
LEA fmul - 4, _local30
$LEA _zero, fmul
_local30:
MOV _local27, fmul - 8, _size4
MOV fmul - 12, phong - 20, _size4
MOV fmul - 16, phong - 20, _size4
LEA fmul - 4, _local31
$LEA _zero, fmul
_local31:
MOV _local29, fmul - 8, _size4
ADD _local27, _local27, _local29, _size4
ADD sqrt - 12, sqrt - 12, _local27, _size4
LEA sqrt - 4, _local32
$LEA _zero, sqrt
_local32:
MOV _local26, sqrt - 8, _size4
MOV _phong_l, _local26, _size4
MOV _local35, _phong_l, _size4
MOV_CONST 1, _local37
LT _local35, _local35, _local37, _size4
LEA _local36, _local35
$CLEA _local36, _zero, _local33 
$LEA _zero, _local34 
_local33:
MOV_CONST 0, phong - 8
LEA _local38, _size4
LEA _local39, phong - 4
$MOV _zero, _local39, _local38
_local34:
MOV fdiv - 12, phong - 12, _size4
MOV fdiv - 16, _phong_l, _size4
LEA fdiv - 4, _local41
$LEA _zero, fdiv
_local41:
MOV _local40, fdiv - 8, _size4
MOV phong - 12, _local40, _size4
MOV fdiv - 12, phong - 16, _size4
MOV fdiv - 16, _phong_l, _size4
LEA fdiv - 4, _local43
$LEA _zero, fdiv
_local43:
MOV _local42, fdiv - 8, _size4
MOV phong - 16, _local42, _size4
MOV fdiv - 12, phong - 20, _size4
MOV fdiv - 16, _phong_l, _size4
LEA fdiv - 4, _local45
$LEA _zero, fdiv
_local45:
MOV _local44, fdiv - 8, _size4
MOV phong - 20, _local44, _size4
MOV fmul - 12, phong - 12, _size4
MOV fmul - 16, phong - 36, _size4
LEA fmul - 4, _local48
$LEA _zero, fmul
_local48:
MOV _local46, fmul - 8, _size4
MOV fmul - 12, phong - 16, _size4
MOV fmul - 16, phong - 40, _size4
LEA fmul - 4, _local50
$LEA _zero, fmul
_local50:
MOV _local47, fmul - 8, _size4
MOV fmul - 12, phong - 20, _size4
MOV fmul - 16, phong - 44, _size4
LEA fmul - 4, _local51
$LEA _zero, fmul
_local51:
MOV _local49, fmul - 8, _size4
ADD _local47, _local47, _local49, _size4
ADD _local46, _local46, _local47, _size4
MOV _phong_diffuse, _local46, _size4
MOV fmul - 12, _phong_diffuse, _size4
MOV_CONST 400, fmul - 16
LEA fmul - 4, _local53
$LEA _zero, fmul
_local53:
MOV _local52, fmul - 8, _size4
MOV _phong_diffuse, _local52, _size4
MOV _local56, _phong_diffuse, _size4
MOV_CONST 0, _local58
LT _local56, _local56, _local58, _size4
LEA _local57, _local56
$CLEA _local57, _zero, _local54 
$LEA _zero, _local55 
_local54:
MOV_CONST 0, _local59
MOV _phong_diffuse, _local59, _size4
_local55:
MOV_CONST 0, _local60
MOV _phong_blink, _local60, _size4
MOV _local63, phong - 12, _size4
MOV _local67, phong - 36, _size4
MUL _local63, _local63, _local67, _size4
MOV _local66, phong - 16, _size4
MOV _local69, phong - 40, _size4
MUL _local66, _local66, _local69, _size4
MOV _local68, phong - 20, _size4
MOV _local70, phong - 44, _size4
MUL _local68, _local68, _local70, _size4
ADD _local66, _local66, _local68, _size4
ADD _local63, _local63, _local66, _size4
MOV_CONST 0, _local65
LT _local63, _local65, _local63, _size4
LEA _local64, _local63
$CLEA _local64, _zero, _local61 
$LEA _zero, _local62 
_local61:
MOV _local71, phong - 12, _size4
MOV _local72, phong - 24, _size4
SUB _local71, _local71, _local72, _size4
MOV _phong_x, _local71, _size4
MOV _local73, phong - 16, _size4
MOV _local74, phong - 28, _size4
SUB _local73, _local73, _local74, _size4
MOV _phong_y, _local73, _size4
MOV _local75, phong - 20, _size4
MOV _local76, phong - 32, _size4
SUB _local75, _local75, _local76, _size4
MOV _phong_z, _local75, _size4
MOV fmul - 12, _phong_x, _size4
MOV fmul - 16, _phong_x, _size4
LEA fmul - 4, _local79
$LEA _zero, fmul
_local79:
MOV sqrt - 12, fmul - 8, _size4
MOV fmul - 12, _phong_y, _size4
MOV fmul - 16, _phong_y, _size4
LEA fmul - 4, _local81
$LEA _zero, fmul
_local81:
MOV _local78, fmul - 8, _size4
MOV fmul - 12, _phong_z, _size4
MOV fmul - 16, _phong_z, _size4
LEA fmul - 4, _local82
$LEA _zero, fmul
_local82:
MOV _local80, fmul - 8, _size4
ADD _local78, _local78, _local80, _size4
ADD sqrt - 12, sqrt - 12, _local78, _size4
LEA sqrt - 4, _local83
$LEA _zero, sqrt
_local83:
MOV _local77, sqrt - 8, _size4
MOV _phong_l, _local77, _size4
MOV _local86, _phong_l, _size4
MOV_CONST 0, _local88
LT _local86, _local88, _local86, _size4
LEA _local87, _local86
$CLEA _local87, _zero, _local84 
$LEA _zero, _local85 
_local84:
MOV fdiv - 12, _phong_x, _size4
MOV fdiv - 16, _phong_l, _size4
LEA fdiv - 4, _local90
$LEA _zero, fdiv
_local90:
MOV _local89, fdiv - 8, _size4
MOV _phong_x, _local89, _size4
MOV fdiv - 12, _phong_y, _size4
MOV fdiv - 16, _phong_l, _size4
LEA fdiv - 4, _local92
$LEA _zero, fdiv
_local92:
MOV _local91, fdiv - 8, _size4
MOV _phong_y, _local91, _size4
MOV fdiv - 12, _phong_z, _size4
MOV fdiv - 16, _phong_l, _size4
LEA fdiv - 4, _local94
$LEA _zero, fdiv
_local94:
MOV _local93, fdiv - 8, _size4
MOV _phong_z, _local93, _size4
_local85:
MOV fmul - 12, _phong_x, _size4
MOV fmul - 16, phong - 36, _size4
LEA fmul - 4, _local97
$LEA _zero, fmul
_local97:
MOV _local95, fmul - 8, _size4
MOV fmul - 12, _phong_y, _size4
MOV fmul - 16, phong - 40, _size4
LEA fmul - 4, _local99
$LEA _zero, fmul
_local99:
MOV _local96, fmul - 8, _size4
MOV fmul - 12, _phong_z, _size4
MOV fmul - 16, phong - 44, _size4
LEA fmul - 4, _local100
$LEA _zero, fmul
_local100:
MOV _local98, fmul - 8, _size4
ADD _local96, _local96, _local98, _size4
ADD _local95, _local95, _local96, _size4
MOV _phong_blink, _local95, _size4
MOV _local103, _phong_blink, _size4
MOV_CONST 0, _local105
LT _local103, _local103, _local105, _size4
LEA _local104, _local103
$CLEA _local104, _zero, _local101 
$LEA _zero, _local102 
_local101:
MOV_CONST 0, _local106
MOV _phong_blink, _local106, _size4
_local102:
MOV fmul - 12, _phong_blink, _size4
MOV fmul - 16, _phong_blink, _size4
LEA fmul - 4, _local108
$LEA _zero, fmul
_local108:
MOV _local107, fmul - 8, _size4
MOV _phong_blink, _local107, _size4
MOV fmul - 12, _phong_blink, _size4
MOV fmul - 16, _phong_blink, _size4
LEA fmul - 4, _local110
$LEA _zero, fmul
_local110:
MOV _local109, fmul - 8, _size4
MOV _phong_blink, _local109, _size4
MOV fmul - 12, _phong_blink, _size4
MOV fmul - 16, _phong_blink, _size4
LEA fmul - 4, _local112
$LEA _zero, fmul
_local112:
MOV _local111, fmul - 8, _size4
MOV _phong_blink, _local111, _size4
MOV fmul - 12, _phong_blink, _size4
MOV_CONST 400, fmul - 16
LEA fmul - 4, _local114
$LEA _zero, fmul
_local114:
MOV _local113, fmul - 8, _size4
MOV _phong_blink, _local113, _size4
_local62:
MOV_CONST 200, _local115
MOV _local116, _phong_diffuse, _size4
MOV _local117, _phong_blink, _size4
ADD _local116, _local116, _local117, _size4
ADD _local115, _local115, _local116, _size4
MOV _phong_ans, _local115, _size4
MOV _local120, _phong_ans, _size4
MOV_CONST 1000, _local122
LT _local120, _local122, _local120, _size4
LEA _local121, _local120
$CLEA _local121, _zero, _local118 
$LEA _zero, _local119 
_local118:
MOV_CONST 1000, _local123
MOV _phong_ans, _local123, _size4
_local119:
MOV phong - 8, _phong_ans, _size4
LEA _local124, _size4
LEA _local125, phong - 4
$MOV _zero, _local125, _local124
; arguments
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
main:
MOV_CONST 1000, _local126
MOV _main_lx, _local126, _size4
MOV_CONST 0, _local127
MOV _main_ly, _local127, _size4
MOV_CONST 0, _local128
MOV _main_lz, _local128, _size4
MOV_CONST 50, _local129
MOV_CONST 100, _local130
MUL _local129, _local129, _local130, _size4
MOV _main_gx, _local129, _size4
MOV_CONST 0, _local131
MOV _main_ggdx, _local131, _size4
MOV_CONST 10, _local132
MOV_CONST 100, _local133
MUL _local132, _local132, _local133, _size4
MOV _main_gy, _local132, _size4
MOV_CONST -8000, _local134
MOV_CONST 50, _local135
MOV_CONST 100, _local136
MUL _local135, _local135, _local136, _size4
ADD _local134, _local134, _local135, _size4
MOV _main_gz, _local134, _size4
MOV_CONST 0, _local137
MOV _main_tim, _local137, _size4
LEA _local142, _local141
_local140:
MOV_CONST 1, _local141
$CLEA _local142, _zero, _local139 
$LEA _zero, _local138
_local139:
MOV_CONST 65536, _local143
MOV _main_start, _local143, _size4
MOV_CONST 65536, _local144
MOV _main_end, _local144, _size4
MOV _local145, _main_tim, _size4
MOV_CONST 1, _local146
ADD _local145, _local145, _local146, _size4
MOV _main_tim, _local145, _size4
MOV _local147, _main_lx, _size4
MOV _main_k1, _local147, _size4
MOV _local148, _main_ly, _size4
MOV _main_k2, _local148, _size4
MOV _local149, _main_lz, _size4
MOV _main_k3, _local149, _size4
MOV _local152, _main_tim, _size4
MOV _local155, _main_tim, _size4
MOV_CONST 100, _local157
DIV _local155, _local155, _local157, _size4
MOV_CONST 100, _local156
MUL _local155, _local155, _local156, _size4
SUB _local152, _local152, _local155, _size4
MOV_CONST 50, _local154
LT _local152, _local152, _local154, _size4
LEA _local153, _local152
$CLEA _local153, _zero, _local150 
MOV fmul - 12, _main_k1, _size4
MOV_CONST 995, fmul - 16
LEA fmul - 4, _local160
$LEA _zero, fmul
_local160:
MOV _local158, fmul - 8, _size4
MOV fmul - 12, _main_k2, _size4
MOV_CONST -89, fmul - 16
LEA fmul - 4, _local162
$LEA _zero, fmul
_local162:
MOV _local159, fmul - 8, _size4
MOV fmul - 12, _main_k3, _size4
MOV_CONST 19, fmul - 16
LEA fmul - 4, _local163
$LEA _zero, fmul
_local163:
MOV _local161, fmul - 8, _size4
ADD _local159, _local159, _local161, _size4
ADD _local158, _local158, _local159, _size4
MOV _main_lx, _local158, _size4
MOV fmul - 12, _main_k1, _size4
MOV_CONST 89, fmul - 16
LEA fmul - 4, _local166
$LEA _zero, fmul
_local166:
MOV _local164, fmul - 8, _size4
MOV fmul - 12, _main_k2, _size4
MOV_CONST 995, fmul - 16
LEA fmul - 4, _local168
$LEA _zero, fmul
_local168:
MOV _local165, fmul - 8, _size4
MOV fmul - 12, _main_k3, _size4
MOV_CONST -19, fmul - 16
LEA fmul - 4, _local169
$LEA _zero, fmul
_local169:
MOV _local167, fmul - 8, _size4
ADD _local165, _local165, _local167, _size4
ADD _local164, _local164, _local165, _size4
MOV _main_ly, _local164, _size4
MOV fmul - 12, _main_k1, _size4
MOV_CONST -21, fmul - 16
LEA fmul - 4, _local172
$LEA _zero, fmul
_local172:
MOV _local170, fmul - 8, _size4
MOV fmul - 12, _main_k2, _size4
MOV_CONST -18, fmul - 16
LEA fmul - 4, _local174
$LEA _zero, fmul
_local174:
MOV _local171, fmul - 8, _size4
MOV fmul - 12, _main_k3, _size4
MOV_CONST 999, fmul - 16
LEA fmul - 4, _local175
$LEA _zero, fmul
_local175:
MOV _local173, fmul - 8, _size4
ADD _local171, _local171, _local173, _size4
ADD _local170, _local170, _local171, _size4
MOV _main_lz, _local170, _size4
$LEA _zero, _local151 
_local150:
MOV fmul - 12, _main_k1, _size4
MOV_CONST 993, fmul - 16
LEA fmul - 4, _local178
$LEA _zero, fmul
_local178:
MOV _local176, fmul - 8, _size4
MOV fmul - 12, _main_k2, _size4
MOV_CONST -59, fmul - 16
LEA fmul - 4, _local180
$LEA _zero, fmul
_local180:
MOV _local177, fmul - 8, _size4
MOV fmul - 12, _main_k3, _size4
MOV_CONST 99, fmul - 16
LEA fmul - 4, _local181
$LEA _zero, fmul
_local181:
MOV _local179, fmul - 8, _size4
ADD _local177, _local177, _local179, _size4
ADD _local176, _local176, _local177, _size4
MOV _main_lx, _local176, _size4
MOV fmul - 12, _main_k1, _size4
MOV_CONST 65, fmul - 16
LEA fmul - 4, _local184
$LEA _zero, fmul
_local184:
MOV _local182, fmul - 8, _size4
MOV fmul - 12, _main_k2, _size4
MOV_CONST 996, fmul - 16
LEA fmul - 4, _local186
$LEA _zero, fmul
_local186:
MOV _local183, fmul - 8, _size4
MOV fmul - 12, _main_k3, _size4
MOV_CONST -59, fmul - 16
LEA fmul - 4, _local187
$LEA _zero, fmul
_local187:
MOV _local185, fmul - 8, _size4
ADD _local183, _local183, _local185, _size4
ADD _local182, _local182, _local183, _size4
MOV _main_ly, _local182, _size4
MOV fmul - 12, _main_k1, _size4
MOV_CONST -95, fmul - 16
LEA fmul - 4, _local190
$LEA _zero, fmul
_local190:
MOV _local188, fmul - 8, _size4
MOV fmul - 12, _main_k2, _size4
MOV_CONST 65, fmul - 16
LEA fmul - 4, _local192
$LEA _zero, fmul
_local192:
MOV _local189, fmul - 8, _size4
MOV fmul - 12, _main_k3, _size4
MOV_CONST 993, fmul - 16
LEA fmul - 4, _local193
$LEA _zero, fmul
_local193:
MOV _local191, fmul - 8, _size4
ADD _local189, _local189, _local191, _size4
ADD _local188, _local188, _local189, _size4
MOV _main_lz, _local188, _size4
_local151:
MOV _local196, _main_tim, _size4
MOV _local199, _main_tim, _size4
MOV_CONST 400, _local201
DIV _local199, _local199, _local201, _size4
MOV_CONST 400, _local200
MUL _local199, _local199, _local200, _size4
SUB _local196, _local196, _local199, _size4
MOV_CONST 200, _local198
LT _local196, _local196, _local198, _size4
LEA _local197, _local196
$CLEA _local197, _zero, _local194 
MOV _local202, _main_gx, _size4
MOV_CONST 50, _local203
ADD _local202, _local202, _local203, _size4
MOV _main_gx, _local202, _size4
MOV _local204, _main_gy, _size4
MOV_CONST 10, _local205
ADD _local204, _local204, _local205, _size4
MOV _main_gy, _local204, _size4
MOV _local206, _main_gz, _size4
MOV_CONST 50, _local207
ADD _local206, _local206, _local207, _size4
MOV _main_gz, _local206, _size4
$LEA _zero, _local195 
_local194:
MOV _local208, _main_gx, _size4
MOV_CONST 50, _local209
SUB _local208, _local208, _local209, _size4
MOV _main_gx, _local208, _size4
MOV _local210, _main_gy, _size4
MOV_CONST 10, _local211
SUB _local210, _local210, _local211, _size4
MOV _main_gy, _local210, _size4
MOV _local212, _main_gz, _size4
MOV_CONST 50, _local213
SUB _local212, _local212, _local213, _size4
MOV _main_gz, _local212, _size4
_local195:
MOV fmul - 12, _main_lx, _size4
MOV fmul - 16, _main_lx, _size4
LEA fmul - 4, _local217
$LEA _zero, fmul
_local217:
MOV sqrt - 12, fmul - 8, _size4
MOV fmul - 12, _main_ly, _size4
MOV fmul - 16, _main_ly, _size4
LEA fmul - 4, _local219
$LEA _zero, fmul
_local219:
MOV _local216, fmul - 8, _size4
MOV fmul - 12, _main_lz, _size4
MOV fmul - 16, _main_lz, _size4
LEA fmul - 4, _local220
$LEA _zero, fmul
_local220:
MOV _local218, fmul - 8, _size4
ADD _local216, _local216, _local218, _size4
ADD sqrt - 12, sqrt - 12, _local216, _size4
LEA sqrt - 4, _local221
$LEA _zero, sqrt
_local221:
MOV _local214, sqrt - 8, _size4
MOV_CONST 3, _local215
DIV _local214, _local214, _local215, _size4
MOV _main_t, _local214, _size4
MOV fdiv - 12, _main_lx, _size4
MOV fdiv - 16, _main_t, _size4
LEA fdiv - 4, _local223
$LEA _zero, fdiv
_local223:
MOV _local222, fdiv - 8, _size4
MOV _main_lx, _local222, _size4
MOV fdiv - 12, _main_ly, _size4
MOV fdiv - 16, _main_t, _size4
LEA fdiv - 4, _local225
$LEA _zero, fdiv
_local225:
MOV _local224, fdiv - 8, _size4
MOV _main_ly, _local224, _size4
MOV fdiv - 12, _main_lz, _size4
MOV fdiv - 16, _main_t, _size4
LEA fdiv - 4, _local227
$LEA _zero, fdiv
_local227:
MOV _local226, fdiv - 8, _size4
MOV _main_lz, _local226, _size4
MOV_CONST 0, _local228
MOV _main_y, _local228, _size4
LEA _local233, _local232
_local231:
MOV _local232, _main_y, _size4
MOV_CONST 90, _local234
LT _local232, _local232, _local234, _size4
$CLEA _local233, _zero, _local230 
$LEA _zero, _local229
_local230:
MOV_CONST 0, _local235
MOV _main_x, _local235, _size4
LEA _local240, _local239
_local238:
MOV _local239, _main_x, _size4
MOV_CONST 160, _local241
LT _local239, _local239, _local241, _size4
$CLEA _local240, _zero, _local237 
$LEA _zero, _local236
_local237:
MOV _local242, _main_x, _size4
MOV_CONST 80, _local244
SUB _local242, _local242, _local244, _size4
MOV_CONST 12, _local243
MUL _local242, _local242, _local243, _size4
MOV _main_a, _local242, _size4
MOV_CONST 45, _local245
MOV _local247, _main_y, _size4
SUB _local245, _local245, _local247, _size4
MOV_CONST 12, _local246
MUL _local245, _local245, _local246, _size4
MOV _main_b, _local245, _size4
MOV _local248, _main_a, _size4
MOV_CONST 2, _local250
MUL _local248, _local248, _local250, _size4
MOV_CONST 3, _local249
DIV _local248, _local248, _local249, _size4
MOV _main_dx, _local248, _size4
MOV _local251, _main_b, _size4
MOV_CONST 2, _local253
MUL _local251, _local251, _local253, _size4
MOV_CONST 3, _local252
DIV _local251, _local251, _local252, _size4
MOV _main_dy, _local251, _size4
MOV_CONST 1000, _local254
MOV _main_dz, _local254, _size4
MOV intersect_ball - 12, _main_gx, _size4
MOV intersect_ball - 16, _main_gy, _size4
MOV intersect_ball - 20, _main_gz, _size4
MOV intersect_ball - 24, _main_dx, _size4
MOV intersect_ball - 28, _main_dy, _size4
MOV intersect_ball - 32, _main_dz, _size4
MOV_CONST -1200, intersect_ball - 36
MOV_CONST -600, intersect_ball - 40
MOV_CONST 0, intersect_ball - 44
MOV_CONST 1500, intersect_ball - 48
LEA intersect_ball - 4, _local256
$LEA _zero, intersect_ball
_local256:
MOV _local255, intersect_ball - 8, _size4
MOV _main_res1, _local255, _size4
MOV put4 - 12, _main_end, _size4
MOV_CONST 0, put4 - 16
LEA put4 - 4, _local258
$LEA _zero, put4
_local258:
MOV _local257, put4 - 8, _size4
MOV _main_t, _local257, _size4
MOV _local261, _main_res1, _size4
MOV_CONST 0, _local263
LT _local261, _local263, _local261, _size4
LEA _local262, _local261
$CLEA _local262, _zero, _local259 
$LEA _zero, _local260 
_local259:
MOV _local264, _main_gx, _size4
MOV fmul - 12, _main_dx, _size4
MOV fmul - 16, _main_res1, _size4
LEA fmul - 4, _local266
$LEA _zero, fmul
_local266:
MOV _local265, fmul - 8, _size4
ADD _local264, _local264, _local265, _size4
MOV _main_px, _local264, _size4
MOV _local267, _main_gy, _size4
MOV fmul - 12, _main_dy, _size4
MOV fmul - 16, _main_res1, _size4
LEA fmul - 4, _local269
$LEA _zero, fmul
_local269:
MOV _local268, fmul - 8, _size4
ADD _local267, _local267, _local268, _size4
MOV _main_py, _local267, _size4
MOV _local270, _main_gz, _size4
MOV fmul - 12, _main_dz, _size4
MOV fmul - 16, _main_res1, _size4
LEA fmul - 4, _local272
$LEA _zero, fmul
_local272:
MOV _local271, fmul - 8, _size4
ADD _local270, _local270, _local271, _size4
MOV _main_pz, _local270, _size4
MOV _local273, _main_px, _size4
MOV_CONST 1200, _local274
ADD _local273, _local273, _local274, _size4
MOV _main_nx, _local273, _size4
MOV _local275, _main_py, _size4
MOV_CONST 600, _local276
ADD _local275, _local275, _local276, _size4
MOV _main_ny, _local275, _size4
MOV _local277, _main_pz, _size4
MOV_CONST 0, _local278
SUB _local277, _local277, _local278, _size4
MOV _main_nz, _local277, _size4
MOV _local279, _main_lx, _size4
MOV _local280, _main_px, _size4
SUB _local279, _local279, _local280, _size4
MOV _main_ldx, _local279, _size4
MOV _local281, _main_ly, _size4
MOV _local282, _main_py, _size4
SUB _local281, _local281, _local282, _size4
MOV _main_ldy, _local281, _size4
MOV _local283, _main_lz, _size4
MOV _local284, _main_pz, _size4
SUB _local283, _local283, _local284, _size4
MOV _main_ldz, _local283, _size4
MOV phong - 12, _main_ldx, _size4
MOV phong - 16, _main_ldy, _size4
MOV phong - 20, _main_ldz, _size4
MOV phong - 24, _main_dx, _size4
MOV phong - 28, _main_dy, _size4
MOV phong - 32, _main_dz, _size4
MOV phong - 36, _main_nx, _size4
MOV phong - 40, _main_ny, _size4
MOV phong - 44, _main_nz, _size4
LEA phong - 4, _local286
$LEA _zero, phong
_local286:
MOV _local285, phong - 8, _size4
MOV _main_spec, _local285, _size4
MOV_CONST 255, _local287
MOV _local289, _main_spec, _size4
MUL _local287, _local287, _local289, _size4
MOV_CONST 1000, _local288
DIV _local287, _local287, _local288, _size4
MOV _main_color, _local287, _size4
MOV put4 - 12, _main_end, _size4
MOV put4 - 16, _main_color, _size4
MOV_CONST 255, _local291
MOV _local293, _main_color, _size4
MUL _local291, _local291, _local293, _size4
MOV_CONST 65536, _local292
MOV _local294, _main_color, _size4
MUL _local292, _local292, _local294, _size4
ADD _local291, _local291, _local292, _size4
ADD put4 - 16, put4 - 16, _local291, _size4
LEA put4 - 4, _local295
$LEA _zero, put4
_local295:
MOV _local290, put4 - 8, _size4
MOV _main_t, _local290, _size4
_local260:
MOV intersect_ball - 12, _main_gx, _size4
MOV intersect_ball - 16, _main_gy, _size4
MOV intersect_ball - 20, _main_gz, _size4
MOV intersect_ball - 24, _main_dx, _size4
MOV intersect_ball - 28, _main_dy, _size4
MOV intersect_ball - 32, _main_dz, _size4
MOV_CONST 1500, intersect_ball - 36
MOV_CONST 700, intersect_ball - 40
MOV_CONST 800, intersect_ball - 44
MOV_CONST 1000, intersect_ball - 48
LEA intersect_ball - 4, _local297
$LEA _zero, intersect_ball
_local297:
MOV _local296, intersect_ball - 8, _size4
MOV _main_res3, _local296, _size4
MOV _local300, _main_res3, _size4
MOV _local303, _main_res1, _size4
LT _local300, _local300, _local303, _size4
MOV _local302, _main_res1, _size4
MOV_CONST 0, _local304
LT _local302, _local302, _local304, _size4
ADD _local300, _local300, _local302, _size4
LEA _local301, _local300
$CLEA _local301, _zero, _local298 
$LEA _zero, _local299 
_local298:
MOV _local307, _main_res3, _size4
MOV_CONST 0, _local309
LT _local307, _local309, _local307, _size4
LEA _local308, _local307
$CLEA _local308, _zero, _local305 
$LEA _zero, _local306 
_local305:
MOV _local310, _main_gx, _size4
MOV fmul - 12, _main_dx, _size4
MOV fmul - 16, _main_res3, _size4
LEA fmul - 4, _local312
$LEA _zero, fmul
_local312:
MOV _local311, fmul - 8, _size4
ADD _local310, _local310, _local311, _size4
MOV _main_px, _local310, _size4
MOV _local313, _main_gy, _size4
MOV fmul - 12, _main_dy, _size4
MOV fmul - 16, _main_res3, _size4
LEA fmul - 4, _local315
$LEA _zero, fmul
_local315:
MOV _local314, fmul - 8, _size4
ADD _local313, _local313, _local314, _size4
MOV _main_py, _local313, _size4
MOV _local316, _main_gz, _size4
MOV fmul - 12, _main_dz, _size4
MOV fmul - 16, _main_res3, _size4
LEA fmul - 4, _local318
$LEA _zero, fmul
_local318:
MOV _local317, fmul - 8, _size4
ADD _local316, _local316, _local317, _size4
MOV _main_pz, _local316, _size4
MOV _local319, _main_px, _size4
MOV_CONST 1500, _local320
SUB _local319, _local319, _local320, _size4
MOV _main_nx, _local319, _size4
MOV _local321, _main_py, _size4
MOV_CONST 700, _local322
SUB _local321, _local321, _local322, _size4
MOV _main_ny, _local321, _size4
MOV _local323, _main_pz, _size4
MOV_CONST 800, _local324
SUB _local323, _local323, _local324, _size4
MOV _main_nz, _local323, _size4
MOV _local325, _main_lx, _size4
MOV _local326, _main_px, _size4
SUB _local325, _local325, _local326, _size4
MOV _main_ldx, _local325, _size4
MOV _local327, _main_ly, _size4
MOV _local328, _main_py, _size4
SUB _local327, _local327, _local328, _size4
MOV _main_ldy, _local327, _size4
MOV _local329, _main_lz, _size4
MOV _local330, _main_pz, _size4
SUB _local329, _local329, _local330, _size4
MOV _main_ldz, _local329, _size4
MOV phong - 12, _main_ldx, _size4
MOV phong - 16, _main_ldy, _size4
MOV phong - 20, _main_ldz, _size4
MOV phong - 24, _main_dx, _size4
MOV phong - 28, _main_dy, _size4
MOV phong - 32, _main_dz, _size4
MOV phong - 36, _main_nx, _size4
MOV phong - 40, _main_ny, _size4
MOV phong - 44, _main_nz, _size4
LEA phong - 4, _local332
$LEA _zero, phong
_local332:
MOV _local331, phong - 8, _size4
MOV _main_spec, _local331, _size4
MOV_CONST 255, _local333
MOV _local335, _main_spec, _size4
MUL _local333, _local333, _local335, _size4
MOV_CONST 1000, _local334
DIV _local333, _local333, _local334, _size4
MOV _main_color, _local333, _size4
MOV put4 - 12, _main_end, _size4
MOV put4 - 16, _main_color, _size4
MOV_CONST 65536, _local337
MOV _local338, _main_color, _size4
MUL _local337, _local337, _local338, _size4
ADD put4 - 16, put4 - 16, _local337, _size4
LEA put4 - 4, _local339
$LEA _zero, put4
_local339:
MOV _local336, put4 - 8, _size4
MOV _main_t, _local336, _size4
_local306:
_local299:
MOV intersect_ball - 12, _main_gx, _size4
MOV intersect_ball - 16, _main_gy, _size4
MOV intersect_ball - 20, _main_gz, _size4
MOV intersect_ball - 24, _main_dx, _size4
MOV intersect_ball - 28, _main_dy, _size4
MOV intersect_ball - 32, _main_dz, _size4
MOV_CONST 2, intersect_ball - 36
MOV _local341, _main_lx, _size4
MUL intersect_ball - 36, intersect_ball - 36, _local341, _size4
MOV_CONST 2, intersect_ball - 40
MOV _local342, _main_ly, _size4
MUL intersect_ball - 40, intersect_ball - 40, _local342, _size4
MOV_CONST 5000, intersect_ball - 44
MOV_CONST 2, _local343
MOV _local344, _main_lz, _size4
MUL _local343, _local343, _local344, _size4
ADD intersect_ball - 44, intersect_ball - 44, _local343, _size4
MOV_CONST 160, intersect_ball - 48
LEA intersect_ball - 4, _local345
$LEA _zero, intersect_ball
_local345:
MOV _local340, intersect_ball - 8, _size4
MOV _main_res2, _local340, _size4
MOV _local348, _main_res2, _size4
MOV _local351, _main_res1, _size4
LT _local348, _local348, _local351, _size4
MOV _local350, _main_res1, _size4
MOV_CONST 0, _local352
LT _local350, _local350, _local352, _size4
ADD _local348, _local348, _local350, _size4
LEA _local349, _local348
$CLEA _local349, _zero, _local346 
$LEA _zero, _local347 
_local346:
MOV _local355, _main_res2, _size4
MOV _local358, _main_res3, _size4
LT _local355, _local355, _local358, _size4
MOV _local357, _main_res3, _size4
MOV_CONST 0, _local359
LT _local357, _local357, _local359, _size4
ADD _local355, _local355, _local357, _size4
LEA _local356, _local355
$CLEA _local356, _zero, _local353 
$LEA _zero, _local354 
_local353:
MOV _local362, _main_res2, _size4
MOV_CONST 0, _local364
LT _local362, _local364, _local362, _size4
LEA _local363, _local362
$CLEA _local363, _zero, _local360 
$LEA _zero, _local361 
_local360:
MOV put4 - 12, _main_end, _size4
MOV_CONST 255, put4 - 16
MOV_CONST 65536, _local366
MUL put4 - 16, put4 - 16, _local366, _size4
LEA put4 - 4, _local367
$LEA _zero, put4
_local367:
MOV _local365, put4 - 8, _size4
MOV _main_t, _local365, _size4
_local361:
_local354:
_local347:
MOV _local368, _main_end, _size4
MOV_CONST 4, _local369
ADD _local368, _local368, _local369, _size4
MOV _main_end, _local368, _size4
MOV _local370, _main_x, _size4
MOV_CONST 1, _local371
ADD _local370, _local370, _local371, _size4
MOV _main_x, _local370, _size4
$LEA _zero, _local238 
_local236:
MOV _local372, _main_y, _size4
MOV_CONST 1, _local373
ADD _local372, _local372, _local373, _size4
MOV _main_y, _local372, _size4
$LEA _zero, _local231 
_local229:
MOV out - 12, _main_start, _size4
MOV out - 16, _main_end, _size4
MOV _local375, _main_start, _size4
SUB out - 16, out - 16, _local375, _size4
LEA out - 4, _local376
$LEA _zero, out
_local376:
MOV _local374, out - 8, _size4
MOV _main_t, _local374, _size4
$LEA _zero, _local140 
_local138:
MOV_CONST 0, main - 8
LEA _local377, _size4
LEA _local378, main - 4
$MOV _zero, _local378, _local377
_phong_l:
.dd 0
_local0:
.dd 0
_local1:
.dd 0
_local3:
.dd 0
_local7:
.dd 0
_local9:
.dd 0
_local11:
.dd 0
_local13:
.dd 0
_local14:
.dd 0
_local16:
.dd 0
_local20:
.dd 0
_local22:
.dd 0
_local24:
.dd 0
_local26:
.dd 0
_local27:
.dd 0
_local29:
.dd 0
_local35:
.dd 0
_local36:
.dd 0
_local37:
.dd 0
_local38:
.dd 0
_local39:
.dd 0
_local40:
.dd 0
_local42:
.dd 0
_local44:
.dd 0
_phong_diffuse:
.dd 0
_local46:
.dd 0
_local47:
.dd 0
_local49:
.dd 0
_local52:
.dd 0
_local56:
.dd 0
_local57:
.dd 0
_local58:
.dd 0
_local59:
.dd 0
_phong_blink:
.dd 0
_local60:
.dd 0
_local63:
.dd 0
_local64:
.dd 0
_local65:
.dd 0
_local66:
.dd 0
_local67:
.dd 0
_local68:
.dd 0
_local69:
.dd 0
_local70:
.dd 0
_phong_x:
.dd 0
_phong_y:
.dd 0
_phong_z:
.dd 0
_local71:
.dd 0
_local72:
.dd 0
_local73:
.dd 0
_local74:
.dd 0
_local75:
.dd 0
_local76:
.dd 0
_local77:
.dd 0
_local78:
.dd 0
_local80:
.dd 0
_local86:
.dd 0
_local87:
.dd 0
_local88:
.dd 0
_local89:
.dd 0
_local91:
.dd 0
_local93:
.dd 0
_local95:
.dd 0
_local96:
.dd 0
_local98:
.dd 0
_local103:
.dd 0
_local104:
.dd 0
_local105:
.dd 0
_local106:
.dd 0
_local107:
.dd 0
_local109:
.dd 0
_local111:
.dd 0
_local113:
.dd 0
_phong_ans:
.dd 0
_local115:
.dd 0
_local116:
.dd 0
_local117:
.dd 0
_local120:
.dd 0
_local121:
.dd 0
_local122:
.dd 0
_local123:
.dd 0
_local124:
.dd 0
_local125:
.dd 0
_main_res1:
.dd 0
_main_res2:
.dd 0
_main_res3:
.dd 0
_main_t:
.dd 0
_main_x:
.dd 0
_main_y:
.dd 0
_main_gx:
.dd 0
_main_gy:
.dd 0
_main_gz:
.dd 0
_main_lx:
.dd 0
_main_ly:
.dd 0
_main_lz:
.dd 0
_main_ldx:
.dd 0
_main_ldy:
.dd 0
_main_ldz:
.dd 0
_main_tim:
.dd 0
_main_ggdx:
.dd 0
_main_spec:
.dd 0
_main_color:
.dd 0
_local126:
.dd 0
_local127:
.dd 0
_local128:
.dd 0
_local129:
.dd 0
_local130:
.dd 0
_local131:
.dd 0
_local132:
.dd 0
_local133:
.dd 0
_local134:
.dd 0
_local135:
.dd 0
_local136:
.dd 0
_local137:
.dd 0
_local141:
.dd 0
_local142:
.dd 0
_main_start:
.dd 0
_main_end:
.dd 0
_local143:
.dd 0
_local144:
.dd 0
_local145:
.dd 0
_local146:
.dd 0
_main_k1:
.dd 0
_main_k2:
.dd 0
_main_k3:
.dd 0
_local147:
.dd 0
_local148:
.dd 0
_local149:
.dd 0
_local152:
.dd 0
_local153:
.dd 0
_local154:
.dd 0
_local155:
.dd 0
_local156:
.dd 0
_local157:
.dd 0
_local158:
.dd 0
_local159:
.dd 0
_local161:
.dd 0
_local164:
.dd 0
_local165:
.dd 0
_local167:
.dd 0
_local170:
.dd 0
_local171:
.dd 0
_local173:
.dd 0
_local176:
.dd 0
_local177:
.dd 0
_local179:
.dd 0
_local182:
.dd 0
_local183:
.dd 0
_local185:
.dd 0
_local188:
.dd 0
_local189:
.dd 0
_local191:
.dd 0
_local196:
.dd 0
_local197:
.dd 0
_local198:
.dd 0
_local199:
.dd 0
_local200:
.dd 0
_local201:
.dd 0
_local202:
.dd 0
_local203:
.dd 0
_local204:
.dd 0
_local205:
.dd 0
_local206:
.dd 0
_local207:
.dd 0
_local208:
.dd 0
_local209:
.dd 0
_local210:
.dd 0
_local211:
.dd 0
_local212:
.dd 0
_local213:
.dd 0
_local214:
.dd 0
_local215:
.dd 0
_local216:
.dd 0
_local218:
.dd 0
_local222:
.dd 0
_local224:
.dd 0
_local226:
.dd 0
_local228:
.dd 0
_local232:
.dd 0
_local233:
.dd 0
_local234:
.dd 0
_local235:
.dd 0
_local239:
.dd 0
_local240:
.dd 0
_local241:
.dd 0
_main_a:
.dd 0
_main_b:
.dd 0
_local242:
.dd 0
_local243:
.dd 0
_local244:
.dd 0
_local245:
.dd 0
_local246:
.dd 0
_local247:
.dd 0
_main_dx:
.dd 0
_main_dy:
.dd 0
_main_dz:
.dd 0
_main_px:
.dd 0
_main_py:
.dd 0
_main_pz:
.dd 0
_main_nx:
.dd 0
_main_ny:
.dd 0
_main_nz:
.dd 0
_local248:
.dd 0
_local249:
.dd 0
_local250:
.dd 0
_local251:
.dd 0
_local252:
.dd 0
_local253:
.dd 0
_local254:
.dd 0
_local255:
.dd 0
_local257:
.dd 0
_local261:
.dd 0
_local262:
.dd 0
_local263:
.dd 0
_local264:
.dd 0
_local265:
.dd 0
_local267:
.dd 0
_local268:
.dd 0
_local270:
.dd 0
_local271:
.dd 0
_local273:
.dd 0
_local274:
.dd 0
_local275:
.dd 0
_local276:
.dd 0
_local277:
.dd 0
_local278:
.dd 0
_local279:
.dd 0
_local280:
.dd 0
_local281:
.dd 0
_local282:
.dd 0
_local283:
.dd 0
_local284:
.dd 0
_local285:
.dd 0
_local287:
.dd 0
_local288:
.dd 0
_local289:
.dd 0
_local290:
.dd 0
_local291:
.dd 0
_local292:
.dd 0
_local293:
.dd 0
_local294:
.dd 0
_local296:
.dd 0
_local300:
.dd 0
_local301:
.dd 0
_local302:
.dd 0
_local303:
.dd 0
_local304:
.dd 0
_local307:
.dd 0
_local308:
.dd 0
_local309:
.dd 0
_local310:
.dd 0
_local311:
.dd 0
_local313:
.dd 0
_local314:
.dd 0
_local316:
.dd 0
_local317:
.dd 0
_local319:
.dd 0
_local320:
.dd 0
_local321:
.dd 0
_local322:
.dd 0
_local323:
.dd 0
_local324:
.dd 0
_local325:
.dd 0
_local326:
.dd 0
_local327:
.dd 0
_local328:
.dd 0
_local329:
.dd 0
_local330:
.dd 0
_local331:
.dd 0
_local333:
.dd 0
_local334:
.dd 0
_local335:
.dd 0
_local336:
.dd 0
_local337:
.dd 0
_local338:
.dd 0
_local340:
.dd 0
_local341:
.dd 0
_local342:
.dd 0
_local343:
.dd 0
_local344:
.dd 0
_local348:
.dd 0
_local349:
.dd 0
_local350:
.dd 0
_local351:
.dd 0
_local352:
.dd 0
_local355:
.dd 0
_local356:
.dd 0
_local357:
.dd 0
_local358:
.dd 0
_local359:
.dd 0
_local362:
.dd 0
_local363:
.dd 0
_local364:
.dd 0
_local365:
.dd 0
_local366:
.dd 0
_local368:
.dd 0
_local369:
.dd 0
_local370:
.dd 0
_local371:
.dd 0
_local372:
.dd 0
_local373:
.dd 0
_local374:
.dd 0
_local375:
.dd 0
_local377:
.dd 0
_local378:
.dd 0
_size4:
.dd 4
_size1:
.dd 1
_zero:
.dd 0

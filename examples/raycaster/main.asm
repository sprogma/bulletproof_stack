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
MOV fdiv - 12, phong - 12, _size4
MOV fdiv - 16, _phong_l, _size4
LEA fdiv - 4, _local34
$LEA _zero, fdiv
_local34:
MOV _local33, fdiv - 8, _size4
MOV phong - 12, _local33, _size4
MOV fdiv - 12, phong - 16, _size4
MOV fdiv - 16, _phong_l, _size4
LEA fdiv - 4, _local36
$LEA _zero, fdiv
_local36:
MOV _local35, fdiv - 8, _size4
MOV phong - 16, _local35, _size4
MOV fdiv - 12, phong - 20, _size4
MOV fdiv - 16, _phong_l, _size4
LEA fdiv - 4, _local38
$LEA _zero, fdiv
_local38:
MOV _local37, fdiv - 8, _size4
MOV phong - 20, _local37, _size4
MOV fmul - 12, phong - 12, _size4
MOV fmul - 16, phong - 36, _size4
LEA fmul - 4, _local41
$LEA _zero, fmul
_local41:
MOV _local39, fmul - 8, _size4
MOV fmul - 12, phong - 16, _size4
MOV fmul - 16, phong - 40, _size4
LEA fmul - 4, _local43
$LEA _zero, fmul
_local43:
MOV _local40, fmul - 8, _size4
MOV fmul - 12, phong - 20, _size4
MOV fmul - 16, phong - 44, _size4
LEA fmul - 4, _local44
$LEA _zero, fmul
_local44:
MOV _local42, fmul - 8, _size4
ADD _local40, _local40, _local42, _size4
ADD _local39, _local39, _local40, _size4
MOV _phong_diffuse, _local39, _size4
MOV fmul - 12, _phong_diffuse, _size4
MOV_CONST 400, fmul - 16
LEA fmul - 4, _local46
$LEA _zero, fmul
_local46:
MOV _local45, fmul - 8, _size4
MOV _phong_diffuse, _local45, _size4
MOV _local49, _phong_diffuse, _size4
MOV_CONST 0, _local51
LT _local49, _local49, _local51, _size4
LEA _local50, _local49
$CLEA _local50, _zero, _local47 
$LEA _zero, _local48 
_local47:
MOV_CONST 0, _local52
MOV _phong_diffuse, _local52, _size4
_local48:
MOV _local53, phong - 12, _size4
MOV _local54, phong - 24, _size4
SUB _local53, _local53, _local54, _size4
MOV _phong_x, _local53, _size4
MOV _local55, phong - 16, _size4
MOV _local56, phong - 28, _size4
SUB _local55, _local55, _local56, _size4
MOV _phong_y, _local55, _size4
MOV _local57, phong - 20, _size4
MOV _local58, phong - 32, _size4
SUB _local57, _local57, _local58, _size4
MOV _phong_z, _local57, _size4
MOV fmul - 12, _phong_x, _size4
MOV fmul - 16, _phong_x, _size4
LEA fmul - 4, _local61
$LEA _zero, fmul
_local61:
MOV sqrt - 12, fmul - 8, _size4
MOV fmul - 12, _phong_y, _size4
MOV fmul - 16, _phong_y, _size4
LEA fmul - 4, _local63
$LEA _zero, fmul
_local63:
MOV _local60, fmul - 8, _size4
MOV fmul - 12, _phong_z, _size4
MOV fmul - 16, _phong_z, _size4
LEA fmul - 4, _local64
$LEA _zero, fmul
_local64:
MOV _local62, fmul - 8, _size4
ADD _local60, _local60, _local62, _size4
ADD sqrt - 12, sqrt - 12, _local60, _size4
LEA sqrt - 4, _local65
$LEA _zero, sqrt
_local65:
MOV _local59, sqrt - 8, _size4
MOV _phong_l, _local59, _size4
MOV _local68, _phong_l, _size4
MOV_CONST 0, _local70
LT _local68, _local70, _local68, _size4
LEA _local69, _local68
$CLEA _local69, _zero, _local66 
$LEA _zero, _local67 
_local66:
MOV fdiv - 12, _phong_x, _size4
MOV fdiv - 16, _phong_l, _size4
LEA fdiv - 4, _local72
$LEA _zero, fdiv
_local72:
MOV _local71, fdiv - 8, _size4
MOV _phong_x, _local71, _size4
MOV fdiv - 12, _phong_y, _size4
MOV fdiv - 16, _phong_l, _size4
LEA fdiv - 4, _local74
$LEA _zero, fdiv
_local74:
MOV _local73, fdiv - 8, _size4
MOV _phong_y, _local73, _size4
MOV fdiv - 12, _phong_z, _size4
MOV fdiv - 16, _phong_l, _size4
LEA fdiv - 4, _local76
$LEA _zero, fdiv
_local76:
MOV _local75, fdiv - 8, _size4
MOV _phong_z, _local75, _size4
_local67:
MOV fmul - 12, _phong_x, _size4
MOV fmul - 16, phong - 36, _size4
LEA fmul - 4, _local79
$LEA _zero, fmul
_local79:
MOV _local77, fmul - 8, _size4
MOV fmul - 12, _phong_y, _size4
MOV fmul - 16, phong - 40, _size4
LEA fmul - 4, _local81
$LEA _zero, fmul
_local81:
MOV _local78, fmul - 8, _size4
MOV fmul - 12, _phong_z, _size4
MOV fmul - 16, phong - 44, _size4
LEA fmul - 4, _local82
$LEA _zero, fmul
_local82:
MOV _local80, fmul - 8, _size4
ADD _local78, _local78, _local80, _size4
ADD _local77, _local77, _local78, _size4
MOV _phong_blink, _local77, _size4
MOV _local85, _phong_blink, _size4
MOV_CONST 0, _local87
LT _local85, _local85, _local87, _size4
LEA _local86, _local85
$CLEA _local86, _zero, _local83 
$LEA _zero, _local84 
_local83:
MOV_CONST 0, _local88
MOV _phong_blink, _local88, _size4
_local84:
MOV fmul - 12, _phong_blink, _size4
MOV fmul - 16, _phong_blink, _size4
LEA fmul - 4, _local90
$LEA _zero, fmul
_local90:
MOV _local89, fmul - 8, _size4
MOV _phong_blink, _local89, _size4
MOV fmul - 12, _phong_blink, _size4
MOV fmul - 16, _phong_blink, _size4
LEA fmul - 4, _local92
$LEA _zero, fmul
_local92:
MOV _local91, fmul - 8, _size4
MOV _phong_blink, _local91, _size4
MOV fmul - 12, _phong_blink, _size4
MOV fmul - 16, _phong_blink, _size4
LEA fmul - 4, _local94
$LEA _zero, fmul
_local94:
MOV _local93, fmul - 8, _size4
MOV _phong_l, _local93, _size4
MOV fmul - 12, _phong_blink, _size4
MOV fmul - 16, _phong_l, _size4
LEA fmul - 4, _local96
$LEA _zero, fmul
_local96:
MOV _local95, fmul - 8, _size4
MOV _phong_blink, _local95, _size4
MOV fmul - 12, _phong_blink, _size4
MOV_CONST 400, fmul - 16
LEA fmul - 4, _local98
$LEA _zero, fmul
_local98:
MOV _local97, fmul - 8, _size4
MOV _phong_blink, _local97, _size4
MOV_CONST 200, _local99
MOV _local100, _phong_diffuse, _size4
MOV _local101, _phong_blink, _size4
ADD _local100, _local100, _local101, _size4
ADD _local99, _local99, _local100, _size4
MOV _phong_ans, _local99, _size4
MOV _local104, _phong_ans, _size4
MOV_CONST 1000, _local106
LT _local104, _local106, _local104, _size4
LEA _local105, _local104
$CLEA _local105, _zero, _local102 
$LEA _zero, _local103 
_local102:
MOV_CONST 1000, _local107
MOV _phong_ans, _local107, _size4
_local103:
MOV phong - 8, _phong_ans, _size4
LEA _local108, _size4
LEA _local109, phong - 4
$MOV _zero, _local109, _local108
; arguments
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
main:
MOV_CONST 1000, _local110
MOV _main_lx, _local110, _size4
MOV_CONST 0, _local111
MOV _main_ly, _local111, _size4
MOV_CONST 0, _local112
MOV _main_lz, _local112, _size4
MOV_CONST 0, _local113
MOV _main_gx, _local113, _size4
MOV_CONST 0, _local114
MOV _main_gy, _local114, _size4
MOV_CONST -4000, _local115
MOV _main_gz, _local115, _size4
MOV_CONST 0, _local116
MOV _main_tim, _local116, _size4
LEA _local121, _local120
_local119:
MOV_CONST 1, _local120
$CLEA _local121, _zero, _local118 
$LEA _zero, _local117
_local118:
MOV_CONST 65536, _local122
MOV _main_start, _local122, _size4
MOV_CONST 65536, _local123
MOV _main_end, _local123, _size4
MOV _local124, _main_tim, _size4
MOV_CONST 1, _local125
ADD _local124, _local124, _local125, _size4
MOV _main_tim, _local124, _size4
MOV _local126, _main_lx, _size4
MOV _main_k1, _local126, _size4
MOV _local127, _main_ly, _size4
MOV _main_k2, _local127, _size4
MOV _local128, _main_lz, _size4
MOV _main_k3, _local128, _size4
MOV _local131, _main_tim, _size4
MOV _local134, _main_tim, _size4
MOV_CONST 100, _local136
DIV _local134, _local134, _local136, _size4
MOV_CONST 100, _local135
MUL _local134, _local134, _local135, _size4
SUB _local131, _local131, _local134, _size4
MOV_CONST 50, _local133
LT _local131, _local131, _local133, _size4
LEA _local132, _local131
$CLEA _local132, _zero, _local129 
MOV fmul - 12, _main_k1, _size4
MOV_CONST 995, fmul - 16
LEA fmul - 4, _local139
$LEA _zero, fmul
_local139:
MOV _local137, fmul - 8, _size4
MOV fmul - 12, _main_k2, _size4
MOV_CONST -89, fmul - 16
LEA fmul - 4, _local141
$LEA _zero, fmul
_local141:
MOV _local138, fmul - 8, _size4
MOV fmul - 12, _main_k3, _size4
MOV_CONST 19, fmul - 16
LEA fmul - 4, _local142
$LEA _zero, fmul
_local142:
MOV _local140, fmul - 8, _size4
ADD _local138, _local138, _local140, _size4
ADD _local137, _local137, _local138, _size4
MOV _main_lx, _local137, _size4
MOV fmul - 12, _main_k1, _size4
MOV_CONST 89, fmul - 16
LEA fmul - 4, _local145
$LEA _zero, fmul
_local145:
MOV _local143, fmul - 8, _size4
MOV fmul - 12, _main_k2, _size4
MOV_CONST 995, fmul - 16
LEA fmul - 4, _local147
$LEA _zero, fmul
_local147:
MOV _local144, fmul - 8, _size4
MOV fmul - 12, _main_k3, _size4
MOV_CONST -19, fmul - 16
LEA fmul - 4, _local148
$LEA _zero, fmul
_local148:
MOV _local146, fmul - 8, _size4
ADD _local144, _local144, _local146, _size4
ADD _local143, _local143, _local144, _size4
MOV _main_ly, _local143, _size4
MOV fmul - 12, _main_k1, _size4
MOV_CONST -21, fmul - 16
LEA fmul - 4, _local151
$LEA _zero, fmul
_local151:
MOV _local149, fmul - 8, _size4
MOV fmul - 12, _main_k2, _size4
MOV_CONST -18, fmul - 16
LEA fmul - 4, _local153
$LEA _zero, fmul
_local153:
MOV _local150, fmul - 8, _size4
MOV fmul - 12, _main_k3, _size4
MOV_CONST 999, fmul - 16
LEA fmul - 4, _local154
$LEA _zero, fmul
_local154:
MOV _local152, fmul - 8, _size4
ADD _local150, _local150, _local152, _size4
ADD _local149, _local149, _local150, _size4
MOV _main_lz, _local149, _size4
$LEA _zero, _local130 
_local129:
MOV fmul - 12, _main_k1, _size4
MOV_CONST 993, fmul - 16
LEA fmul - 4, _local157
$LEA _zero, fmul
_local157:
MOV _local155, fmul - 8, _size4
MOV fmul - 12, _main_k2, _size4
MOV_CONST -59, fmul - 16
LEA fmul - 4, _local159
$LEA _zero, fmul
_local159:
MOV _local156, fmul - 8, _size4
MOV fmul - 12, _main_k3, _size4
MOV_CONST 99, fmul - 16
LEA fmul - 4, _local160
$LEA _zero, fmul
_local160:
MOV _local158, fmul - 8, _size4
ADD _local156, _local156, _local158, _size4
ADD _local155, _local155, _local156, _size4
MOV _main_lx, _local155, _size4
MOV fmul - 12, _main_k1, _size4
MOV_CONST 65, fmul - 16
LEA fmul - 4, _local163
$LEA _zero, fmul
_local163:
MOV _local161, fmul - 8, _size4
MOV fmul - 12, _main_k2, _size4
MOV_CONST 996, fmul - 16
LEA fmul - 4, _local165
$LEA _zero, fmul
_local165:
MOV _local162, fmul - 8, _size4
MOV fmul - 12, _main_k3, _size4
MOV_CONST -59, fmul - 16
LEA fmul - 4, _local166
$LEA _zero, fmul
_local166:
MOV _local164, fmul - 8, _size4
ADD _local162, _local162, _local164, _size4
ADD _local161, _local161, _local162, _size4
MOV _main_ly, _local161, _size4
MOV fmul - 12, _main_k1, _size4
MOV_CONST -95, fmul - 16
LEA fmul - 4, _local169
$LEA _zero, fmul
_local169:
MOV _local167, fmul - 8, _size4
MOV fmul - 12, _main_k2, _size4
MOV_CONST 65, fmul - 16
LEA fmul - 4, _local171
$LEA _zero, fmul
_local171:
MOV _local168, fmul - 8, _size4
MOV fmul - 12, _main_k3, _size4
MOV_CONST 993, fmul - 16
LEA fmul - 4, _local172
$LEA _zero, fmul
_local172:
MOV _local170, fmul - 8, _size4
ADD _local168, _local168, _local170, _size4
ADD _local167, _local167, _local168, _size4
MOV _main_lz, _local167, _size4
_local130:
MOV fmul - 12, _main_lx, _size4
MOV fmul - 16, _main_lx, _size4
LEA fmul - 4, _local175
$LEA _zero, fmul
_local175:
MOV sqrt - 12, fmul - 8, _size4
MOV fmul - 12, _main_ly, _size4
MOV fmul - 16, _main_ly, _size4
LEA fmul - 4, _local177
$LEA _zero, fmul
_local177:
MOV _local174, fmul - 8, _size4
MOV fmul - 12, _main_lz, _size4
MOV fmul - 16, _main_lz, _size4
LEA fmul - 4, _local178
$LEA _zero, fmul
_local178:
MOV _local176, fmul - 8, _size4
ADD _local174, _local174, _local176, _size4
ADD sqrt - 12, sqrt - 12, _local174, _size4
LEA sqrt - 4, _local179
$LEA _zero, sqrt
_local179:
MOV _local173, sqrt - 8, _size4
MOV _main_t, _local173, _size4
MOV fdiv - 12, _main_lx, _size4
MOV fdiv - 16, _main_t, _size4
LEA fdiv - 4, _local181
$LEA _zero, fdiv
_local181:
MOV _local180, fdiv - 8, _size4
MOV _main_lx, _local180, _size4
MOV fdiv - 12, _main_ly, _size4
MOV fdiv - 16, _main_t, _size4
LEA fdiv - 4, _local183
$LEA _zero, fdiv
_local183:
MOV _local182, fdiv - 8, _size4
MOV _main_ly, _local182, _size4
MOV fdiv - 12, _main_lz, _size4
MOV fdiv - 16, _main_t, _size4
LEA fdiv - 4, _local185
$LEA _zero, fdiv
_local185:
MOV _local184, fdiv - 8, _size4
MOV _main_lz, _local184, _size4
MOV_CONST 0, _local186
MOV _main_y, _local186, _size4
LEA _local191, _local190
_local189:
MOV _local190, _main_y, _size4
MOV_CONST 90, _local192
LT _local190, _local190, _local192, _size4
$CLEA _local191, _zero, _local188 
$LEA _zero, _local187
_local188:
MOV_CONST 0, _local193
MOV _main_x, _local193, _size4
LEA _local198, _local197
_local196:
MOV _local197, _main_x, _size4
MOV_CONST 160, _local199
LT _local197, _local197, _local199, _size4
$CLEA _local198, _zero, _local195 
$LEA _zero, _local194
_local195:
MOV _local200, _main_x, _size4
MOV_CONST 80, _local202
SUB _local200, _local200, _local202, _size4
MOV_CONST 12, _local201
MUL _local200, _local200, _local201, _size4
MOV _main_a, _local200, _size4
MOV_CONST 45, _local203
MOV _local205, _main_y, _size4
SUB _local203, _local203, _local205, _size4
MOV_CONST 12, _local204
MUL _local203, _local203, _local204, _size4
MOV _main_b, _local203, _size4
MOV _local206, _main_a, _size4
MOV_CONST 2, _local207
DIV _local206, _local206, _local207, _size4
MOV _main_dx, _local206, _size4
MOV _local208, _main_b, _size4
MOV_CONST 2, _local209
DIV _local208, _local208, _local209, _size4
MOV _main_dy, _local208, _size4
MOV_CONST 1000, _local210
MOV _main_dz, _local210, _size4
MOV intersect_ball - 12, _main_gx, _size4
MOV intersect_ball - 16, _main_gy, _size4
MOV intersect_ball - 20, _main_gz, _size4
MOV intersect_ball - 24, _main_dx, _size4
MOV intersect_ball - 28, _main_dy, _size4
MOV intersect_ball - 32, _main_dz, _size4
MOV_CONST 0, intersect_ball - 36
MOV_CONST 0, intersect_ball - 40
MOV_CONST 5000, intersect_ball - 44
MOV_CONST 1000, intersect_ball - 48
LEA intersect_ball - 4, _local212
$LEA _zero, intersect_ball
_local212:
MOV _local211, intersect_ball - 8, _size4
MOV _main_res1, _local211, _size4
MOV _local213, _main_gx, _size4
MOV fmul - 12, _main_dx, _size4
MOV fmul - 16, _main_res1, _size4
LEA fmul - 4, _local215
$LEA _zero, fmul
_local215:
MOV _local214, fmul - 8, _size4
ADD _local213, _local213, _local214, _size4
MOV _main_px, _local213, _size4
MOV _local216, _main_gy, _size4
MOV fmul - 12, _main_dy, _size4
MOV fmul - 16, _main_res1, _size4
LEA fmul - 4, _local218
$LEA _zero, fmul
_local218:
MOV _local217, fmul - 8, _size4
ADD _local216, _local216, _local217, _size4
MOV _main_py, _local216, _size4
MOV _local219, _main_gz, _size4
MOV fmul - 12, _main_dz, _size4
MOV fmul - 16, _main_res1, _size4
LEA fmul - 4, _local221
$LEA _zero, fmul
_local221:
MOV _local220, fmul - 8, _size4
ADD _local219, _local219, _local220, _size4
MOV _main_pz, _local219, _size4
MOV _local222, _main_px, _size4
MOV_CONST 0, _local223
SUB _local222, _local222, _local223, _size4
MOV _main_nx, _local222, _size4
MOV _local224, _main_py, _size4
MOV_CONST 0, _local225
SUB _local224, _local224, _local225, _size4
MOV _main_ny, _local224, _size4
MOV _local226, _main_pz, _size4
MOV_CONST 5000, _local227
SUB _local226, _local226, _local227, _size4
MOV _main_nz, _local226, _size4
MOV _local228, _main_lx, _size4
MOV _local229, _main_px, _size4
SUB _local228, _local228, _local229, _size4
MOV _main_ldx, _local228, _size4
MOV _local230, _main_ly, _size4
MOV _local231, _main_py, _size4
SUB _local230, _local230, _local231, _size4
MOV _main_ldy, _local230, _size4
MOV _local232, _main_lz, _size4
MOV _local233, _main_pz, _size4
SUB _local232, _local232, _local233, _size4
MOV _main_ldz, _local232, _size4
MOV put4 - 12, _main_end, _size4
MOV_CONST 255, put4 - 16
MOV_CONST 255, _local235
MUL put4 - 16, put4 - 16, _local235, _size4
LEA put4 - 4, _local236
$LEA _zero, put4
_local236:
MOV _local234, put4 - 8, _size4
MOV _main_t, _local234, _size4
MOV _local239, _main_res1, _size4
MOV_CONST 0, _local241
LT _local239, _local241, _local239, _size4
LEA _local240, _local239
$CLEA _local240, _zero, _local237 
$LEA _zero, _local238 
_local237:
MOV phong - 12, _main_lx, _size4
MOV phong - 16, _main_ly, _size4
MOV phong - 20, _main_lz, _size4
MOV phong - 24, _main_dx, _size4
MOV phong - 28, _main_dy, _size4
MOV phong - 32, _main_dz, _size4
MOV phong - 36, _main_nx, _size4
MOV phong - 40, _main_ny, _size4
MOV phong - 44, _main_nz, _size4
LEA phong - 4, _local243
$LEA _zero, phong
_local243:
MOV _local242, phong - 8, _size4
MOV _main_spec, _local242, _size4
MOV_CONST 255, _local244
MOV _local246, _main_spec, _size4
MUL _local244, _local244, _local246, _size4
MOV_CONST 1000, _local245
DIV _local244, _local244, _local245, _size4
MOV _main_color, _local244, _size4
MOV put4 - 12, _main_end, _size4
MOV put4 - 16, _main_color, _size4
MOV_CONST 255, _local248
MOV _local250, _main_color, _size4
MUL _local248, _local248, _local250, _size4
MOV_CONST 65536, _local249
MOV _local251, _main_color, _size4
MUL _local249, _local249, _local251, _size4
ADD _local248, _local248, _local249, _size4
ADD put4 - 16, put4 - 16, _local248, _size4
LEA put4 - 4, _local252
$LEA _zero, put4
_local252:
MOV _local247, put4 - 8, _size4
MOV _main_t, _local247, _size4
_local238:
MOV intersect_ball - 12, _main_gx, _size4
MOV intersect_ball - 16, _main_gy, _size4
MOV intersect_ball - 20, _main_gz, _size4
MOV intersect_ball - 24, _main_dx, _size4
MOV intersect_ball - 28, _main_dy, _size4
MOV intersect_ball - 32, _main_dz, _size4
MOV_CONST 2, intersect_ball - 36
MOV _local254, _main_lx, _size4
MUL intersect_ball - 36, intersect_ball - 36, _local254, _size4
MOV_CONST 2, intersect_ball - 40
MOV _local255, _main_ly, _size4
MUL intersect_ball - 40, intersect_ball - 40, _local255, _size4
MOV_CONST 5000, intersect_ball - 44
MOV_CONST 2, _local256
MOV _local257, _main_lz, _size4
MUL _local256, _local256, _local257, _size4
ADD intersect_ball - 44, intersect_ball - 44, _local256, _size4
MOV_CONST 100, intersect_ball - 48
LEA intersect_ball - 4, _local258
$LEA _zero, intersect_ball
_local258:
MOV _local253, intersect_ball - 8, _size4
MOV _main_res2, _local253, _size4
MOV _local261, _main_res2, _size4
MOV _local264, _main_res1, _size4
LT _local261, _local261, _local264, _size4
MOV _local263, _main_res1, _size4
MOV_CONST 0, _local265
LT _local263, _local263, _local265, _size4
ADD _local261, _local261, _local263, _size4
LEA _local262, _local261
$CLEA _local262, _zero, _local259 
$LEA _zero, _local260 
_local259:
MOV _local268, _main_res2, _size4
MOV_CONST 0, _local270
LT _local268, _local270, _local268, _size4
LEA _local269, _local268
$CLEA _local269, _zero, _local266 
$LEA _zero, _local267 
_local266:
MOV put4 - 12, _main_end, _size4
MOV_CONST 255, put4 - 16
MOV_CONST 65536, _local272
MUL put4 - 16, put4 - 16, _local272, _size4
LEA put4 - 4, _local273
$LEA _zero, put4
_local273:
MOV _local271, put4 - 8, _size4
MOV _main_t, _local271, _size4
_local267:
_local260:
MOV _local274, _main_end, _size4
MOV_CONST 4, _local275
ADD _local274, _local274, _local275, _size4
MOV _main_end, _local274, _size4
MOV _local276, _main_x, _size4
MOV_CONST 1, _local277
ADD _local276, _local276, _local277, _size4
MOV _main_x, _local276, _size4
$LEA _zero, _local196 
_local194:
MOV _local278, _main_y, _size4
MOV_CONST 1, _local279
ADD _local278, _local278, _local279, _size4
MOV _main_y, _local278, _size4
$LEA _zero, _local189 
_local187:
MOV out - 12, _main_start, _size4
MOV out - 16, _main_end, _size4
MOV _local281, _main_start, _size4
SUB out - 16, out - 16, _local281, _size4
LEA out - 4, _local282
$LEA _zero, out
_local282:
MOV _local280, out - 8, _size4
MOV _main_t, _local280, _size4
$LEA _zero, _local119 
_local117:
MOV_CONST 0, main - 8
LEA _local283, _size4
LEA _local284, main - 4
$MOV _zero, _local284, _local283
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
_local33:
.dd 0
_local35:
.dd 0
_local37:
.dd 0
_phong_diffuse:
.dd 0
_local39:
.dd 0
_local40:
.dd 0
_local42:
.dd 0
_local45:
.dd 0
_local49:
.dd 0
_local50:
.dd 0
_local51:
.dd 0
_local52:
.dd 0
_phong_x:
.dd 0
_phong_y:
.dd 0
_phong_z:
.dd 0
_local53:
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
_local59:
.dd 0
_local60:
.dd 0
_local62:
.dd 0
_local68:
.dd 0
_local69:
.dd 0
_local70:
.dd 0
_local71:
.dd 0
_local73:
.dd 0
_local75:
.dd 0
_phong_blink:
.dd 0
_local77:
.dd 0
_local78:
.dd 0
_local80:
.dd 0
_local85:
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
_local97:
.dd 0
_phong_ans:
.dd 0
_local99:
.dd 0
_local100:
.dd 0
_local101:
.dd 0
_local104:
.dd 0
_local105:
.dd 0
_local106:
.dd 0
_local107:
.dd 0
_local108:
.dd 0
_local109:
.dd 0
_main_res1:
.dd 0
_main_res2:
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
_local110:
.dd 0
_local111:
.dd 0
_local112:
.dd 0
_local113:
.dd 0
_local114:
.dd 0
_local115:
.dd 0
_local116:
.dd 0
_local120:
.dd 0
_local121:
.dd 0
_main_start:
.dd 0
_main_end:
.dd 0
_local122:
.dd 0
_local123:
.dd 0
_local124:
.dd 0
_local125:
.dd 0
_main_k1:
.dd 0
_main_k2:
.dd 0
_main_k3:
.dd 0
_local126:
.dd 0
_local127:
.dd 0
_local128:
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
_local138:
.dd 0
_local140:
.dd 0
_local143:
.dd 0
_local144:
.dd 0
_local146:
.dd 0
_local149:
.dd 0
_local150:
.dd 0
_local152:
.dd 0
_local155:
.dd 0
_local156:
.dd 0
_local158:
.dd 0
_local161:
.dd 0
_local162:
.dd 0
_local164:
.dd 0
_local167:
.dd 0
_local168:
.dd 0
_local170:
.dd 0
_local173:
.dd 0
_local174:
.dd 0
_local176:
.dd 0
_local180:
.dd 0
_local182:
.dd 0
_local184:
.dd 0
_local186:
.dd 0
_local190:
.dd 0
_local191:
.dd 0
_local192:
.dd 0
_local193:
.dd 0
_local197:
.dd 0
_local198:
.dd 0
_local199:
.dd 0
_main_a:
.dd 0
_main_b:
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
_main_ldx:
.dd 0
_main_ldy:
.dd 0
_main_ldz:
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
_local213:
.dd 0
_local214:
.dd 0
_local216:
.dd 0
_local217:
.dd 0
_local219:
.dd 0
_local220:
.dd 0
_local222:
.dd 0
_local223:
.dd 0
_local224:
.dd 0
_local225:
.dd 0
_local226:
.dd 0
_local227:
.dd 0
_local228:
.dd 0
_local229:
.dd 0
_local230:
.dd 0
_local231:
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
_main_spec:
.dd 0
_local242:
.dd 0
_main_color:
.dd 0
_local244:
.dd 0
_local245:
.dd 0
_local246:
.dd 0
_local247:
.dd 0
_local248:
.dd 0
_local249:
.dd 0
_local250:
.dd 0
_local251:
.dd 0
_local253:
.dd 0
_local254:
.dd 0
_local255:
.dd 0
_local256:
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
_local268:
.dd 0
_local269:
.dd 0
_local270:
.dd 0
_local271:
.dd 0
_local272:
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
_local283:
.dd 0
_local284:
.dd 0
_size4:
.dd 4
_size1:
.dd 1
_zero:
.dd 0

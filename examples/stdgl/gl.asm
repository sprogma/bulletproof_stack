; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
hash:
MOV _local0, hash - 12, _size4
MOV_CONST 3412, _local2
MUL _local0, _local0, _local2, _size4
MOV _local1, hash - 16, _size4
MOV_CONST 1241, _local4
MUL _local1, _local1, _local4, _size4
MOV_CONST 1000000, _local3
ADD _local1, _local1, _local3, _size4
ADD _local0, _local0, _local1, _size4
MOV _hash_res, _local0, _size4
MOV hash - 8, _hash_res, _size4
MOV _local5, _hash_res, _size4
MOV_CONST 1000, _local7
DIV _local5, _local5, _local7, _size4
MOV_CONST 1000, _local6
MUL _local5, _local5, _local6, _size4
SUB hash - 8, hash - 8, _local5, _size4
LEA _local8, _size4
LEA _local9, hash - 4
$MOV _zero, _local9, _local8
; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
noise:
MOV _local10, noise - 12, _size4
MOV_CONST 1000, _local11
DIV _local10, _local10, _local11, _size4
MOV _noise_ix, _local10, _size4
MOV _local12, noise - 16, _size4
MOV_CONST 1000, _local13
DIV _local12, _local12, _local13, _size4
MOV _noise_iy, _local12, _size4
MOV _local16, noise - 12, _size4
MOV_CONST 0, _local18
LT _local16, _local16, _local18, _size4
LEA _local17, _local16
$CLEA _local17, _zero, _local14 
$LEA _zero, _local15 
_local14:
MOV _local19, _noise_ix, _size4
MOV_CONST 1, _local20
SUB _local19, _local19, _local20, _size4
MOV _noise_ix, _local19, _size4
_local15:
MOV _local23, noise - 16, _size4
MOV_CONST 0, _local25
LT _local23, _local23, _local25, _size4
LEA _local24, _local23
$CLEA _local24, _zero, _local21 
$LEA _zero, _local22 
_local21:
MOV _local26, _noise_iy, _size4
MOV_CONST 1, _local27
SUB _local26, _local26, _local27, _size4
MOV _noise_iy, _local26, _size4
_local22:
MOV _local28, noise - 12, _size4
MOV _local29, _noise_ix, _size4
MOV_CONST 1000, _local30
MUL _local29, _local29, _local30, _size4
SUB _local28, _local28, _local29, _size4
MOV _noise_fx, _local28, _size4
MOV _local31, noise - 16, _size4
MOV _local32, _noise_iy, _size4
MOV_CONST 1000, _local33
MUL _local32, _local32, _local33, _size4
SUB _local31, _local31, _local32, _size4
MOV _noise_fy, _local31, _size4
MOV hash - 12, _noise_ix, _size4
MOV hash - 16, _noise_iy, _size4
LEA hash - 4, _local35
$LEA _zero, hash
_local35:
MOV _local34, hash - 8, _size4
MOV _noise_a, _local34, _size4
MOV hash - 12, _noise_ix, _size4
MOV_CONST 1, _local37
ADD hash - 12, hash - 12, _local37, _size4
MOV hash - 16, _noise_iy, _size4
LEA hash - 4, _local38
$LEA _zero, hash
_local38:
MOV _local36, hash - 8, _size4
MOV _noise_b, _local36, _size4
MOV hash - 12, _noise_ix, _size4
MOV hash - 16, _noise_iy, _size4
MOV_CONST 1, _local40
ADD hash - 16, hash - 16, _local40, _size4
LEA hash - 4, _local41
$LEA _zero, hash
_local41:
MOV _local39, hash - 8, _size4
MOV _noise_c, _local39, _size4
MOV hash - 12, _noise_ix, _size4
MOV_CONST 1, _local43
ADD hash - 12, hash - 12, _local43, _size4
MOV hash - 16, _noise_iy, _size4
MOV_CONST 1, _local44
ADD hash - 16, hash - 16, _local44, _size4
LEA hash - 4, _local45
$LEA _zero, hash
_local45:
MOV _local42, hash - 8, _size4
MOV _noise_d, _local42, _size4
MOV fmul - 12, _noise_a, _size4
MOV_CONST 1000, fmul - 16
MOV _local48, _noise_fx, _size4
SUB fmul - 16, fmul - 16, _local48, _size4
LEA fmul - 4, _local49
$LEA _zero, fmul
_local49:
MOV _local46, fmul - 8, _size4
MOV fmul - 12, _noise_b, _size4
MOV fmul - 16, _noise_fx, _size4
LEA fmul - 4, _local50
$LEA _zero, fmul
_local50:
MOV _local47, fmul - 8, _size4
ADD _local46, _local46, _local47, _size4
MOV _noise_a, _local46, _size4
MOV fmul - 12, _noise_c, _size4
MOV_CONST 1000, fmul - 16
MOV _local53, _noise_fx, _size4
SUB fmul - 16, fmul - 16, _local53, _size4
LEA fmul - 4, _local54
$LEA _zero, fmul
_local54:
MOV _local51, fmul - 8, _size4
MOV fmul - 12, _noise_d, _size4
MOV fmul - 16, _noise_fx, _size4
LEA fmul - 4, _local55
$LEA _zero, fmul
_local55:
MOV _local52, fmul - 8, _size4
ADD _local51, _local51, _local52, _size4
MOV _noise_c, _local51, _size4
MOV fmul - 12, _noise_a, _size4
MOV_CONST 1000, fmul - 16
MOV _local58, _noise_fy, _size4
SUB fmul - 16, fmul - 16, _local58, _size4
LEA fmul - 4, _local59
$LEA _zero, fmul
_local59:
MOV _local56, fmul - 8, _size4
MOV fmul - 12, _noise_c, _size4
MOV fmul - 16, _noise_fy, _size4
LEA fmul - 4, _local60
$LEA _zero, fmul
_local60:
MOV _local57, fmul - 8, _size4
ADD _local56, _local56, _local57, _size4
MOV _noise_a, _local56, _size4
MOV _local63, _noise_a, _size4
MOV_CONST 363, _local65
LT _local63, _local63, _local65, _size4
LEA _local64, _local63
$CLEA _local64, _zero, _local61 
$LEA _zero, _local62 
_local61:
MOV noise - 8, _noise_a, _size4
MOV_CONST 4, _local66
DIV noise - 8, noise - 8, _local66, _size4
LEA _local67, _size4
LEA _local68, noise - 4
$MOV _zero, _local68, _local67
_local62:
MOV _local71, _noise_a, _size4
MOV_CONST 636, _local73
LT _local71, _local73, _local71, _size4
LEA _local72, _local71
$CLEA _local72, _zero, _local69 
$LEA _zero, _local70 
_local69:
MOV noise - 8, _noise_a, _size4
MOV_CONST 3000, _local75
ADD noise - 8, noise - 8, _local75, _size4
MOV_CONST 4, _local74
DIV noise - 8, noise - 8, _local74, _size4
LEA _local76, _size4
LEA _local77, noise - 4
$MOV _zero, _local77, _local76
_local70:
MOV_CONST 3, noise - 8
MOV _local79, _noise_a, _size4
MUL noise - 8, noise - 8, _local79, _size4
MOV_CONST 1000, _local78
SUB noise - 8, noise - 8, _local78, _size4
LEA _local80, _size4
LEA _local81, noise - 4
$MOV _zero, _local81, _local80
MOV fmul - 12, _noise_a, _size4
MOV fmul - 12, _noise_a, _size4
MOV fmul - 16, _noise_a, _size4
LEA fmul - 4, _local82
$LEA _zero, fmul
_local82:
MOV fmul - 16, fmul - 8, _size4
LEA fmul - 4, _local83
$LEA _zero, fmul
_local83:
MOV noise - 8, fmul - 8, _size4
LEA _local84, _size4
LEA _local85, noise - 4
$MOV _zero, _local85, _local84
MOV _local86, noise - 12, _size4
MOV _local87, _noise_ix, _size4
MOV_CONST 1000, _local88
MUL _local87, _local87, _local88, _size4
SUB _local86, _local86, _local87, _size4
MOV noise - 12, _local86, _size4
MOV _local89, noise - 16, _size4
MOV _local90, _noise_iy, _size4
MOV_CONST 1000, _local91
MUL _local90, _local90, _local91, _size4
SUB _local89, _local89, _local90, _size4
MOV noise - 16, _local89, _size4
MOV _local94, _noise_ix, _size4
MOV_CONST 2, _local98
DIV _local94, _local94, _local98, _size4
MOV_CONST 2, _local97
MUL _local94, _local94, _local97, _size4
MOV _local96, _noise_ix, _size4
EQ _local94, _local94, _local96, _size4
ALL _local94, _local94, _size4
LEA _local95, _local94
$CLEA _local95, _zero, _local92 
$LEA _zero, _local93 
_local92:
MOV _local101, _noise_iy, _size4
MOV_CONST 2, _local105
DIV _local101, _local101, _local105, _size4
MOV_CONST 2, _local104
MUL _local101, _local101, _local104, _size4
MOV _local103, _noise_iy, _size4
EQ _local101, _local101, _local103, _size4
ALL _local101, _local101, _size4
LEA _local102, _local101
$CLEA _local102, _zero, _local99 
$LEA _zero, _local100 
_local99:
MOV fmul - 12, noise - 12, _size4
MOV fmul - 16, noise - 12, _size4
LEA fmul - 4, _local112
$LEA _zero, fmul
_local112:
MOV _local108, fmul - 8, _size4
MOV fmul - 12, noise - 16, _size4
MOV fmul - 16, noise - 16, _size4
LEA fmul - 4, _local113
$LEA _zero, fmul
_local113:
MOV _local111, fmul - 8, _size4
ADD _local108, _local108, _local111, _size4
MOV_CONST 1000, _local110
LT _local108, _local108, _local110, _size4
LEA _local109, _local108
$CLEA _local109, _zero, _local106 
$LEA _zero, _local107 
_local106:
MOV_CONST 800, noise - 8
LEA _local114, _size4
LEA _local115, noise - 4
$MOV _zero, _local115, _local114
_local107:
_local100:
_local93:
MOV_CONST 300, noise - 8
LEA _local116, _size4
LEA _local117, noise - 4
$MOV _zero, _local117, _local116
; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
sunray:
MOV_CONST 0, _local118
MOV _sunray_t, _local118, _size4
LEA _local123, _local122
_local121:
MOV _local122, _sunray_t, _size4
MOV_CONST 100, _local124
LT _local122, _local122, _local124, _size4
$CLEA _local123, _zero, _local120 
$LEA _zero, _local119
_local120:
MOV noise - 12, sunray - 12, _size4
MOV noise - 16, sunray - 20, _size4
LEA noise - 4, _local126
$LEA _zero, noise
_local126:
MOV _local125, noise - 8, _size4
MOV _sunray_h, _local125, _size4
MOV _local129, sunray - 16, _size4
MOV _local131, _sunray_h, _size4
LT _local129, _local129, _local131, _size4
LEA _local130, _local129
$CLEA _local130, _zero, _local127 
$LEA _zero, _local128 
_local127:
MOV_CONST 0, sunray - 8
LEA _local132, _size4
LEA _local133, sunray - 4
$MOV _zero, _local133, _local132
_local128:
MOV _local134, sunray - 12, _size4
MOV_CONST 6, _local135
ADD _local134, _local134, _local135, _size4
MOV sunray - 12, _local134, _size4
MOV _local136, sunray - 16, _size4
MOV_CONST 8, _local137
ADD _local136, _local136, _local137, _size4
MOV sunray - 16, _local136, _size4
MOV _local138, sunray - 20, _size4
MOV_CONST 2, _local139
ADD _local138, _local138, _local139, _size4
MOV sunray - 20, _local138, _size4
MOV _local140, _sunray_t, _size4
MOV_CONST 1, _local141
ADD _local140, _local140, _local141, _size4
MOV _sunray_t, _local140, _size4
$LEA _zero, _local121 
_local119:
MOV_CONST 1, sunray - 8
LEA _local142, _size4
LEA _local143, sunray - 4
$MOV _zero, _local143, _local142
; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
sun_dif:
MOV noise - 12, sun_dif - 12, _size4
MOV noise - 16, sun_dif - 16, _size4
LEA noise - 4, _local145
$LEA _zero, noise
_local145:
MOV _local144, noise - 8, _size4
MOV _sun_dif_a, _local144, _size4
MOV noise - 12, sun_dif - 12, _size4
MOV_CONST 90, _local147
SUB noise - 12, noise - 12, _local147, _size4
MOV noise - 16, sun_dif - 16, _size4
MOV_CONST 30, _local148
SUB noise - 16, noise - 16, _local148, _size4
LEA noise - 4, _local149
$LEA _zero, noise
_local149:
MOV _local146, noise - 8, _size4
MOV _sun_dif_b, _local146, _size4
MOV _local152, _sun_dif_a, _size4
MOV _local155, _sun_dif_b, _size4
SUB _local152, _local152, _local155, _size4
MOV_CONST 40, _local154
LT _local152, _local152, _local154, _size4
LEA _local153, _local152
$CLEA _local153, _zero, _local150 
$LEA _zero, _local151 
_local150:
MOV _local158, _sun_dif_b, _size4
MOV _local161, _sun_dif_a, _size4
SUB _local158, _local158, _local161, _size4
MOV_CONST 40, _local160
LT _local158, _local158, _local160, _size4
LEA _local159, _local158
$CLEA _local159, _zero, _local156 
$LEA _zero, _local157 
_local156:
MOV_CONST 750, sun_dif - 8
MOV fdiv - 12, _sun_dif_a, _size4
MOV _local163, _sun_dif_b, _size4
SUB fdiv - 12, fdiv - 12, _local163, _size4
MOV_CONST 200, fdiv - 16
LEA fdiv - 4, _local164
$LEA _zero, fdiv
_local164:
MOV _local162, fdiv - 8, _size4
ADD sun_dif - 8, sun_dif - 8, _local162, _size4
LEA _local165, _size4
LEA _local166, sun_dif - 4
$MOV _zero, _local166, _local165
_local157:
_local151:
MOV _local169, _sun_dif_a, _size4
MOV _local171, _sun_dif_b, _size4
LT _local169, _local171, _local169, _size4
LEA _local170, _local169
$CLEA _local170, _zero, _local167 
$LEA _zero, _local168 
_local167:
MOV_CONST 1000, sun_dif - 8
LEA _local172, _size4
LEA _local173, sun_dif - 4
$MOV _zero, _local173, _local172
_local168:
MOV_CONST 500, sun_dif - 8
LEA _local174, _size4
LEA _local175, sun_dif - 4
$MOV _zero, _local175, _local174
; arguments
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
ray:
MOV_CONST 0, _local176
MOV _ray_t, _local176, _size4
LEA _local181, _local180
_local179:
MOV _local180, _ray_t, _size4
MOV_CONST 100, _local182
LT _local180, _local180, _local182, _size4
$CLEA _local181, _zero, _local178 
$LEA _zero, _local177
_local178:
MOV noise - 12, ray - 12, _size4
MOV noise - 16, ray - 20, _size4
LEA noise - 4, _local184
$LEA _zero, noise
_local184:
MOV _local183, noise - 8, _size4
MOV _ray_h, _local183, _size4
MOV _local187, ray - 16, _size4
MOV _local189, _ray_h, _size4
LT _local187, _local189, _local187, _size4
LEA _local188, _local187
$CLEA _local188, _zero, _local185 
$LEA _zero, _local186 
_local185:
MOV _local190, ray - 12, _size4
MOV fmul - 12, ray - 24, _size4
MOV_CONST 50, fmul - 16
LEA fmul - 4, _local192
$LEA _zero, fmul
_local192:
MOV _local191, fmul - 8, _size4
ADD _local190, _local190, _local191, _size4
MOV ray - 12, _local190, _size4
MOV _local193, ray - 16, _size4
MOV fmul - 12, ray - 28, _size4
MOV_CONST 50, fmul - 16
LEA fmul - 4, _local195
$LEA _zero, fmul
_local195:
MOV _local194, fmul - 8, _size4
ADD _local193, _local193, _local194, _size4
MOV ray - 16, _local193, _size4
MOV _local196, ray - 20, _size4
MOV fmul - 12, ray - 32, _size4
MOV_CONST 50, fmul - 16
LEA fmul - 4, _local198
$LEA _zero, fmul
_local198:
MOV _local197, fmul - 8, _size4
ADD _local196, _local196, _local197, _size4
MOV ray - 20, _local196, _size4
_local186:
MOV _local199, _ray_t, _size4
MOV_CONST 1, _local200
ADD _local199, _local199, _local200, _size4
MOV _ray_t, _local199, _size4
$LEA _zero, _local179 
_local177:
MOV _local203, ray - 16, _size4
MOV _local206, _ray_h, _size4
SUB _local203, _local203, _local206, _size4
MOV_CONST 200, _local205
LT _local203, _local205, _local203, _size4
LEA _local204, _local203
$CLEA _local204, _zero, _local201 
$LEA _zero, _local202 
_local201:
MOV_CONST 1000, ray - 8
LEA _local207, _size4
LEA _local208, ray - 4
$MOV _zero, _local208, _local207
_local202:
MOV_CONST 0, _local211
LEA _local212, _local211
$CLEA _local212, _zero, _local209 
$LEA _zero, _local210 
_local209:
MOV fmul - 12, _ray_h, _size4
MOV sun_dif - 12, ray - 12, _size4
MOV sun_dif - 16, ray - 20, _size4
LEA sun_dif - 4, _local214
$LEA _zero, sun_dif
_local214:
MOV fmul - 16, sun_dif - 8, _size4
LEA fmul - 4, _local215
$LEA _zero, fmul
_local215:
MOV _local213, fmul - 8, _size4
MOV _ray_h, _local213, _size4
_local210:
MOV_CONST 0, _local218
LEA _local219, _local218
$CLEA _local219, _zero, _local216 
$LEA _zero, _local217 
_local216:
MOV sunray - 12, ray - 12, _size4
MOV sunray - 16, ray - 16, _size4
MOV_CONST 30, _local225
ADD sunray - 16, sunray - 16, _local225, _size4
MOV sunray - 20, ray - 20, _size4
LEA sunray - 4, _local226
$LEA _zero, sunray
_local226:
MOV _local222, sunray - 8, _size4
MOV_CONST 0, _local224
EQ _local222, _local222, _local224, _size4
ALL _local222, _local222, _size4
LEA _local223, _local222
$CLEA _local223, _zero, _local220 
$LEA _zero, _local221 
_local220:
MOV ray - 8, _ray_h, _size4
MOV_CONST 2, _local227
DIV ray - 8, ray - 8, _local227, _size4
LEA _local228, _size4
LEA _local229, ray - 4
$MOV _zero, _local229, _local228
_local221:
_local217:
MOV ray - 8, _ray_h, _size4
LEA _local230, _size4
LEA _local231, ray - 4
$MOV _zero, _local231, _local230
; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
draw:
MOV_CONST 65536, _local232
MOV _draw_start, _local232, _size4
MOV_CONST 65536, _local233
MOV _draw_end, _local233, _size4
MOV_CONST 0, _local234
MOV _draw_y, _local234, _size4
LEA _local239, _local238
_local237:
MOV _local238, _draw_y, _size4
MOV_CONST 90, _local240
LT _local238, _local238, _local240, _size4
$CLEA _local239, _zero, _local236 
$LEA _zero, _local235
_local236:
MOV_CONST 0, _local241
MOV _draw_x, _local241, _size4
LEA _local246, _local245
_local244:
MOV _local245, _draw_x, _size4
MOV_CONST 160, _local247
LT _local245, _local245, _local247, _size4
$CLEA _local246, _zero, _local243 
$LEA _zero, _local242
_local243:
MOV f - 12, _draw_x, _size4
MOV_CONST 80, _local249
SUB f - 12, f - 12, _local249, _size4
LEA f - 4, _local250
$LEA _zero, f
_local250:
MOV fdiv - 12, f - 8, _size4
MOV_CONST 45, f - 12
LEA f - 4, _local251
$LEA _zero, f
_local251:
MOV fdiv - 16, f - 8, _size4
LEA fdiv - 4, _local252
$LEA _zero, fdiv
_local252:
MOV _local248, fdiv - 8, _size4
MOV _draw_a, _local248, _size4
MOV_CONST 45, f - 12
MOV _local254, _draw_y, _size4
SUB f - 12, f - 12, _local254, _size4
LEA f - 4, _local255
$LEA _zero, f
_local255:
MOV fdiv - 12, f - 8, _size4
MOV_CONST 45, f - 12
LEA f - 4, _local256
$LEA _zero, f
_local256:
MOV fdiv - 16, f - 8, _size4
LEA fdiv - 4, _local257
$LEA _zero, fdiv
_local257:
MOV _local253, fdiv - 8, _size4
MOV _draw_b, _local253, _size4
MOV ray - 12, draw - 12, _size4
MOV ray - 16, draw - 16, _size4
MOV ray - 20, draw - 20, _size4
MOV ray - 24, _draw_a, _size4
MOV_CONST 2, _local259
DIV ray - 24, ray - 24, _local259, _size4
MOV ray - 28, _draw_b, _size4
MOV_CONST 2, _local261
DIV ray - 28, ray - 28, _local261, _size4
MOV_CONST 180, _local260
SUB ray - 28, ray - 28, _local260, _size4
MOV_CONST 1000, ray - 32
LEA ray - 4, _local262
$LEA _zero, ray
_local262:
MOV _local258, ray - 8, _size4
MOV _draw_c, _local258, _size4
MOV_CONST 255, _local263
MOV _local265, _draw_c, _size4
MUL _local263, _local263, _local265, _size4
MOV_CONST 1000, _local264
DIV _local263, _local263, _local264, _size4
MOV _draw_c, _local263, _size4
MOV put4 - 12, _draw_end, _size4
MOV put4 - 16, _draw_c, _size4
MOV_CONST 65536, _local268
MUL put4 - 16, put4 - 16, _local268, _size4
MOV _local267, _draw_c, _size4
MOV_CONST 256, _local270
MUL _local267, _local267, _local270, _size4
MOV _local269, _draw_c, _size4
ADD _local267, _local267, _local269, _size4
ADD put4 - 16, put4 - 16, _local267, _size4
LEA put4 - 4, _local271
$LEA _zero, put4
_local271:
MOV _local266, put4 - 8, _size4
MOV _draw_t, _local266, _size4
MOV _local272, _draw_end, _size4
MOV_CONST 4, _local273
ADD _local272, _local272, _local273, _size4
MOV _draw_end, _local272, _size4
MOV _local274, _draw_x, _size4
MOV_CONST 1, _local275
ADD _local274, _local274, _local275, _size4
MOV _draw_x, _local274, _size4
$LEA _zero, _local244 
_local242:
MOV _local276, _draw_y, _size4
MOV_CONST 1, _local277
ADD _local276, _local276, _local277, _size4
MOV _draw_y, _local276, _size4
$LEA _zero, _local237 
_local235:
MOV out - 12, _draw_start, _size4
MOV out - 16, _draw_end, _size4
MOV _local279, _draw_start, _size4
SUB out - 16, out - 16, _local279, _size4
LEA out - 4, _local280
$LEA _zero, out
_local280:
MOV _local278, out - 8, _size4
MOV _draw_t, _local278, _size4
MOV_CONST 0, draw - 8
LEA _local281, _size4
LEA _local282, draw - 4
$MOV _zero, _local282, _local281
; arguments
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
main:
MOV_CONST 0, _local283
MOV _main_x, _local283, _size4
MOV_CONST 1600, _local284
MOV _main_y, _local284, _size4
MOV_CONST -2000, _local285
MOV _main_z, _local285, _size4
LEA _local290, _local289
_local288:
MOV_CONST 1, _local289
$CLEA _local290, _zero, _local287 
$LEA _zero, _local286
_local287:
MOV draw - 12, _main_x, _size4
MOV draw - 16, _main_y, _size4
MOV draw - 20, _main_z, _size4
LEA draw - 4, _local292
$LEA _zero, draw
_local292:
MOV _local291, draw - 8, _size4
MOV _main_t, _local291, _size4
MOV _local293, _main_z, _size4
MOV_CONST 300, _local294
ADD _local293, _local293, _local294, _size4
MOV _main_z, _local293, _size4
MOV _local295, _main_x, _size4
MOV_CONST 100, _local296
ADD _local295, _local295, _local296, _size4
MOV _main_x, _local295, _size4
$LEA _zero, _local288 
_local286:
MOV_CONST 0, main - 8
LEA _local297, _size4
LEA _local298, main - 4
$MOV _zero, _local298, _local297
_hash_res:
.dd 0
_local0:
.dd 0
_local1:
.dd 0
_local2:
.dd 0
_local3:
.dd 0
_local4:
.dd 0
_local5:
.dd 0
_local6:
.dd 0
_local7:
.dd 0
_local8:
.dd 0
_local9:
.dd 0
_noise_ix:
.dd 0
_noise_iy:
.dd 0
_local10:
.dd 0
_local11:
.dd 0
_local12:
.dd 0
_local13:
.dd 0
_local16:
.dd 0
_local17:
.dd 0
_local18:
.dd 0
_local19:
.dd 0
_local20:
.dd 0
_local23:
.dd 0
_local24:
.dd 0
_local25:
.dd 0
_local26:
.dd 0
_local27:
.dd 0
_noise_fx:
.dd 0
_noise_fy:
.dd 0
_local28:
.dd 0
_local29:
.dd 0
_local30:
.dd 0
_local31:
.dd 0
_local32:
.dd 0
_local33:
.dd 0
_noise_a:
.dd 0
_noise_b:
.dd 0
_noise_c:
.dd 0
_noise_d:
.dd 0
_local34:
.dd 0
_local36:
.dd 0
_local37:
.dd 0
_local39:
.dd 0
_local40:
.dd 0
_local42:
.dd 0
_local43:
.dd 0
_local44:
.dd 0
_local46:
.dd 0
_local47:
.dd 0
_local48:
.dd 0
_local51:
.dd 0
_local52:
.dd 0
_local53:
.dd 0
_local56:
.dd 0
_local57:
.dd 0
_local58:
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
_local79:
.dd 0
_local80:
.dd 0
_local81:
.dd 0
_local84:
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
_local90:
.dd 0
_local91:
.dd 0
_local94:
.dd 0
_local95:
.dd 0
_local96:
.dd 0
_local97:
.dd 0
_local98:
.dd 0
_local101:
.dd 0
_local102:
.dd 0
_local103:
.dd 0
_local104:
.dd 0
_local105:
.dd 0
_local108:
.dd 0
_local109:
.dd 0
_local110:
.dd 0
_local111:
.dd 0
_local114:
.dd 0
_local115:
.dd 0
_local116:
.dd 0
_local117:
.dd 0
_sunray_t:
.dd 0
_sunray_h:
.dd 0
_local118:
.dd 0
_local122:
.dd 0
_local123:
.dd 0
_local124:
.dd 0
_local125:
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
_local138:
.dd 0
_local139:
.dd 0
_local140:
.dd 0
_local141:
.dd 0
_local142:
.dd 0
_local143:
.dd 0
_sun_dif_a:
.dd 0
_sun_dif_b:
.dd 0
_local144:
.dd 0
_local146:
.dd 0
_local147:
.dd 0
_local148:
.dd 0
_local152:
.dd 0
_local153:
.dd 0
_local154:
.dd 0
_local155:
.dd 0
_local158:
.dd 0
_local159:
.dd 0
_local160:
.dd 0
_local161:
.dd 0
_local162:
.dd 0
_local163:
.dd 0
_local165:
.dd 0
_local166:
.dd 0
_local169:
.dd 0
_local170:
.dd 0
_local171:
.dd 0
_local172:
.dd 0
_local173:
.dd 0
_local174:
.dd 0
_local175:
.dd 0
_ray_t:
.dd 0
_local176:
.dd 0
_ray_h:
.dd 0
_local180:
.dd 0
_local181:
.dd 0
_local182:
.dd 0
_local183:
.dd 0
_local187:
.dd 0
_local188:
.dd 0
_local189:
.dd 0
_local190:
.dd 0
_local191:
.dd 0
_local193:
.dd 0
_local194:
.dd 0
_local196:
.dd 0
_local197:
.dd 0
_local199:
.dd 0
_local200:
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
_local211:
.dd 0
_local212:
.dd 0
_local213:
.dd 0
_local218:
.dd 0
_local219:
.dd 0
_local222:
.dd 0
_local223:
.dd 0
_local224:
.dd 0
_local225:
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
_draw_t:
.dd 0
_draw_start:
.dd 0
_draw_end:
.dd 0
_draw_x:
.dd 0
_draw_y:
.dd 0
_draw_a:
.dd 0
_draw_b:
.dd 0
_local232:
.dd 0
_local233:
.dd 0
_local234:
.dd 0
_local238:
.dd 0
_local239:
.dd 0
_local240:
.dd 0
_local241:
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
_local253:
.dd 0
_local254:
.dd 0
_draw_c:
.dd 0
_local258:
.dd 0
_local259:
.dd 0
_local260:
.dd 0
_local261:
.dd 0
_local263:
.dd 0
_local264:
.dd 0
_local265:
.dd 0
_local266:
.dd 0
_local267:
.dd 0
_local268:
.dd 0
_local269:
.dd 0
_local270:
.dd 0
_local272:
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
_local281:
.dd 0
_local282:
.dd 0
_main_t:
.dd 0
_main_x:
.dd 0
_main_y:
.dd 0
_main_z:
.dd 0
_local283:
.dd 0
_local284:
.dd 0
_local285:
.dd 0
_local289:
.dd 0
_local290:
.dd 0
_local291:
.dd 0
_local293:
.dd 0
_local294:
.dd 0
_local295:
.dd 0
_local296:
.dd 0
_local297:
.dd 0
_local298:
.dd 0
_size4:
.dd 4
_size1:
.dd 1
_zero:
.dd 0

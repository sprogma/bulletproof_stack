
LEA main - 4, end_proc
$LEA __ld_zero, main
end_proc:
; like HLT instruction
.db 0xFF
__ld_zero:
.dd 0
; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
hash:
MOV _0gl__local0, hash - 12, _0gl__size4
MOV_CONST 3412, _0gl__local2
MUL _0gl__local0, _0gl__local0, _0gl__local2, _0gl__size4
MOV _0gl__local1, hash - 16, _0gl__size4
MOV_CONST 1241, _0gl__local4
MUL _0gl__local1, _0gl__local1, _0gl__local4, _0gl__size4
MOV_CONST 1000000, _0gl__local3
ADD _0gl__local1, _0gl__local1, _0gl__local3, _0gl__size4
ADD _0gl__local0, _0gl__local0, _0gl__local1, _0gl__size4
MOV _0gl__hash_res, _0gl__local0, _0gl__size4
MOV hash - 8, _0gl__hash_res, _0gl__size4
MOV _0gl__local5, _0gl__hash_res, _0gl__size4
MOV_CONST 1000, _0gl__local7
DIV _0gl__local5, _0gl__local5, _0gl__local7, _0gl__size4
MOV_CONST 1000, _0gl__local6
MUL _0gl__local5, _0gl__local5, _0gl__local6, _0gl__size4
SUB hash - 8, hash - 8, _0gl__local5, _0gl__size4
LEA _0gl__local8, _0gl__size4
LEA _0gl__local9, hash - 4
$MOV _0gl__zero, _0gl__local9, _0gl__local8
; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
noise:
MOV _0gl__local10, noise - 12, _0gl__size4
MOV_CONST 1000, _0gl__local11
DIV _0gl__local10, _0gl__local10, _0gl__local11, _0gl__size4
MOV _0gl__noise_ix, _0gl__local10, _0gl__size4
MOV _0gl__local12, noise - 16, _0gl__size4
MOV_CONST 1000, _0gl__local13
DIV _0gl__local12, _0gl__local12, _0gl__local13, _0gl__size4
MOV _0gl__noise_iy, _0gl__local12, _0gl__size4
MOV _0gl__local16, noise - 12, _0gl__size4
MOV_CONST 0, _0gl__local18
LT _0gl__local16, _0gl__local16, _0gl__local18, _0gl__size4
LEA _0gl__local17, _0gl__local16
$CLEA _0gl__local17, _0gl__zero, _0gl__local14 
$LEA _0gl__zero, _0gl__local15 
_0gl__local14:
MOV _0gl__local19, _0gl__noise_ix, _0gl__size4
MOV_CONST 1, _0gl__local20
SUB _0gl__local19, _0gl__local19, _0gl__local20, _0gl__size4
MOV _0gl__noise_ix, _0gl__local19, _0gl__size4
_0gl__local15:
MOV _0gl__local23, noise - 16, _0gl__size4
MOV_CONST 0, _0gl__local25
LT _0gl__local23, _0gl__local23, _0gl__local25, _0gl__size4
LEA _0gl__local24, _0gl__local23
$CLEA _0gl__local24, _0gl__zero, _0gl__local21 
$LEA _0gl__zero, _0gl__local22 
_0gl__local21:
MOV _0gl__local26, _0gl__noise_iy, _0gl__size4
MOV_CONST 1, _0gl__local27
SUB _0gl__local26, _0gl__local26, _0gl__local27, _0gl__size4
MOV _0gl__noise_iy, _0gl__local26, _0gl__size4
_0gl__local22:
MOV _0gl__local28, noise - 12, _0gl__size4
MOV _0gl__local29, _0gl__noise_ix, _0gl__size4
MOV_CONST 1000, _0gl__local30
MUL _0gl__local29, _0gl__local29, _0gl__local30, _0gl__size4
SUB _0gl__local28, _0gl__local28, _0gl__local29, _0gl__size4
MOV _0gl__noise_fx, _0gl__local28, _0gl__size4
MOV _0gl__local31, noise - 16, _0gl__size4
MOV _0gl__local32, _0gl__noise_iy, _0gl__size4
MOV_CONST 1000, _0gl__local33
MUL _0gl__local32, _0gl__local32, _0gl__local33, _0gl__size4
SUB _0gl__local31, _0gl__local31, _0gl__local32, _0gl__size4
MOV _0gl__noise_fy, _0gl__local31, _0gl__size4
MOV hash - 12, _0gl__noise_ix, _0gl__size4
MOV hash - 16, _0gl__noise_iy, _0gl__size4
LEA hash - 4, _0gl__local35
$LEA _0gl__zero, hash
_0gl__local35:
MOV _0gl__local34, hash - 8, _0gl__size4
MOV _0gl__noise_a, _0gl__local34, _0gl__size4
MOV hash - 12, _0gl__noise_ix, _0gl__size4
MOV_CONST 1, _0gl__local37
ADD hash - 12, hash - 12, _0gl__local37, _0gl__size4
MOV hash - 16, _0gl__noise_iy, _0gl__size4
LEA hash - 4, _0gl__local38
$LEA _0gl__zero, hash
_0gl__local38:
MOV _0gl__local36, hash - 8, _0gl__size4
MOV _0gl__noise_b, _0gl__local36, _0gl__size4
MOV hash - 12, _0gl__noise_ix, _0gl__size4
MOV hash - 16, _0gl__noise_iy, _0gl__size4
MOV_CONST 1, _0gl__local40
ADD hash - 16, hash - 16, _0gl__local40, _0gl__size4
LEA hash - 4, _0gl__local41
$LEA _0gl__zero, hash
_0gl__local41:
MOV _0gl__local39, hash - 8, _0gl__size4
MOV _0gl__noise_c, _0gl__local39, _0gl__size4
MOV hash - 12, _0gl__noise_ix, _0gl__size4
MOV_CONST 1, _0gl__local43
ADD hash - 12, hash - 12, _0gl__local43, _0gl__size4
MOV hash - 16, _0gl__noise_iy, _0gl__size4
MOV_CONST 1, _0gl__local44
ADD hash - 16, hash - 16, _0gl__local44, _0gl__size4
LEA hash - 4, _0gl__local45
$LEA _0gl__zero, hash
_0gl__local45:
MOV _0gl__local42, hash - 8, _0gl__size4
MOV _0gl__noise_d, _0gl__local42, _0gl__size4
MOV fmul - 12, _0gl__noise_a, _0gl__size4
MOV_CONST 1000, fmul - 16
MOV _0gl__local48, _0gl__noise_fx, _0gl__size4
SUB fmul - 16, fmul - 16, _0gl__local48, _0gl__size4
LEA fmul - 4, _0gl__local49
$LEA _0gl__zero, fmul
_0gl__local49:
MOV _0gl__local46, fmul - 8, _0gl__size4
MOV fmul - 12, _0gl__noise_b, _0gl__size4
MOV fmul - 16, _0gl__noise_fx, _0gl__size4
LEA fmul - 4, _0gl__local50
$LEA _0gl__zero, fmul
_0gl__local50:
MOV _0gl__local47, fmul - 8, _0gl__size4
ADD _0gl__local46, _0gl__local46, _0gl__local47, _0gl__size4
MOV _0gl__noise_a, _0gl__local46, _0gl__size4
MOV fmul - 12, _0gl__noise_c, _0gl__size4
MOV_CONST 1000, fmul - 16
MOV _0gl__local53, _0gl__noise_fx, _0gl__size4
SUB fmul - 16, fmul - 16, _0gl__local53, _0gl__size4
LEA fmul - 4, _0gl__local54
$LEA _0gl__zero, fmul
_0gl__local54:
MOV _0gl__local51, fmul - 8, _0gl__size4
MOV fmul - 12, _0gl__noise_d, _0gl__size4
MOV fmul - 16, _0gl__noise_fx, _0gl__size4
LEA fmul - 4, _0gl__local55
$LEA _0gl__zero, fmul
_0gl__local55:
MOV _0gl__local52, fmul - 8, _0gl__size4
ADD _0gl__local51, _0gl__local51, _0gl__local52, _0gl__size4
MOV _0gl__noise_c, _0gl__local51, _0gl__size4
MOV fmul - 12, _0gl__noise_a, _0gl__size4
MOV_CONST 1000, fmul - 16
MOV _0gl__local58, _0gl__noise_fy, _0gl__size4
SUB fmul - 16, fmul - 16, _0gl__local58, _0gl__size4
LEA fmul - 4, _0gl__local59
$LEA _0gl__zero, fmul
_0gl__local59:
MOV _0gl__local56, fmul - 8, _0gl__size4
MOV fmul - 12, _0gl__noise_c, _0gl__size4
MOV fmul - 16, _0gl__noise_fy, _0gl__size4
LEA fmul - 4, _0gl__local60
$LEA _0gl__zero, fmul
_0gl__local60:
MOV _0gl__local57, fmul - 8, _0gl__size4
ADD _0gl__local56, _0gl__local56, _0gl__local57, _0gl__size4
MOV _0gl__noise_a, _0gl__local56, _0gl__size4
MOV _0gl__local63, _0gl__noise_a, _0gl__size4
MOV_CONST 363, _0gl__local65
LT _0gl__local63, _0gl__local63, _0gl__local65, _0gl__size4
LEA _0gl__local64, _0gl__local63
$CLEA _0gl__local64, _0gl__zero, _0gl__local61 
$LEA _0gl__zero, _0gl__local62 
_0gl__local61:
MOV noise - 8, _0gl__noise_a, _0gl__size4
MOV_CONST 4, _0gl__local66
DIV noise - 8, noise - 8, _0gl__local66, _0gl__size4
LEA _0gl__local67, _0gl__size4
LEA _0gl__local68, noise - 4
$MOV _0gl__zero, _0gl__local68, _0gl__local67
_0gl__local62:
MOV _0gl__local71, _0gl__noise_a, _0gl__size4
MOV_CONST 636, _0gl__local73
LT _0gl__local71, _0gl__local73, _0gl__local71, _0gl__size4
LEA _0gl__local72, _0gl__local71
$CLEA _0gl__local72, _0gl__zero, _0gl__local69 
$LEA _0gl__zero, _0gl__local70 
_0gl__local69:
MOV noise - 8, _0gl__noise_a, _0gl__size4
MOV_CONST 3000, _0gl__local75
ADD noise - 8, noise - 8, _0gl__local75, _0gl__size4
MOV_CONST 4, _0gl__local74
DIV noise - 8, noise - 8, _0gl__local74, _0gl__size4
LEA _0gl__local76, _0gl__size4
LEA _0gl__local77, noise - 4
$MOV _0gl__zero, _0gl__local77, _0gl__local76
_0gl__local70:
MOV_CONST 3, noise - 8
MOV _0gl__local79, _0gl__noise_a, _0gl__size4
MUL noise - 8, noise - 8, _0gl__local79, _0gl__size4
MOV_CONST 1000, _0gl__local78
SUB noise - 8, noise - 8, _0gl__local78, _0gl__size4
LEA _0gl__local80, _0gl__size4
LEA _0gl__local81, noise - 4
$MOV _0gl__zero, _0gl__local81, _0gl__local80
MOV fmul - 12, _0gl__noise_a, _0gl__size4
MOV fmul - 12, _0gl__noise_a, _0gl__size4
MOV fmul - 16, _0gl__noise_a, _0gl__size4
LEA fmul - 4, _0gl__local82
$LEA _0gl__zero, fmul
_0gl__local82:
MOV fmul - 16, fmul - 8, _0gl__size4
LEA fmul - 4, _0gl__local83
$LEA _0gl__zero, fmul
_0gl__local83:
MOV noise - 8, fmul - 8, _0gl__size4
LEA _0gl__local84, _0gl__size4
LEA _0gl__local85, noise - 4
$MOV _0gl__zero, _0gl__local85, _0gl__local84
MOV _0gl__local86, noise - 12, _0gl__size4
MOV _0gl__local87, _0gl__noise_ix, _0gl__size4
MOV_CONST 1000, _0gl__local88
MUL _0gl__local87, _0gl__local87, _0gl__local88, _0gl__size4
SUB _0gl__local86, _0gl__local86, _0gl__local87, _0gl__size4
MOV noise - 12, _0gl__local86, _0gl__size4
MOV _0gl__local89, noise - 16, _0gl__size4
MOV _0gl__local90, _0gl__noise_iy, _0gl__size4
MOV_CONST 1000, _0gl__local91
MUL _0gl__local90, _0gl__local90, _0gl__local91, _0gl__size4
SUB _0gl__local89, _0gl__local89, _0gl__local90, _0gl__size4
MOV noise - 16, _0gl__local89, _0gl__size4
MOV _0gl__local94, _0gl__noise_ix, _0gl__size4
MOV_CONST 2, _0gl__local98
DIV _0gl__local94, _0gl__local94, _0gl__local98, _0gl__size4
MOV_CONST 2, _0gl__local97
MUL _0gl__local94, _0gl__local94, _0gl__local97, _0gl__size4
MOV _0gl__local96, _0gl__noise_ix, _0gl__size4
EQ _0gl__local94, _0gl__local94, _0gl__local96, _0gl__size4
ALL _0gl__local94, _0gl__local94, _0gl__size4
LEA _0gl__local95, _0gl__local94
$CLEA _0gl__local95, _0gl__zero, _0gl__local92 
$LEA _0gl__zero, _0gl__local93 
_0gl__local92:
MOV _0gl__local101, _0gl__noise_iy, _0gl__size4
MOV_CONST 2, _0gl__local105
DIV _0gl__local101, _0gl__local101, _0gl__local105, _0gl__size4
MOV_CONST 2, _0gl__local104
MUL _0gl__local101, _0gl__local101, _0gl__local104, _0gl__size4
MOV _0gl__local103, _0gl__noise_iy, _0gl__size4
EQ _0gl__local101, _0gl__local101, _0gl__local103, _0gl__size4
ALL _0gl__local101, _0gl__local101, _0gl__size4
LEA _0gl__local102, _0gl__local101
$CLEA _0gl__local102, _0gl__zero, _0gl__local99 
$LEA _0gl__zero, _0gl__local100 
_0gl__local99:
MOV fmul - 12, noise - 12, _0gl__size4
MOV fmul - 16, noise - 12, _0gl__size4
LEA fmul - 4, _0gl__local112
$LEA _0gl__zero, fmul
_0gl__local112:
MOV _0gl__local108, fmul - 8, _0gl__size4
MOV fmul - 12, noise - 16, _0gl__size4
MOV fmul - 16, noise - 16, _0gl__size4
LEA fmul - 4, _0gl__local113
$LEA _0gl__zero, fmul
_0gl__local113:
MOV _0gl__local111, fmul - 8, _0gl__size4
ADD _0gl__local108, _0gl__local108, _0gl__local111, _0gl__size4
MOV_CONST 1000, _0gl__local110
LT _0gl__local108, _0gl__local108, _0gl__local110, _0gl__size4
LEA _0gl__local109, _0gl__local108
$CLEA _0gl__local109, _0gl__zero, _0gl__local106 
$LEA _0gl__zero, _0gl__local107 
_0gl__local106:
MOV_CONST 800, noise - 8
LEA _0gl__local114, _0gl__size4
LEA _0gl__local115, noise - 4
$MOV _0gl__zero, _0gl__local115, _0gl__local114
_0gl__local107:
_0gl__local100:
_0gl__local93:
MOV_CONST 300, noise - 8
LEA _0gl__local116, _0gl__size4
LEA _0gl__local117, noise - 4
$MOV _0gl__zero, _0gl__local117, _0gl__local116
; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
sunray:
MOV_CONST 0, _0gl__local118
MOV _0gl__sunray_t, _0gl__local118, _0gl__size4
LEA _0gl__local123, _0gl__local122
_0gl__local121:
MOV _0gl__local122, _0gl__sunray_t, _0gl__size4
MOV_CONST 100, _0gl__local124
LT _0gl__local122, _0gl__local122, _0gl__local124, _0gl__size4
$CLEA _0gl__local123, _0gl__zero, _0gl__local120 
$LEA _0gl__zero, _0gl__local119
_0gl__local120:
MOV noise - 12, sunray - 12, _0gl__size4
MOV noise - 16, sunray - 20, _0gl__size4
LEA noise - 4, _0gl__local126
$LEA _0gl__zero, noise
_0gl__local126:
MOV _0gl__local125, noise - 8, _0gl__size4
MOV _0gl__sunray_h, _0gl__local125, _0gl__size4
MOV _0gl__local129, sunray - 16, _0gl__size4
MOV _0gl__local131, _0gl__sunray_h, _0gl__size4
LT _0gl__local129, _0gl__local129, _0gl__local131, _0gl__size4
LEA _0gl__local130, _0gl__local129
$CLEA _0gl__local130, _0gl__zero, _0gl__local127 
$LEA _0gl__zero, _0gl__local128 
_0gl__local127:
MOV_CONST 0, sunray - 8
LEA _0gl__local132, _0gl__size4
LEA _0gl__local133, sunray - 4
$MOV _0gl__zero, _0gl__local133, _0gl__local132
_0gl__local128:
MOV _0gl__local134, sunray - 12, _0gl__size4
MOV_CONST 6, _0gl__local135
ADD _0gl__local134, _0gl__local134, _0gl__local135, _0gl__size4
MOV sunray - 12, _0gl__local134, _0gl__size4
MOV _0gl__local136, sunray - 16, _0gl__size4
MOV_CONST 8, _0gl__local137
ADD _0gl__local136, _0gl__local136, _0gl__local137, _0gl__size4
MOV sunray - 16, _0gl__local136, _0gl__size4
MOV _0gl__local138, sunray - 20, _0gl__size4
MOV_CONST 2, _0gl__local139
ADD _0gl__local138, _0gl__local138, _0gl__local139, _0gl__size4
MOV sunray - 20, _0gl__local138, _0gl__size4
MOV _0gl__local140, _0gl__sunray_t, _0gl__size4
MOV_CONST 1, _0gl__local141
ADD _0gl__local140, _0gl__local140, _0gl__local141, _0gl__size4
MOV _0gl__sunray_t, _0gl__local140, _0gl__size4
$LEA _0gl__zero, _0gl__local121 
_0gl__local119:
MOV_CONST 1, sunray - 8
LEA _0gl__local142, _0gl__size4
LEA _0gl__local143, sunray - 4
$MOV _0gl__zero, _0gl__local143, _0gl__local142
; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
sun_dif:
MOV noise - 12, sun_dif - 12, _0gl__size4
MOV noise - 16, sun_dif - 16, _0gl__size4
LEA noise - 4, _0gl__local145
$LEA _0gl__zero, noise
_0gl__local145:
MOV _0gl__local144, noise - 8, _0gl__size4
MOV _0gl__sun_dif_a, _0gl__local144, _0gl__size4
MOV noise - 12, sun_dif - 12, _0gl__size4
MOV_CONST 90, _0gl__local147
SUB noise - 12, noise - 12, _0gl__local147, _0gl__size4
MOV noise - 16, sun_dif - 16, _0gl__size4
MOV_CONST 30, _0gl__local148
SUB noise - 16, noise - 16, _0gl__local148, _0gl__size4
LEA noise - 4, _0gl__local149
$LEA _0gl__zero, noise
_0gl__local149:
MOV _0gl__local146, noise - 8, _0gl__size4
MOV _0gl__sun_dif_b, _0gl__local146, _0gl__size4
MOV _0gl__local152, _0gl__sun_dif_a, _0gl__size4
MOV _0gl__local155, _0gl__sun_dif_b, _0gl__size4
SUB _0gl__local152, _0gl__local152, _0gl__local155, _0gl__size4
MOV_CONST 40, _0gl__local154
LT _0gl__local152, _0gl__local152, _0gl__local154, _0gl__size4
LEA _0gl__local153, _0gl__local152
$CLEA _0gl__local153, _0gl__zero, _0gl__local150 
$LEA _0gl__zero, _0gl__local151 
_0gl__local150:
MOV _0gl__local158, _0gl__sun_dif_b, _0gl__size4
MOV _0gl__local161, _0gl__sun_dif_a, _0gl__size4
SUB _0gl__local158, _0gl__local158, _0gl__local161, _0gl__size4
MOV_CONST 40, _0gl__local160
LT _0gl__local158, _0gl__local158, _0gl__local160, _0gl__size4
LEA _0gl__local159, _0gl__local158
$CLEA _0gl__local159, _0gl__zero, _0gl__local156 
$LEA _0gl__zero, _0gl__local157 
_0gl__local156:
MOV_CONST 750, sun_dif - 8
MOV fdiv - 12, _0gl__sun_dif_a, _0gl__size4
MOV _0gl__local163, _0gl__sun_dif_b, _0gl__size4
SUB fdiv - 12, fdiv - 12, _0gl__local163, _0gl__size4
MOV_CONST 200, fdiv - 16
LEA fdiv - 4, _0gl__local164
$LEA _0gl__zero, fdiv
_0gl__local164:
MOV _0gl__local162, fdiv - 8, _0gl__size4
ADD sun_dif - 8, sun_dif - 8, _0gl__local162, _0gl__size4
LEA _0gl__local165, _0gl__size4
LEA _0gl__local166, sun_dif - 4
$MOV _0gl__zero, _0gl__local166, _0gl__local165
_0gl__local157:
_0gl__local151:
MOV _0gl__local169, _0gl__sun_dif_a, _0gl__size4
MOV _0gl__local171, _0gl__sun_dif_b, _0gl__size4
LT _0gl__local169, _0gl__local171, _0gl__local169, _0gl__size4
LEA _0gl__local170, _0gl__local169
$CLEA _0gl__local170, _0gl__zero, _0gl__local167 
$LEA _0gl__zero, _0gl__local168 
_0gl__local167:
MOV_CONST 1000, sun_dif - 8
LEA _0gl__local172, _0gl__size4
LEA _0gl__local173, sun_dif - 4
$MOV _0gl__zero, _0gl__local173, _0gl__local172
_0gl__local168:
MOV_CONST 500, sun_dif - 8
LEA _0gl__local174, _0gl__size4
LEA _0gl__local175, sun_dif - 4
$MOV _0gl__zero, _0gl__local175, _0gl__local174
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
MOV_CONST 0, _0gl__local176
MOV _0gl__ray_t, _0gl__local176, _0gl__size4
LEA _0gl__local181, _0gl__local180
_0gl__local179:
MOV _0gl__local180, _0gl__ray_t, _0gl__size4
MOV_CONST 100, _0gl__local182
LT _0gl__local180, _0gl__local180, _0gl__local182, _0gl__size4
$CLEA _0gl__local181, _0gl__zero, _0gl__local178 
$LEA _0gl__zero, _0gl__local177
_0gl__local178:
MOV noise - 12, ray - 12, _0gl__size4
MOV noise - 16, ray - 20, _0gl__size4
LEA noise - 4, _0gl__local184
$LEA _0gl__zero, noise
_0gl__local184:
MOV _0gl__local183, noise - 8, _0gl__size4
MOV _0gl__ray_h, _0gl__local183, _0gl__size4
MOV _0gl__local187, ray - 16, _0gl__size4
MOV _0gl__local189, _0gl__ray_h, _0gl__size4
LT _0gl__local187, _0gl__local189, _0gl__local187, _0gl__size4
LEA _0gl__local188, _0gl__local187
$CLEA _0gl__local188, _0gl__zero, _0gl__local185 
$LEA _0gl__zero, _0gl__local186 
_0gl__local185:
MOV _0gl__local190, ray - 12, _0gl__size4
MOV fmul - 12, ray - 24, _0gl__size4
MOV_CONST 50, fmul - 16
LEA fmul - 4, _0gl__local192
$LEA _0gl__zero, fmul
_0gl__local192:
MOV _0gl__local191, fmul - 8, _0gl__size4
ADD _0gl__local190, _0gl__local190, _0gl__local191, _0gl__size4
MOV ray - 12, _0gl__local190, _0gl__size4
MOV _0gl__local193, ray - 16, _0gl__size4
MOV fmul - 12, ray - 28, _0gl__size4
MOV_CONST 50, fmul - 16
LEA fmul - 4, _0gl__local195
$LEA _0gl__zero, fmul
_0gl__local195:
MOV _0gl__local194, fmul - 8, _0gl__size4
ADD _0gl__local193, _0gl__local193, _0gl__local194, _0gl__size4
MOV ray - 16, _0gl__local193, _0gl__size4
MOV _0gl__local196, ray - 20, _0gl__size4
MOV fmul - 12, ray - 32, _0gl__size4
MOV_CONST 50, fmul - 16
LEA fmul - 4, _0gl__local198
$LEA _0gl__zero, fmul
_0gl__local198:
MOV _0gl__local197, fmul - 8, _0gl__size4
ADD _0gl__local196, _0gl__local196, _0gl__local197, _0gl__size4
MOV ray - 20, _0gl__local196, _0gl__size4
_0gl__local186:
MOV _0gl__local199, _0gl__ray_t, _0gl__size4
MOV_CONST 1, _0gl__local200
ADD _0gl__local199, _0gl__local199, _0gl__local200, _0gl__size4
MOV _0gl__ray_t, _0gl__local199, _0gl__size4
$LEA _0gl__zero, _0gl__local179 
_0gl__local177:
MOV _0gl__local203, ray - 16, _0gl__size4
MOV _0gl__local206, _0gl__ray_h, _0gl__size4
SUB _0gl__local203, _0gl__local203, _0gl__local206, _0gl__size4
MOV_CONST 200, _0gl__local205
LT _0gl__local203, _0gl__local205, _0gl__local203, _0gl__size4
LEA _0gl__local204, _0gl__local203
$CLEA _0gl__local204, _0gl__zero, _0gl__local201 
$LEA _0gl__zero, _0gl__local202 
_0gl__local201:
MOV_CONST 1000, ray - 8
LEA _0gl__local207, _0gl__size4
LEA _0gl__local208, ray - 4
$MOV _0gl__zero, _0gl__local208, _0gl__local207
_0gl__local202:
MOV_CONST 0, _0gl__local211
LEA _0gl__local212, _0gl__local211
$CLEA _0gl__local212, _0gl__zero, _0gl__local209 
$LEA _0gl__zero, _0gl__local210 
_0gl__local209:
MOV fmul - 12, _0gl__ray_h, _0gl__size4
MOV sun_dif - 12, ray - 12, _0gl__size4
MOV sun_dif - 16, ray - 20, _0gl__size4
LEA sun_dif - 4, _0gl__local214
$LEA _0gl__zero, sun_dif
_0gl__local214:
MOV fmul - 16, sun_dif - 8, _0gl__size4
LEA fmul - 4, _0gl__local215
$LEA _0gl__zero, fmul
_0gl__local215:
MOV _0gl__local213, fmul - 8, _0gl__size4
MOV _0gl__ray_h, _0gl__local213, _0gl__size4
_0gl__local210:
MOV_CONST 0, _0gl__local218
LEA _0gl__local219, _0gl__local218
$CLEA _0gl__local219, _0gl__zero, _0gl__local216 
$LEA _0gl__zero, _0gl__local217 
_0gl__local216:
MOV sunray - 12, ray - 12, _0gl__size4
MOV sunray - 16, ray - 16, _0gl__size4
MOV_CONST 30, _0gl__local225
ADD sunray - 16, sunray - 16, _0gl__local225, _0gl__size4
MOV sunray - 20, ray - 20, _0gl__size4
LEA sunray - 4, _0gl__local226
$LEA _0gl__zero, sunray
_0gl__local226:
MOV _0gl__local222, sunray - 8, _0gl__size4
MOV_CONST 0, _0gl__local224
EQ _0gl__local222, _0gl__local222, _0gl__local224, _0gl__size4
ALL _0gl__local222, _0gl__local222, _0gl__size4
LEA _0gl__local223, _0gl__local222
$CLEA _0gl__local223, _0gl__zero, _0gl__local220 
$LEA _0gl__zero, _0gl__local221 
_0gl__local220:
MOV ray - 8, _0gl__ray_h, _0gl__size4
MOV_CONST 2, _0gl__local227
DIV ray - 8, ray - 8, _0gl__local227, _0gl__size4
LEA _0gl__local228, _0gl__size4
LEA _0gl__local229, ray - 4
$MOV _0gl__zero, _0gl__local229, _0gl__local228
_0gl__local221:
_0gl__local217:
MOV ray - 8, _0gl__ray_h, _0gl__size4
LEA _0gl__local230, _0gl__size4
LEA _0gl__local231, ray - 4
$MOV _0gl__zero, _0gl__local231, _0gl__local230
; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
draw:
MOV_CONST 65536, _0gl__local232
MOV _0gl__draw_start, _0gl__local232, _0gl__size4
MOV_CONST 65536, _0gl__local233
MOV _0gl__draw_end, _0gl__local233, _0gl__size4
MOV_CONST 0, _0gl__local234
MOV _0gl__draw_y, _0gl__local234, _0gl__size4
LEA _0gl__local239, _0gl__local238
_0gl__local237:
MOV _0gl__local238, _0gl__draw_y, _0gl__size4
MOV_CONST 90, _0gl__local240
LT _0gl__local238, _0gl__local238, _0gl__local240, _0gl__size4
$CLEA _0gl__local239, _0gl__zero, _0gl__local236 
$LEA _0gl__zero, _0gl__local235
_0gl__local236:
MOV_CONST 0, _0gl__local241
MOV _0gl__draw_x, _0gl__local241, _0gl__size4
LEA _0gl__local246, _0gl__local245
_0gl__local244:
MOV _0gl__local245, _0gl__draw_x, _0gl__size4
MOV_CONST 160, _0gl__local247
LT _0gl__local245, _0gl__local245, _0gl__local247, _0gl__size4
$CLEA _0gl__local246, _0gl__zero, _0gl__local243 
$LEA _0gl__zero, _0gl__local242
_0gl__local243:
MOV f - 12, _0gl__draw_x, _0gl__size4
MOV_CONST 80, _0gl__local249
SUB f - 12, f - 12, _0gl__local249, _0gl__size4
LEA f - 4, _0gl__local250
$LEA _0gl__zero, f
_0gl__local250:
MOV fdiv - 12, f - 8, _0gl__size4
MOV_CONST 45, f - 12
LEA f - 4, _0gl__local251
$LEA _0gl__zero, f
_0gl__local251:
MOV fdiv - 16, f - 8, _0gl__size4
LEA fdiv - 4, _0gl__local252
$LEA _0gl__zero, fdiv
_0gl__local252:
MOV _0gl__local248, fdiv - 8, _0gl__size4
MOV _0gl__draw_a, _0gl__local248, _0gl__size4
MOV_CONST 45, f - 12
MOV _0gl__local254, _0gl__draw_y, _0gl__size4
SUB f - 12, f - 12, _0gl__local254, _0gl__size4
LEA f - 4, _0gl__local255
$LEA _0gl__zero, f
_0gl__local255:
MOV fdiv - 12, f - 8, _0gl__size4
MOV_CONST 45, f - 12
LEA f - 4, _0gl__local256
$LEA _0gl__zero, f
_0gl__local256:
MOV fdiv - 16, f - 8, _0gl__size4
LEA fdiv - 4, _0gl__local257
$LEA _0gl__zero, fdiv
_0gl__local257:
MOV _0gl__local253, fdiv - 8, _0gl__size4
MOV _0gl__draw_b, _0gl__local253, _0gl__size4
MOV ray - 12, draw - 12, _0gl__size4
MOV ray - 16, draw - 16, _0gl__size4
MOV ray - 20, draw - 20, _0gl__size4
MOV ray - 24, _0gl__draw_a, _0gl__size4
MOV_CONST 2, _0gl__local259
DIV ray - 24, ray - 24, _0gl__local259, _0gl__size4
MOV ray - 28, _0gl__draw_b, _0gl__size4
MOV_CONST 2, _0gl__local261
DIV ray - 28, ray - 28, _0gl__local261, _0gl__size4
MOV_CONST 180, _0gl__local260
SUB ray - 28, ray - 28, _0gl__local260, _0gl__size4
MOV_CONST 1000, ray - 32
LEA ray - 4, _0gl__local262
$LEA _0gl__zero, ray
_0gl__local262:
MOV _0gl__local258, ray - 8, _0gl__size4
MOV _0gl__draw_c, _0gl__local258, _0gl__size4
MOV_CONST 255, _0gl__local263
MOV _0gl__local265, _0gl__draw_c, _0gl__size4
MUL _0gl__local263, _0gl__local263, _0gl__local265, _0gl__size4
MOV_CONST 1000, _0gl__local264
DIV _0gl__local263, _0gl__local263, _0gl__local264, _0gl__size4
MOV _0gl__draw_c, _0gl__local263, _0gl__size4
MOV put4 - 12, _0gl__draw_end, _0gl__size4
MOV put4 - 16, _0gl__draw_c, _0gl__size4
MOV_CONST 65536, _0gl__local268
MUL put4 - 16, put4 - 16, _0gl__local268, _0gl__size4
MOV _0gl__local267, _0gl__draw_c, _0gl__size4
MOV_CONST 256, _0gl__local270
MUL _0gl__local267, _0gl__local267, _0gl__local270, _0gl__size4
MOV _0gl__local269, _0gl__draw_c, _0gl__size4
ADD _0gl__local267, _0gl__local267, _0gl__local269, _0gl__size4
ADD put4 - 16, put4 - 16, _0gl__local267, _0gl__size4
LEA put4 - 4, _0gl__local271
$LEA _0gl__zero, put4
_0gl__local271:
MOV _0gl__local266, put4 - 8, _0gl__size4
MOV _0gl__draw_t, _0gl__local266, _0gl__size4
MOV _0gl__local272, _0gl__draw_end, _0gl__size4
MOV_CONST 4, _0gl__local273
ADD _0gl__local272, _0gl__local272, _0gl__local273, _0gl__size4
MOV _0gl__draw_end, _0gl__local272, _0gl__size4
MOV _0gl__local274, _0gl__draw_x, _0gl__size4
MOV_CONST 1, _0gl__local275
ADD _0gl__local274, _0gl__local274, _0gl__local275, _0gl__size4
MOV _0gl__draw_x, _0gl__local274, _0gl__size4
$LEA _0gl__zero, _0gl__local244 
_0gl__local242:
MOV _0gl__local276, _0gl__draw_y, _0gl__size4
MOV_CONST 1, _0gl__local277
ADD _0gl__local276, _0gl__local276, _0gl__local277, _0gl__size4
MOV _0gl__draw_y, _0gl__local276, _0gl__size4
$LEA _0gl__zero, _0gl__local237 
_0gl__local235:
MOV out - 12, _0gl__draw_start, _0gl__size4
MOV out - 16, _0gl__draw_end, _0gl__size4
MOV _0gl__local279, _0gl__draw_start, _0gl__size4
SUB out - 16, out - 16, _0gl__local279, _0gl__size4
LEA out - 4, _0gl__local280
$LEA _0gl__zero, out
_0gl__local280:
MOV _0gl__local278, out - 8, _0gl__size4
MOV _0gl__draw_t, _0gl__local278, _0gl__size4
MOV_CONST 0, draw - 8
LEA _0gl__local281, _0gl__size4
LEA _0gl__local282, draw - 4
$MOV _0gl__zero, _0gl__local282, _0gl__local281
; arguments
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
main:
MOV_CONST 0, _0gl__local283
MOV _0gl__main_x, _0gl__local283, _0gl__size4
MOV_CONST 1600, _0gl__local284
MOV _0gl__main_y, _0gl__local284, _0gl__size4
MOV_CONST -2000, _0gl__local285
MOV _0gl__main_z, _0gl__local285, _0gl__size4
LEA _0gl__local290, _0gl__local289
_0gl__local288:
MOV_CONST 1, _0gl__local289
$CLEA _0gl__local290, _0gl__zero, _0gl__local287 
$LEA _0gl__zero, _0gl__local286
_0gl__local287:
MOV draw - 12, _0gl__main_x, _0gl__size4
MOV draw - 16, _0gl__main_y, _0gl__size4
MOV draw - 20, _0gl__main_z, _0gl__size4
LEA draw - 4, _0gl__local292
$LEA _0gl__zero, draw
_0gl__local292:
MOV _0gl__local291, draw - 8, _0gl__size4
MOV _0gl__main_t, _0gl__local291, _0gl__size4
MOV _0gl__local293, _0gl__main_z, _0gl__size4
MOV_CONST 300, _0gl__local294
ADD _0gl__local293, _0gl__local293, _0gl__local294, _0gl__size4
MOV _0gl__main_z, _0gl__local293, _0gl__size4
MOV _0gl__local295, _0gl__main_x, _0gl__size4
MOV_CONST 100, _0gl__local296
ADD _0gl__local295, _0gl__local295, _0gl__local296, _0gl__size4
MOV _0gl__main_x, _0gl__local295, _0gl__size4
$LEA _0gl__zero, _0gl__local288 
_0gl__local286:
MOV_CONST 0, main - 8
LEA _0gl__local297, _0gl__size4
LEA _0gl__local298, main - 4
$MOV _0gl__zero, _0gl__local298, _0gl__local297
_0gl__hash_res:
.dd 0
_0gl__local0:
.dd 0
_0gl__local1:
.dd 0
_0gl__local2:
.dd 0
_0gl__local3:
.dd 0
_0gl__local4:
.dd 0
_0gl__local5:
.dd 0
_0gl__local6:
.dd 0
_0gl__local7:
.dd 0
_0gl__local8:
.dd 0
_0gl__local9:
.dd 0
_0gl__noise_ix:
.dd 0
_0gl__noise_iy:
.dd 0
_0gl__local10:
.dd 0
_0gl__local11:
.dd 0
_0gl__local12:
.dd 0
_0gl__local13:
.dd 0
_0gl__local16:
.dd 0
_0gl__local17:
.dd 0
_0gl__local18:
.dd 0
_0gl__local19:
.dd 0
_0gl__local20:
.dd 0
_0gl__local23:
.dd 0
_0gl__local24:
.dd 0
_0gl__local25:
.dd 0
_0gl__local26:
.dd 0
_0gl__local27:
.dd 0
_0gl__noise_fx:
.dd 0
_0gl__noise_fy:
.dd 0
_0gl__local28:
.dd 0
_0gl__local29:
.dd 0
_0gl__local30:
.dd 0
_0gl__local31:
.dd 0
_0gl__local32:
.dd 0
_0gl__local33:
.dd 0
_0gl__noise_a:
.dd 0
_0gl__noise_b:
.dd 0
_0gl__noise_c:
.dd 0
_0gl__noise_d:
.dd 0
_0gl__local34:
.dd 0
_0gl__local36:
.dd 0
_0gl__local37:
.dd 0
_0gl__local39:
.dd 0
_0gl__local40:
.dd 0
_0gl__local42:
.dd 0
_0gl__local43:
.dd 0
_0gl__local44:
.dd 0
_0gl__local46:
.dd 0
_0gl__local47:
.dd 0
_0gl__local48:
.dd 0
_0gl__local51:
.dd 0
_0gl__local52:
.dd 0
_0gl__local53:
.dd 0
_0gl__local56:
.dd 0
_0gl__local57:
.dd 0
_0gl__local58:
.dd 0
_0gl__local63:
.dd 0
_0gl__local64:
.dd 0
_0gl__local65:
.dd 0
_0gl__local66:
.dd 0
_0gl__local67:
.dd 0
_0gl__local68:
.dd 0
_0gl__local71:
.dd 0
_0gl__local72:
.dd 0
_0gl__local73:
.dd 0
_0gl__local74:
.dd 0
_0gl__local75:
.dd 0
_0gl__local76:
.dd 0
_0gl__local77:
.dd 0
_0gl__local78:
.dd 0
_0gl__local79:
.dd 0
_0gl__local80:
.dd 0
_0gl__local81:
.dd 0
_0gl__local84:
.dd 0
_0gl__local85:
.dd 0
_0gl__local86:
.dd 0
_0gl__local87:
.dd 0
_0gl__local88:
.dd 0
_0gl__local89:
.dd 0
_0gl__local90:
.dd 0
_0gl__local91:
.dd 0
_0gl__local94:
.dd 0
_0gl__local95:
.dd 0
_0gl__local96:
.dd 0
_0gl__local97:
.dd 0
_0gl__local98:
.dd 0
_0gl__local101:
.dd 0
_0gl__local102:
.dd 0
_0gl__local103:
.dd 0
_0gl__local104:
.dd 0
_0gl__local105:
.dd 0
_0gl__local108:
.dd 0
_0gl__local109:
.dd 0
_0gl__local110:
.dd 0
_0gl__local111:
.dd 0
_0gl__local114:
.dd 0
_0gl__local115:
.dd 0
_0gl__local116:
.dd 0
_0gl__local117:
.dd 0
_0gl__sunray_t:
.dd 0
_0gl__sunray_h:
.dd 0
_0gl__local118:
.dd 0
_0gl__local122:
.dd 0
_0gl__local123:
.dd 0
_0gl__local124:
.dd 0
_0gl__local125:
.dd 0
_0gl__local129:
.dd 0
_0gl__local130:
.dd 0
_0gl__local131:
.dd 0
_0gl__local132:
.dd 0
_0gl__local133:
.dd 0
_0gl__local134:
.dd 0
_0gl__local135:
.dd 0
_0gl__local136:
.dd 0
_0gl__local137:
.dd 0
_0gl__local138:
.dd 0
_0gl__local139:
.dd 0
_0gl__local140:
.dd 0
_0gl__local141:
.dd 0
_0gl__local142:
.dd 0
_0gl__local143:
.dd 0
_0gl__sun_dif_a:
.dd 0
_0gl__sun_dif_b:
.dd 0
_0gl__local144:
.dd 0
_0gl__local146:
.dd 0
_0gl__local147:
.dd 0
_0gl__local148:
.dd 0
_0gl__local152:
.dd 0
_0gl__local153:
.dd 0
_0gl__local154:
.dd 0
_0gl__local155:
.dd 0
_0gl__local158:
.dd 0
_0gl__local159:
.dd 0
_0gl__local160:
.dd 0
_0gl__local161:
.dd 0
_0gl__local162:
.dd 0
_0gl__local163:
.dd 0
_0gl__local165:
.dd 0
_0gl__local166:
.dd 0
_0gl__local169:
.dd 0
_0gl__local170:
.dd 0
_0gl__local171:
.dd 0
_0gl__local172:
.dd 0
_0gl__local173:
.dd 0
_0gl__local174:
.dd 0
_0gl__local175:
.dd 0
_0gl__ray_t:
.dd 0
_0gl__local176:
.dd 0
_0gl__ray_h:
.dd 0
_0gl__local180:
.dd 0
_0gl__local181:
.dd 0
_0gl__local182:
.dd 0
_0gl__local183:
.dd 0
_0gl__local187:
.dd 0
_0gl__local188:
.dd 0
_0gl__local189:
.dd 0
_0gl__local190:
.dd 0
_0gl__local191:
.dd 0
_0gl__local193:
.dd 0
_0gl__local194:
.dd 0
_0gl__local196:
.dd 0
_0gl__local197:
.dd 0
_0gl__local199:
.dd 0
_0gl__local200:
.dd 0
_0gl__local203:
.dd 0
_0gl__local204:
.dd 0
_0gl__local205:
.dd 0
_0gl__local206:
.dd 0
_0gl__local207:
.dd 0
_0gl__local208:
.dd 0
_0gl__local211:
.dd 0
_0gl__local212:
.dd 0
_0gl__local213:
.dd 0
_0gl__local218:
.dd 0
_0gl__local219:
.dd 0
_0gl__local222:
.dd 0
_0gl__local223:
.dd 0
_0gl__local224:
.dd 0
_0gl__local225:
.dd 0
_0gl__local227:
.dd 0
_0gl__local228:
.dd 0
_0gl__local229:
.dd 0
_0gl__local230:
.dd 0
_0gl__local231:
.dd 0
_0gl__draw_t:
.dd 0
_0gl__draw_start:
.dd 0
_0gl__draw_end:
.dd 0
_0gl__draw_x:
.dd 0
_0gl__draw_y:
.dd 0
_0gl__draw_a:
.dd 0
_0gl__draw_b:
.dd 0
_0gl__local232:
.dd 0
_0gl__local233:
.dd 0
_0gl__local234:
.dd 0
_0gl__local238:
.dd 0
_0gl__local239:
.dd 0
_0gl__local240:
.dd 0
_0gl__local241:
.dd 0
_0gl__local245:
.dd 0
_0gl__local246:
.dd 0
_0gl__local247:
.dd 0
_0gl__local248:
.dd 0
_0gl__local249:
.dd 0
_0gl__local253:
.dd 0
_0gl__local254:
.dd 0
_0gl__draw_c:
.dd 0
_0gl__local258:
.dd 0
_0gl__local259:
.dd 0
_0gl__local260:
.dd 0
_0gl__local261:
.dd 0
_0gl__local263:
.dd 0
_0gl__local264:
.dd 0
_0gl__local265:
.dd 0
_0gl__local266:
.dd 0
_0gl__local267:
.dd 0
_0gl__local268:
.dd 0
_0gl__local269:
.dd 0
_0gl__local270:
.dd 0
_0gl__local272:
.dd 0
_0gl__local273:
.dd 0
_0gl__local274:
.dd 0
_0gl__local275:
.dd 0
_0gl__local276:
.dd 0
_0gl__local277:
.dd 0
_0gl__local278:
.dd 0
_0gl__local279:
.dd 0
_0gl__local281:
.dd 0
_0gl__local282:
.dd 0
_0gl__main_t:
.dd 0
_0gl__main_x:
.dd 0
_0gl__main_y:
.dd 0
_0gl__main_z:
.dd 0
_0gl__local283:
.dd 0
_0gl__local284:
.dd 0
_0gl__local285:
.dd 0
_0gl__local289:
.dd 0
_0gl__local290:
.dd 0
_0gl__local291:
.dd 0
_0gl__local293:
.dd 0
_0gl__local294:
.dd 0
_0gl__local295:
.dd 0
_0gl__local296:
.dd 0
_0gl__local297:
.dd 0
_0gl__local298:
.dd 0
_0gl__size4:
.dd 4
_0gl__size1:
.dd 1
_0gl__zero:
.dd 0

; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
fmul:
MOV fmul - 8, fmul - 12, _1math__size4
MOV _1math__local1, fmul - 16, _1math__size4
MUL fmul - 8, fmul - 8, _1math__local1, _1math__size4
MOV_CONST 1000, _1math__local0
DIV fmul - 8, fmul - 8, _1math__local0, _1math__size4
LEA _1math__local2, _1math__size4
LEA _1math__local3, fmul - 4
$MOV _1math__zero, _1math__local3, _1math__local2
; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
fdiv:
MOV fdiv - 8, fdiv - 12, _1math__size4
MOV_CONST 1000, _1math__local5
MUL fdiv - 8, fdiv - 8, _1math__local5, _1math__size4
MOV _1math__local4, fdiv - 16, _1math__size4
DIV fdiv - 8, fdiv - 8, _1math__local4, _1math__size4
LEA _1math__local6, _1math__size4
LEA _1math__local7, fdiv - 4
$MOV _1math__zero, _1math__local7, _1math__local6
; arguments
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
sqrt:
MOV _1math__local8, sqrt - 12, _1math__size4
MOV_CONST 1000, _1math__local9
MUL _1math__local8, _1math__local8, _1math__local9, _1math__size4
MOV _1math__sqrt_aa, _1math__local8, _1math__size4
MOV_CONST 0, _1math__local10
MOV _1math__sqrt_res, _1math__local10, _1math__size4
MOV_CONST 46340, _1math__local11
MOV _1math__sqrt_add, _1math__local11, _1math__size4
LEA _1math__local16, _1math__local15
_1math__local14:
MOV _1math__local15, _1math__sqrt_add, _1math__size4
MOV_CONST 0, _1math__local17
LT _1math__local15, _1math__local17, _1math__local15, _1math__size4
$CLEA _1math__local16, _1math__zero, _1math__local13 
$LEA _1math__zero, _1math__local12
_1math__local13:
MOV _1math__local20, _1math__sqrt_res, _1math__size4
MOV _1math__local24, _1math__sqrt_add, _1math__size4
ADD _1math__local20, _1math__local20, _1math__local24, _1math__size4
MOV _1math__local23, _1math__sqrt_res, _1math__size4
MOV _1math__local25, _1math__sqrt_add, _1math__size4
ADD _1math__local23, _1math__local23, _1math__local25, _1math__size4
MUL _1math__local20, _1math__local20, _1math__local23, _1math__size4
MOV _1math__local22, _1math__sqrt_aa, _1math__size4
LT _1math__local20, _1math__local20, _1math__local22, _1math__size4
LEA _1math__local21, _1math__local20
$CLEA _1math__local21, _1math__zero, _1math__local18 
$LEA _1math__zero, _1math__local19 
_1math__local18:
MOV _1math__local26, _1math__sqrt_res, _1math__size4
MOV _1math__local27, _1math__sqrt_add, _1math__size4
ADD _1math__local26, _1math__local26, _1math__local27, _1math__size4
MOV _1math__sqrt_res, _1math__local26, _1math__size4
_1math__local19:
MOV _1math__local28, _1math__sqrt_add, _1math__size4
MOV_CONST 2, _1math__local29
DIV _1math__local28, _1math__local28, _1math__local29, _1math__size4
MOV _1math__sqrt_add, _1math__local28, _1math__size4
$LEA _1math__zero, _1math__local14 
_1math__local12:
MOV sqrt - 8, _1math__sqrt_res, _1math__size4
LEA _1math__local30, _1math__size4
LEA _1math__local31, sqrt - 4
$MOV _1math__zero, _1math__local31, _1math__local30
; arguments
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
f:
MOV f - 8, f - 12, _1math__size4
MOV_CONST 1000, _1math__local32
MUL f - 8, f - 8, _1math__local32, _1math__size4
LEA _1math__local33, _1math__size4
LEA _1math__local34, f - 4
$MOV _1math__zero, _1math__local34, _1math__local33
_1math__local0:
.dd 0
_1math__local1:
.dd 0
_1math__local2:
.dd 0
_1math__local3:
.dd 0
_1math__local4:
.dd 0
_1math__local5:
.dd 0
_1math__local6:
.dd 0
_1math__local7:
.dd 0
_1math__sqrt_aa:
.dd 0
_1math__sqrt_res:
.dd 0
_1math__sqrt_add:
.dd 0
_1math__local8:
.dd 0
_1math__local9:
.dd 0
_1math__local10:
.dd 0
_1math__local11:
.dd 0
_1math__local15:
.dd 0
_1math__local16:
.dd 0
_1math__local17:
.dd 0
_1math__local20:
.dd 0
_1math__local21:
.dd 0
_1math__local22:
.dd 0
_1math__local23:
.dd 0
_1math__local24:
.dd 0
_1math__local25:
.dd 0
_1math__local26:
.dd 0
_1math__local27:
.dd 0
_1math__local28:
.dd 0
_1math__local29:
.dd 0
_1math__local30:
.dd 0
_1math__local31:
.dd 0
_1math__local32:
.dd 0
_1math__local33:
.dd 0
_1math__local34:
.dd 0
_1math__size4:
.dd 4
_1math__size1:
.dd 1
_1math__zero:
.dd 0


; int get4(int) function:
; 
; ptr - pointer to write data
; value - data to write
; 
; writes only 4 byte slices

; arguments
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE

get4:

; read data from memory
LEA _2io__size4_ptr, _2io__size4
LEA _2io__value_ptr, put4 - 8
$MOV _2io__value_ptr, put4 - 12, _2io__size4_ptr

; return to caller
LEA _2io__ptr_ptr, put4 - 4
$MOV _2io__zero, _2io__ptr_ptr, _2io__size4_ptr


; int get1(int) function:
; 
; ptr - pointer to write data
; value - data to write
; 
; writes only 1 byte slices

; arguments
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE

get1:

; write data to memory
LEA _2io__size1_ptr, _2io__size1
LEA _2io__size4_ptr, _2io__size4
LEA _2io__value_ptr, put1 - 8
$MOV _2io__value_ptr, put1 - 12, _2io__size1_ptr

; return to caller
LEA _2io__ptr_ptr, put1 - 4
$MOV _2io__zero, _2io__ptr_ptr, _2io__size4_ptr



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
LEA _2io__size4_ptr, _2io__size4
LEA _2io__value_ptr, put4 - 16
$MOV put4 - 12, _2io__value_ptr, _2io__size4_ptr

; return to caller
LEA _2io__ptr_ptr, put4 - 4
$MOV _2io__zero, _2io__ptr_ptr, _2io__size4_ptr


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
LEA _2io__size1_ptr, _2io__size1
LEA _2io__size4_ptr, _2io__size4
LEA _2io__value_ptr, put1 - 16
$MOV put1 - 12, _2io__value_ptr, _2io__size1_ptr

; return to caller
LEA _2io__ptr_ptr, put1 - 4
$MOV _2io__zero, _2io__ptr_ptr, _2io__size4_ptr


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
LEA _2io__ptr_ptr, out - 16
$OUT 1, out - 12, _2io__ptr_ptr

; return to caller
LEA _2io__size4_ptr, _2io__size4
LEA _2io__ptr_ptr, out - 4
$MOV _2io__zero, _2io__ptr_ptr, _2io__size4_ptr

_2io__ptr_ptr:
.dd 0
_2io__value_ptr:
.dd 0
_2io__size4_ptr:
.dd 0
_2io__size1_ptr:
.dd 0


_2io__size4:
.dd 4
_2io__size1:
.dd 4
_2io__zero:
.dd 0


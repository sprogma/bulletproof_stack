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
MOV fmul - 16, phong - 36, _size4
LEA fmul - 4, _local28
$LEA _zero, fmul
_local28:
MOV _local26, fmul - 8, _size4
MOV fmul - 12, phong - 16, _size4
MOV fmul - 16, phong - 40, _size4
LEA fmul - 4, _local30
$LEA _zero, fmul
_local30:
MOV _local27, fmul - 8, _size4
MOV fmul - 12, phong - 20, _size4
MOV fmul - 16, phong - 44, _size4
LEA fmul - 4, _local31
$LEA _zero, fmul
_local31:
MOV _local29, fmul - 8, _size4
ADD _local27, _local27, _local29, _size4
ADD _local26, _local26, _local27, _size4
MOV _phong_diffuse, _local26, _size4
MOV fmul - 12, _phong_diffuse, _size4
MOV_CONST 400, fmul - 16
LEA fmul - 4, _local33
$LEA _zero, fmul
_local33:
MOV _local32, fmul - 8, _size4
MOV _phong_diffuse, _local32, _size4
MOV _local36, _phong_diffuse, _size4
MOV_CONST 0, _local38
LT _local36, _local36, _local38, _size4
LEA _local37, _local36
$CLEA _local37, _zero, _local34 
$LEA _zero, _local35 
_local34:
MOV_CONST 0, _local39
MOV _phong_diffuse, _local39, _size4
_local35:
MOV _local40, phong - 12, _size4
MOV _local41, phong - 24, _size4
SUB _local40, _local40, _local41, _size4
MOV _phong_x, _local40, _size4
MOV _local42, phong - 16, _size4
MOV _local43, phong - 28, _size4
SUB _local42, _local42, _local43, _size4
MOV _phong_y, _local42, _size4
MOV _local44, phong - 20, _size4
MOV _local45, phong - 32, _size4
SUB _local44, _local44, _local45, _size4
MOV _phong_z, _local44, _size4
MOV fmul - 12, _phong_x, _size4
MOV fmul - 16, _phong_x, _size4
LEA fmul - 4, _local48
$LEA _zero, fmul
_local48:
MOV sqrt - 12, fmul - 8, _size4
MOV fmul - 12, _phong_y, _size4
MOV fmul - 16, _phong_y, _size4
LEA fmul - 4, _local50
$LEA _zero, fmul
_local50:
MOV _local47, fmul - 8, _size4
MOV fmul - 12, _phong_z, _size4
MOV fmul - 16, _phong_z, _size4
LEA fmul - 4, _local51
$LEA _zero, fmul
_local51:
MOV _local49, fmul - 8, _size4
ADD _local47, _local47, _local49, _size4
ADD sqrt - 12, sqrt - 12, _local47, _size4
LEA sqrt - 4, _local52
$LEA _zero, sqrt
_local52:
MOV _local46, sqrt - 8, _size4
MOV _phong_l, _local46, _size4
MOV fdiv - 12, _phong_x, _size4
MOV fdiv - 16, _phong_l, _size4
LEA fdiv - 4, _local54
$LEA _zero, fdiv
_local54:
MOV _local53, fdiv - 8, _size4
MOV _phong_x, _local53, _size4
MOV fdiv - 12, _phong_y, _size4
MOV fdiv - 16, _phong_l, _size4
LEA fdiv - 4, _local56
$LEA _zero, fdiv
_local56:
MOV _local55, fdiv - 8, _size4
MOV _phong_y, _local55, _size4
MOV fdiv - 12, _phong_z, _size4
MOV fdiv - 16, _phong_l, _size4
LEA fdiv - 4, _local58
$LEA _zero, fdiv
_local58:
MOV _local57, fdiv - 8, _size4
MOV _phong_z, _local57, _size4
MOV fmul - 12, _phong_x, _size4
MOV fmul - 16, phong - 36, _size4
LEA fmul - 4, _local61
$LEA _zero, fmul
_local61:
MOV _local59, fmul - 8, _size4
MOV fmul - 12, _phong_y, _size4
MOV fmul - 16, phong - 40, _size4
LEA fmul - 4, _local63
$LEA _zero, fmul
_local63:
MOV _local60, fmul - 8, _size4
MOV fmul - 12, _phong_z, _size4
MOV fmul - 16, phong - 44, _size4
LEA fmul - 4, _local64
$LEA _zero, fmul
_local64:
MOV _local62, fmul - 8, _size4
ADD _local60, _local60, _local62, _size4
ADD _local59, _local59, _local60, _size4
MOV _phong_blink, _local59, _size4
MOV _local67, _phong_blink, _size4
MOV_CONST 0, _local69
LT _local67, _local67, _local69, _size4
LEA _local68, _local67
$CLEA _local68, _zero, _local65 
$LEA _zero, _local66 
_local65:
MOV_CONST 0, _local70
MOV _phong_blink, _local70, _size4
_local66:
MOV fmul - 12, _phong_blink, _size4
MOV fmul - 16, _phong_blink, _size4
LEA fmul - 4, _local72
$LEA _zero, fmul
_local72:
MOV _local71, fmul - 8, _size4
MOV _phong_blink, _local71, _size4
MOV fmul - 12, _phong_blink, _size4
MOV fmul - 16, _phong_blink, _size4
LEA fmul - 4, _local74
$LEA _zero, fmul
_local74:
MOV _local73, fmul - 8, _size4
MOV _phong_blink, _local73, _size4
MOV fmul - 12, _phong_blink, _size4
MOV fmul - 16, _phong_blink, _size4
LEA fmul - 4, _local76
$LEA _zero, fmul
_local76:
MOV _local75, fmul - 8, _size4
MOV _phong_l, _local75, _size4
MOV fmul - 12, _phong_blink, _size4
MOV fmul - 16, _phong_l, _size4
LEA fmul - 4, _local78
$LEA _zero, fmul
_local78:
MOV _local77, fmul - 8, _size4
MOV _phong_blink, _local77, _size4
MOV fmul - 12, _phong_blink, _size4
MOV_CONST 400, fmul - 16
LEA fmul - 4, _local80
$LEA _zero, fmul
_local80:
MOV _local79, fmul - 8, _size4
MOV _phong_blink, _local79, _size4
MOV_CONST 200, phong - 8
MOV _local81, _phong_diffuse, _size4
MOV _local82, _phong_blink, _size4
ADD _local81, _local81, _local82, _size4
ADD phong - 8, phong - 8, _local81, _size4
LEA _local83, _size4
LEA _local84, phong - 4
$MOV _zero, _local84, _local83
; arguments
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
main:
MOV_CONST 500, _local85
MOV _main_lx, _local85, _size4
MOV_CONST 1000, _local86
MOV _main_ly, _local86, _size4
MOV_CONST -800, _local87
MOV _main_lz, _local87, _size4
MOV fmul - 12, _main_lx, _size4
MOV fmul - 16, _main_lx, _size4
LEA fmul - 4, _local90
$LEA _zero, fmul
_local90:
MOV sqrt - 12, fmul - 8, _size4
MOV fmul - 12, _main_ly, _size4
MOV fmul - 16, _main_ly, _size4
LEA fmul - 4, _local92
$LEA _zero, fmul
_local92:
MOV _local89, fmul - 8, _size4
MOV fmul - 12, _main_lz, _size4
MOV fmul - 16, _main_lz, _size4
LEA fmul - 4, _local93
$LEA _zero, fmul
_local93:
MOV _local91, fmul - 8, _size4
ADD _local89, _local89, _local91, _size4
ADD sqrt - 12, sqrt - 12, _local89, _size4
LEA sqrt - 4, _local94
$LEA _zero, sqrt
_local94:
MOV _local88, sqrt - 8, _size4
MOV _main_t, _local88, _size4
MOV fdiv - 12, _main_lx, _size4
MOV fdiv - 16, _main_t, _size4
LEA fdiv - 4, _local96
$LEA _zero, fdiv
_local96:
MOV _local95, fdiv - 8, _size4
MOV _main_lx, _local95, _size4
MOV fdiv - 12, _main_ly, _size4
MOV fdiv - 16, _main_t, _size4
LEA fdiv - 4, _local98
$LEA _zero, fdiv
_local98:
MOV _local97, fdiv - 8, _size4
MOV _main_ly, _local97, _size4
MOV fdiv - 12, _main_lz, _size4
MOV fdiv - 16, _main_t, _size4
LEA fdiv - 4, _local100
$LEA _zero, fdiv
_local100:
MOV _local99, fdiv - 8, _size4
MOV _main_lz, _local99, _size4
MOV_CONST 0, _local101
MOV _main_gx, _local101, _size4
MOV_CONST 0, _local102
MOV _main_gy, _local102, _size4
MOV_CONST -4000, _local103
MOV _main_gz, _local103, _size4
LEA _local108, _local107
_local106:
MOV_CONST 1, _local107
$CLEA _local108, _zero, _local105 
$LEA _zero, _local104
_local105:
MOV_CONST 65536, _local109
MOV _main_start, _local109, _size4
MOV_CONST 65536, _local110
MOV _main_end, _local110, _size4
MOV _local111, _main_gz, _size4
MOV_CONST 10, _local112
ADD _local111, _local111, _local112, _size4
MOV _main_gz, _local111, _size4
MOV _local113, _main_gx, _size4
MOV_CONST 10, _local114
SUB _local113, _local113, _local114, _size4
MOV _main_gx, _local113, _size4
MOV_CONST 0, _local115
MOV _main_y, _local115, _size4
LEA _local120, _local119
_local118:
MOV _local119, _main_y, _size4
MOV_CONST 90, _local121
LT _local119, _local119, _local121, _size4
$CLEA _local120, _zero, _local117 
$LEA _zero, _local116
_local117:
MOV_CONST 0, _local122
MOV _main_x, _local122, _size4
LEA _local127, _local126
_local125:
MOV _local126, _main_x, _size4
MOV_CONST 160, _local128
LT _local126, _local126, _local128, _size4
$CLEA _local127, _zero, _local124 
$LEA _zero, _local123
_local124:
MOV _local129, _main_x, _size4
MOV_CONST 80, _local131
SUB _local129, _local129, _local131, _size4
MOV_CONST 12, _local130
MUL _local129, _local129, _local130, _size4
MOV _main_a, _local129, _size4
MOV_CONST 45, _local132
MOV _local134, _main_y, _size4
SUB _local132, _local132, _local134, _size4
MOV_CONST 12, _local133
MUL _local132, _local132, _local133, _size4
MOV _main_b, _local132, _size4
MOV _local135, _main_a, _size4
MOV_CONST 2, _local136
DIV _local135, _local135, _local136, _size4
MOV _main_dx, _local135, _size4
MOV _local137, _main_b, _size4
MOV_CONST 2, _local138
DIV _local137, _local137, _local138, _size4
MOV _main_dy, _local137, _size4
MOV_CONST 1000, _local139
MOV _main_dz, _local139, _size4
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
LEA intersect_ball - 4, _local141
$LEA _zero, intersect_ball
_local141:
MOV _local140, intersect_ball - 8, _size4
MOV _main_res, _local140, _size4
MOV _local142, _main_gx, _size4
MOV fmul - 12, _main_dx, _size4
MOV fmul - 16, _main_res, _size4
LEA fmul - 4, _local144
$LEA _zero, fmul
_local144:
MOV _local143, fmul - 8, _size4
ADD _local142, _local142, _local143, _size4
MOV _main_px, _local142, _size4
MOV _local145, _main_gy, _size4
MOV fmul - 12, _main_dy, _size4
MOV fmul - 16, _main_res, _size4
LEA fmul - 4, _local147
$LEA _zero, fmul
_local147:
MOV _local146, fmul - 8, _size4
ADD _local145, _local145, _local146, _size4
MOV _main_py, _local145, _size4
MOV _local148, _main_gz, _size4
MOV fmul - 12, _main_dz, _size4
MOV fmul - 16, _main_res, _size4
LEA fmul - 4, _local150
$LEA _zero, fmul
_local150:
MOV _local149, fmul - 8, _size4
ADD _local148, _local148, _local149, _size4
MOV _main_pz, _local148, _size4
MOV _local151, _main_px, _size4
MOV_CONST 0, _local152
SUB _local151, _local151, _local152, _size4
MOV _main_nx, _local151, _size4
MOV _local153, _main_py, _size4
MOV_CONST 0, _local154
SUB _local153, _local153, _local154, _size4
MOV _main_ny, _local153, _size4
MOV _local155, _main_pz, _size4
MOV_CONST 5000, _local156
SUB _local155, _local155, _local156, _size4
MOV _main_nz, _local155, _size4
MOV put4 - 12, _main_end, _size4
MOV_CONST 255, put4 - 16
MOV_CONST 255, _local158
MUL put4 - 16, put4 - 16, _local158, _size4
LEA put4 - 4, _local159
$LEA _zero, put4
_local159:
MOV _local157, put4 - 8, _size4
MOV _main_t, _local157, _size4
MOV _local162, _main_res, _size4
MOV_CONST 0, _local164
LT _local162, _local164, _local162, _size4
LEA _local163, _local162
$CLEA _local163, _zero, _local160 
$LEA _zero, _local161 
_local160:
MOV phong - 12, _main_lx, _size4
MOV phong - 16, _main_ly, _size4
MOV phong - 20, _main_lz, _size4
MOV phong - 24, _main_dx, _size4
MOV phong - 28, _main_dy, _size4
MOV phong - 32, _main_dz, _size4
MOV phong - 36, _main_nx, _size4
MOV phong - 40, _main_ny, _size4
MOV phong - 44, _main_nz, _size4
LEA phong - 4, _local166
$LEA _zero, phong
_local166:
MOV _local165, phong - 8, _size4
MOV _main_spec, _local165, _size4
MOV_CONST 255, _local167
MOV _local169, _main_spec, _size4
MUL _local167, _local167, _local169, _size4
MOV_CONST 1000, _local168
DIV _local167, _local167, _local168, _size4
MOV _main_color, _local167, _size4
MOV put4 - 12, _main_end, _size4
MOV put4 - 16, _main_color, _size4
MOV_CONST 255, _local171
MOV _local173, _main_color, _size4
MUL _local171, _local171, _local173, _size4
MOV_CONST 65536, _local172
MOV _local174, _main_color, _size4
MUL _local172, _local172, _local174, _size4
ADD _local171, _local171, _local172, _size4
ADD put4 - 16, put4 - 16, _local171, _size4
LEA put4 - 4, _local175
$LEA _zero, put4
_local175:
MOV _local170, put4 - 8, _size4
MOV _main_t, _local170, _size4
_local161:
MOV _local176, _main_end, _size4
MOV_CONST 4, _local177
ADD _local176, _local176, _local177, _size4
MOV _main_end, _local176, _size4
MOV _local178, _main_x, _size4
MOV_CONST 1, _local179
ADD _local178, _local178, _local179, _size4
MOV _main_x, _local178, _size4
$LEA _zero, _local125 
_local123:
MOV _local180, _main_y, _size4
MOV_CONST 1, _local181
ADD _local180, _local180, _local181, _size4
MOV _main_y, _local180, _size4
$LEA _zero, _local118 
_local116:
MOV out - 12, _main_start, _size4
MOV out - 16, _main_end, _size4
MOV _local183, _main_start, _size4
SUB out - 16, out - 16, _local183, _size4
LEA out - 4, _local184
$LEA _zero, out
_local184:
MOV _local182, out - 8, _size4
MOV _main_t, _local182, _size4
$LEA _zero, _local106 
_local104:
MOV_CONST 0, main - 8
LEA _local185, _size4
LEA _local186, main - 4
$MOV _zero, _local186, _local185
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
_phong_diffuse:
.dd 0
_local26:
.dd 0
_local27:
.dd 0
_local29:
.dd 0
_local32:
.dd 0
_local36:
.dd 0
_local37:
.dd 0
_local38:
.dd 0
_local39:
.dd 0
_phong_x:
.dd 0
_phong_y:
.dd 0
_phong_z:
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
_local45:
.dd 0
_local46:
.dd 0
_local47:
.dd 0
_local49:
.dd 0
_local53:
.dd 0
_local55:
.dd 0
_local57:
.dd 0
_phong_blink:
.dd 0
_local59:
.dd 0
_local60:
.dd 0
_local62:
.dd 0
_local67:
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
_local77:
.dd 0
_local79:
.dd 0
_local81:
.dd 0
_local82:
.dd 0
_local83:
.dd 0
_local84:
.dd 0
_main_res:
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
_local95:
.dd 0
_local97:
.dd 0
_local99:
.dd 0
_local101:
.dd 0
_local102:
.dd 0
_local103:
.dd 0
_local107:
.dd 0
_local108:
.dd 0
_main_start:
.dd 0
_main_end:
.dd 0
_local109:
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
_local119:
.dd 0
_local120:
.dd 0
_local121:
.dd 0
_local122:
.dd 0
_local126:
.dd 0
_local127:
.dd 0
_local128:
.dd 0
_main_a:
.dd 0
_main_b:
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
_local142:
.dd 0
_local143:
.dd 0
_local145:
.dd 0
_local146:
.dd 0
_local148:
.dd 0
_local149:
.dd 0
_local151:
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
_local162:
.dd 0
_local163:
.dd 0
_local164:
.dd 0
_main_spec:
.dd 0
_local165:
.dd 0
_main_color:
.dd 0
_local167:
.dd 0
_local168:
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
_local176:
.dd 0
_local177:
.dd 0
_local178:
.dd 0
_local179:
.dd 0
_local180:
.dd 0
_local181:
.dd 0
_local182:
.dd 0
_local183:
.dd 0
_local185:
.dd 0
_local186:
.dd 0
_size4:
.dd 4
_size1:
.dd 1
_zero:
.dd 0

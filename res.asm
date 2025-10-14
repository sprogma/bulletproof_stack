
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
fmul:
MOV fmul - 8, fmul - 12, _0math__size4
MOV _0math__local1, fmul - 16, _0math__size4
MUL fmul - 8, fmul - 8, _0math__local1, _0math__size4
MOV_CONST 1000, _0math__local0
DIV fmul - 8, fmul - 8, _0math__local0, _0math__size4
LEA _0math__local2, _0math__size4
LEA _0math__local3, fmul - 4
$MOV _0math__zero, _0math__local3, _0math__local2
; arguments
.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
fdiv:
MOV fdiv - 8, fdiv - 12, _0math__size4
MOV_CONST 1000, _0math__local5
MUL fdiv - 8, fdiv - 8, _0math__local5, _0math__size4
MOV _0math__local4, fdiv - 16, _0math__size4
DIV fdiv - 8, fdiv - 8, _0math__local4, _0math__size4
LEA _0math__local6, _0math__size4
LEA _0math__local7, fdiv - 4
$MOV _0math__zero, _0math__local7, _0math__local6
; arguments
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
sqrt:
MOV _0math__local8, sqrt - 12, _0math__size4
MOV_CONST 1000, _0math__local9
MUL _0math__local8, _0math__local8, _0math__local9, _0math__size4
MOV _0math__sqrt_aa, _0math__local8, _0math__size4
MOV_CONST 0, _0math__local10
MOV _0math__sqrt_res, _0math__local10, _0math__size4
MOV_CONST 46340, _0math__local11
MOV _0math__sqrt_add, _0math__local11, _0math__size4
LEA _0math__local16, _0math__local15
_0math__local14:
MOV _0math__local15, _0math__sqrt_add, _0math__size4
MOV_CONST 0, _0math__local17
LT _0math__local15, _0math__local17, _0math__local15, _0math__size4
$CLEA _0math__local16, _0math__zero, _0math__local13 
$LEA _0math__zero, _0math__local12
_0math__local13:
MOV _0math__local20, _0math__sqrt_res, _0math__size4
MOV _0math__local24, _0math__sqrt_add, _0math__size4
ADD _0math__local20, _0math__local20, _0math__local24, _0math__size4
MOV _0math__local23, _0math__sqrt_res, _0math__size4
MOV _0math__local25, _0math__sqrt_add, _0math__size4
ADD _0math__local23, _0math__local23, _0math__local25, _0math__size4
MUL _0math__local20, _0math__local20, _0math__local23, _0math__size4
MOV _0math__local22, _0math__sqrt_aa, _0math__size4
LT _0math__local20, _0math__local20, _0math__local22, _0math__size4
LEA _0math__local21, _0math__local20
$CLEA _0math__local21, _0math__zero, _0math__local18 
$LEA _0math__zero, _0math__local19 
_0math__local18:
MOV _0math__local26, _0math__sqrt_res, _0math__size4
MOV _0math__local27, _0math__sqrt_add, _0math__size4
ADD _0math__local26, _0math__local26, _0math__local27, _0math__size4
MOV _0math__sqrt_res, _0math__local26, _0math__size4
_0math__local19:
MOV _0math__local28, _0math__sqrt_add, _0math__size4
MOV_CONST 2, _0math__local29
DIV _0math__local28, _0math__local28, _0math__local29, _0math__size4
MOV _0math__sqrt_add, _0math__local28, _0math__size4
$LEA _0math__zero, _0math__local14 
_0math__local12:
MOV sqrt - 8, _0math__sqrt_res, _0math__size4
LEA _0math__local30, _0math__size4
LEA _0math__local31, sqrt - 4
$MOV _0math__zero, _0math__local31, _0math__local30
; arguments
.dd 0xBEBEBEBE
; return value
.dd 0xBEBEBEBE
; return address
.dd 0xBEBEBEBE
f:
MOV f - 8, f - 12, _0math__size4
MOV_CONST 1000, _0math__local32
MUL f - 8, f - 8, _0math__local32, _0math__size4
LEA _0math__local33, _0math__size4
LEA _0math__local34, f - 4
$MOV _0math__zero, _0math__local34, _0math__local33
_0math__local0:
.dd 0
_0math__local1:
.dd 0
_0math__local2:
.dd 0
_0math__local3:
.dd 0
_0math__local4:
.dd 0
_0math__local5:
.dd 0
_0math__local6:
.dd 0
_0math__local7:
.dd 0
_0math__sqrt_aa:
.dd 0
_0math__sqrt_res:
.dd 0
_0math__sqrt_add:
.dd 0
_0math__local8:
.dd 0
_0math__local9:
.dd 0
_0math__local10:
.dd 0
_0math__local11:
.dd 0
_0math__local15:
.dd 0
_0math__local16:
.dd 0
_0math__local17:
.dd 0
_0math__local20:
.dd 0
_0math__local21:
.dd 0
_0math__local22:
.dd 0
_0math__local23:
.dd 0
_0math__local24:
.dd 0
_0math__local25:
.dd 0
_0math__local26:
.dd 0
_0math__local27:
.dd 0
_0math__local28:
.dd 0
_0math__local29:
.dd 0
_0math__local30:
.dd 0
_0math__local31:
.dd 0
_0math__local32:
.dd 0
_0math__local33:
.dd 0
_0math__local34:
.dd 0
_0math__size4:
.dd 4
_0math__size1:
.dd 1
_0math__zero:
.dd 0


.dd 0xBEBEBEBE
.dd 0xBEBEBEBE
main:

MOV _1main__frame_base, video_start, _1main__size4
MOV_CONST 0, _1main__sample_id

MOV_CONST 8, _1main__tmp1
MUL _1main__frame_size, video_width, video_height, _1main__size4
DIV _1main__frame_size, _1main__frame_size, _1main__tmp1, _1main__size4

MOV_CONST 8, _1main__tmp1
DIV _1main__frame_line_size, video_width, _1main__tmp1, _1main__size4

MOV_CONST 1000, _1main__ms_per_frame
DIV _1main__ms_per_frame, _1main__ms_per_frame, fps, _1main__size4

MOV_CONST 44100, _1main__samples_per_frame
DIV _1main__samples_per_frame, _1main__samples_per_frame, fps, _1main__size4

IN 2, _1main__start_time, _1main__size4
MOV _1main__current_time, _1main__start_time, _1main__size4


MOV_CONST -1, _1main__first_iteration


_1main__inf_loop:
MOV _1main__audiomemend, _1main__audiomembase, _1main__size4

; generate audio samples
MOV_CONST 0, _1main__y
_1main__loop_audio:

; get address of current sample
DIV _1main__tmp1, _1main__sample_id, audio_compression_rate, _1main__size4
MUL _1main__tmp5, _1main__tmp1, audio_compression_rate, _1main__size4
SUB _1main__tmp5, _1main__tmp5, _1main__sample_id, _1main__size4
MUL _1main__tmp1, _1main__tmp1, _1main__four, _1main__size4
ADD _1main__tmp1, _1main__tmp1, audio_start, _1main__size4

; load sample to variable
LEA _1main__tmp_ptr1, _1main__size4
LEA _1main__tmp_ptr2, _1main__tmp2
$MOV _1main__tmp_ptr2, _1main__tmp1, _1main__tmp_ptr1
; load next sample to variable
ADD _1main__tmp1, _1main__tmp1, _1main__four, _1main__size4
LEA _1main__tmp_ptr1, _1main__size4
LEA _1main__tmp_ptr2, _1main__tmp3
$MOV _1main__tmp_ptr2, _1main__tmp1, _1main__tmp_ptr1

; interpolate between this two samples
MOV _1main__tmp1, _1main__tmp2, _1main__size4
SUB _1main__tmp4, _1main__tmp3, _1main__tmp2, _1main__size4
DIV _1main__tmp4, _1main__tmp4, audio_compression_rate, _1main__size4
MUL _1main__tmp4, _1main__tmp4, _1main__tmp5, _1main__size4
; ADD _1main__tmp1, _1main__tmp1, _1main__tmp4, _1main__size4
; copy this sample, padding with zeros
LEA _1main__tmp_ptr1, _1main__size4
LEA _1main__tmp_ptr2, _1main__tmp1
$MOV _1main__audiomemend, _1main__tmp_ptr2, _1main__tmp_ptr1

; move memory pointer
ADD _1main__audiomemend, _1main__audiomemend, _1main__four, _1main__size4
; move sample_id
INC _1main__sample_id, _1main__sample_id, _1main__size4

; audio loop
INC _1main__y, _1main__y, _1main__size4
LEA _1main__tmp_ptr1, _1main__tmp1
LT _1main__tmp1, _1main__y, _1main__samples_per_frame, _1main__size4
$CLEA _1main__tmp_ptr1, _1main__zero, _1main__loop_audio

; skip if this is first iteration, to remove sound gaps:
LEA _1main__tmp_ptr1, _1main__first_iteration
$CLEA _1main__tmp_ptr1, _1main__zero, skip_music_sending
; send music to audio port
SUB _1main__tmp1, _1main__audiomemend, _1main__audiomembase, _1main__size4
LEA _1main__tmp_ptr1, _1main__tmp1
$OUT 3, _1main__audiomembase, _1main__tmp_ptr1
skip_music_sending:

; draw image
MOV _1main__memend, _1main__membase, _1main__size4

MOV_CONST 0, _1main__y
_1main__loop_1:

MOV_CONST 0, _1main__x
_1main__loop_2:

; background
$MOV_CONST 0, _1main__memend

; unpack frame
MOV_CONST 8, _1main__tmp2 ; 8 - bit per byte
DIV _1main__tmp1, _1main__x, _1main__tmp2, _1main__size4
MUL _1main__tmp3, _1main__tmp1, _1main__tmp2, _1main__size4 ; _1main__tmp2 = (x / 8) * 8
SUB _1main__tmp2, _1main__x, _1main__tmp3, _1main__size4 ; _1main__tmp2 = x - (x / 8) * 8
; generate mask from _1main__tmp2: 1 << _1main__tmp2
; use LUT
LEA _1main__tmp3, _1main__mask_LUT
MUL _1main__tmp2, _1main__tmp2, _1main__size4, _1main__size4
ADD _1main__tmp2, _1main__tmp2, _1main__tmp3, _1main__size4
LEA _1main__tmp_ptr2, _1main__tmp2
LEA _1main__tmp_ptr3, _1main__size4
$MOV _1main__tmp_ptr2, _1main__tmp2, _1main__tmp_ptr3
; check: if mask is 1 - add dot on screen
ADD _1main__tmp1, _1main__tmp1, _1main__frame_base, _1main__size4
LEA _1main__tmp_ptr3, _1main__tmp3
LEA _1main__tmp_ptr4, _1main__size4
$MOV _1main__tmp_ptr3, _1main__tmp1, _1main__tmp_ptr4
; now: tmp2 = mask of pixel
; now: tmp3 = byte from data
AND _1main__tmp1, _1main__tmp2, _1main__tmp3, _1main__size4
ANY _1main__tmp1, _1main__tmp1, _1main__size4
INV _1main__tmp1, _1main__tmp1, _1main__size4
LEA _1main__tmp_ptr1, _1main__tmp1
$CLEA _1main__tmp_ptr1, _1main__zero, _1main__black_pixel
$MOV_CONST 16776960, _1main__memend
_1main__black_pixel:

; move memory pointer
ADD _1main__memend, _1main__memend, _1main__four, _1main__size4

; _1main__loop_1
INC _1main__x, _1main__x, _1main__size4
LEA _1main__tmp_ptr1, _1main__tmp1
LT _1main__tmp1, _1main__x, video_width, _1main__size4
$CLEA _1main__tmp_ptr1, _1main__zero, _1main__loop_2

; go to next frame's line
ADD _1main__frame_base, _1main__frame_base, _1main__frame_line_size, _1main__size4

; check if video is end?

; _1main__loop_2
INC _1main__y, _1main__y, _1main__size4
LEA _1main__tmp_ptr1, _1main__tmp1
LT _1main__tmp1, _1main__y, video_height, _1main__size4
$CLEA _1main__tmp_ptr1, _1main__zero, _1main__loop_1

; wait to make right fps, image is already ready to draw, so only wait
; move time to next frame
ADD _1main__current_time, _1main__current_time, _1main__ms_per_frame, _1main__size4
; wait to make right fps
_1main__wait:
IN 2, _1main__tmp1, _1main__size4
LT _1main__tmp1, _1main__tmp1, _1main__current_time, _1main__size4
LEA _1main__tmp_ptr1, _1main__tmp1
$CLEA _1main__tmp_ptr1, _1main__zero, _1main__wait

; if this is first iteration, then send sound now:
INV _1main__tmp1, _1main__first_iteration, _1main__size4
LEA _1main__tmp_ptr1, _1main__tmp1
$CLEA _1main__tmp_ptr1, _1main__zero, not_first_iteration
; now it isn't first iteration
MOV_CONST 0, _1main__first_iteration
; send music to audio port
SUB _1main__tmp1, _1main__audiomemend, _1main__audiomembase, _1main__size4
LEA _1main__tmp_ptr1, _1main__tmp1
$OUT 3, _1main__audiomembase, _1main__tmp_ptr1
not_first_iteration:

; draw image
SUB _1main__tmp1, _1main__memend, _1main__membase, _1main__size4
LEA _1main__tmp_ptr1, _1main__tmp1
$OUT 1, _1main__membase, _1main__tmp_ptr1


; infite loop
$LEA _1main__zero, _1main__inf_loop

; return
LEA _1main__tmp_ptr2, main - 4
LEA _1main__tmp_ptr1, _1main__size4
$MOV _1main__zero, _1main__tmp_ptr2, _1main__tmp_ptr1


_1main__membase:
.dd 0x010000
_1main__memend:
.dd 0
_1main__audiomembase:
.dd 0x045000
_1main__audiomemend:
.dd 0
; need video to be loaded at this pointer
video_start:
.dd 0x080000
video_width:
.dd 160
video_height:
.dd 90
audio_start:
.dd 0x1080000
audio_compression_rate:
.dd 5
fps:
.dd 25
_1main__ms_per_frame:
.dd 0
_1main__sample_id:
.dd 0
_1main__samples_per_frame:
.dd 0
_1main__frame_base:
.dd 0
_1main__frame_size:
.dd 0
_1main__frame_line_size:
.dd 0
_1main__start_time:
.dd 0
_1main__current_time:
.dd 0


_1main__mask_LUT:
.dd 0x01
.dd 0x02
.dd 0x04
.dd 0x08
.dd 0x10
.dd 0x20
.dd 0x40
.dd 0x80

_1main__x:
.dd 0
_1main__y:
.dd 0
_1main__first_iteration:
.dd 0

_1main__tmp1:
.dd 0
_1main__tmp2:
.dd 0
_1main__tmp3:
.dd 0
_1main__tmp4:
.dd 0
_1main__tmp5:
.dd 0
_1main__tmp_ptr1:
.dd 0
_1main__tmp_ptr2:
.dd 0
_1main__tmp_ptr3:
.dd 0
_1main__tmp_ptr4:
.dd 0

_1main__one:
.dd 1
_1main__two:
.dd 4
_1main__four:
.dd 4

_1main__zero:
.dd 0
_1main__flt_size:
.dd 4
_1main__flt_base:
.dd 1000
_1main__size4:
.dd 4
_1main__size1:
.dd 1



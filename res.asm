MOV _frame_base, video_start, _size4
MOV_CONST 0, _sample_id

MOV_CONST 8, _tmp1
MUL _frame_size, video_width, video_height, _size4
DIV _frame_size, _frame_size, _tmp1, _size4

MOV_CONST 8, _tmp1
DIV _frame_line_size, video_width, _tmp1, _size4

MOV_CONST 1000, _ms_per_frame
DIV _ms_per_frame, _ms_per_frame, fps, _size4

MOV_CONST 44100, _samples_per_frame
DIV _samples_per_frame, _samples_per_frame, fps, _size4

IN 2, _start_time, _size4
MOV _current_time, _start_time, _size4


MOV_CONST -1, _first_iteration


_inf_loop:
MOV _audiomemend, _audiomembase, _size4

; generate audio samples
MOV_CONST 0, _y
_loop_audio:

; get address of current sample
DIV _tmp1, _sample_id, audio_compression_rate, _size4
MUL _tmp5, _tmp1, audio_compression_rate, _size4
SUB _tmp5, _tmp5, _sample_id, _size4
MUL _tmp1, _tmp1, _four, _size4
ADD _tmp1, _tmp1, audio_start, _size4

; load sample to variable
LEA _tmp_ptr1, _size4
LEA _tmp_ptr2, _tmp2
$MOV _tmp_ptr2, _tmp1, _tmp_ptr1
; load next sample to variable
ADD _tmp1, _tmp1, _four, _size4
LEA _tmp_ptr1, _size4
LEA _tmp_ptr2, _tmp3
$MOV _tmp_ptr2, _tmp1, _tmp_ptr1

; interpolate between this two samples
MOV _tmp1, _tmp2, _size4
SUB _tmp4, _tmp3, _tmp2, _size4
DIV _tmp4, _tmp4, audio_compression_rate, _size4
MUL _tmp4, _tmp4, _tmp5, _size4
; ADD _tmp1, _tmp1, _tmp4, _size4
; copy this sample, padding with zeros
LEA _tmp_ptr1, _size4
LEA _tmp_ptr2, _tmp1
$MOV _audiomemend, _tmp_ptr2, _tmp_ptr1

; move memory pointer
ADD _audiomemend, _audiomemend, _four, _size4
; move sample_id
INC _sample_id, _sample_id, _size4

; audio loop
INC _y, _y, _size4
LEA _tmp_ptr1, _tmp1
LT _tmp1, _y, _samples_per_frame, _size4
$CLEA _tmp_ptr1, _zero, _loop_audio

; skip if this is first iteration, to remove sound gaps:
LEA _tmp_ptr1, _first_iteration
$CLEA _tmp_ptr1, _zero, skip_music_sending
; send music to audio port
SUB _tmp1, _audiomemend, _audiomembase, _size4
LEA _tmp_ptr1, _tmp1
$OUT 3, _audiomembase, _tmp_ptr1
skip_music_sending:

; draw image
MOV _memend, _membase, _size4

MOV_CONST 0, _y
_loop_1:

MOV_CONST 0, _x
_loop_2:

; background
$MOV_CONST 0, _memend

; unpack frame
MOV_CONST 8, _tmp2 ; 8 - bit per byte
DIV _tmp1, _x, _tmp2, _size4
MUL _tmp3, _tmp1, _tmp2, _size4 ; _tmp2 = (x / 8) * 8
SUB _tmp2, _x, _tmp3, _size4 ; _tmp2 = x - (x / 8) * 8
; generate mask from _tmp2: 1 << _tmp2
; use LUT
LEA _tmp3, _mask_LUT
MUL _tmp2, _tmp2, _size4, _size4
ADD _tmp2, _tmp2, _tmp3, _size4
LEA _tmp_ptr2, _tmp2
LEA _tmp_ptr3, _size4
$MOV _tmp_ptr2, _tmp2, _tmp_ptr3
; check: if mask is 1 - add dot on screen
ADD _tmp1, _tmp1, _frame_base, _size4
LEA _tmp_ptr3, _tmp3
LEA _tmp_ptr4, _size4
$MOV _tmp_ptr3, _tmp1, _tmp_ptr4
; now: tmp2 = mask of pixel
; now: tmp3 = byte from data
AND _tmp1, _tmp2, _tmp3, _size4
ANY _tmp1, _tmp1, _size4
INV _tmp1, _tmp1, _size4
LEA _tmp_ptr1, _tmp1
$CLEA _tmp_ptr1, _zero, _black_pixel
$MOV_CONST 16776960, _memend
_black_pixel:

; move memory pointer
ADD _memend, _memend, _four, _size4

; _loop_1
INC _x, _x, _size4
LEA _tmp_ptr1, _tmp1
LT _tmp1, _x, video_width, _size4
$CLEA _tmp_ptr1, _zero, _loop_2

; go to next frame's line
ADD _frame_base, _frame_base, _frame_line_size, _size4

; check if video is end?

; _loop_2
INC _y, _y, _size4
LEA _tmp_ptr1, _tmp1
LT _tmp1, _y, video_height, _size4
$CLEA _tmp_ptr1, _zero, _loop_1

; wait to make right fps, image is already ready to draw, so only wait
; move time to next frame
ADD _current_time, _current_time, _ms_per_frame, _size4
; wait to make right fps
_wait:
IN 2, _tmp1, _size4
LT _tmp1, _tmp1, _current_time, _size4
LEA _tmp_ptr1, _tmp1
$CLEA _tmp_ptr1, _zero, _wait

; if this is first iteration, then send sound now:
INV _tmp1, _first_iteration, _size4
LEA _tmp_ptr1, _tmp1
$CLEA _tmp_ptr1, _zero, not_first_iteration
; now it isn't first iteration
MOV_CONST 0, _first_iteration
; send music to audio port
SUB _tmp1, _audiomemend, _audiomembase, _size4
LEA _tmp_ptr1, _tmp1
$OUT 3, _audiomembase, _tmp_ptr1
not_first_iteration:

; draw image
SUB _tmp1, _memend, _membase, _size4
LEA _tmp_ptr1, _tmp1
$OUT 1, _membase, _tmp_ptr1


; infite loop
$LEA _zero, _inf_loop

.db 0xFF

_membase:
.dd 0x010000
_memend:
.dd 0
_audiomembase:
.dd 0x25000
_audiomemend:
.dd 0
; need video to be loaded at this pointer
video_start:
.dd 0x40000
video_width:
.dd 160
video_height:
.dd 90
audio_start:
.dd 0x80000
audio_compression_rate:
.dd 5
fps:
.dd 25
_ms_per_frame:
.dd 0
_sample_id:
.dd 0
_samples_per_frame:
.dd 0
_frame_base:
.dd 0
_frame_size:
.dd 0
_frame_line_size:
.dd 0
_start_time:
.dd 0
_current_time:
.dd 0


_mask_LUT:
.dd 0x01
.dd 0x02
.dd 0x04
.dd 0x08
.dd 0x10
.dd 0x20
.dd 0x40
.dd 0x80

_x:
.dd 0
_y:
.dd 0
_first_iteration:
.dd 0

_tmp1:
.dd 0
_tmp2:
.dd 0
_tmp3:
.dd 0
_tmp4:
.dd 0
_tmp5:
.dd 0
_tmp_ptr1:
.dd 0
_tmp_ptr2:
.dd 0
_tmp_ptr3:
.dd 0
_tmp_ptr4:
.dd 0

_one:
.dd 1
_two:
.dd 4
_four:
.dd 4

_zero:
.dd 0
_flt_size:
.dd 4
_flt_base:
.dd 1000
_size4:
.dd 4
_size1:
.dd 1


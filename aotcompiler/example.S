.intel_syntax noprefix
.extern printf
.global main

.section .rdata
fmt:
    .asciz "Hello, world!\n"

.text
main:
    sub rsp, 40

    lea rcx, [rip + fmt]
    call printf

    mov eax, 0
    
    add rsp, 40
    ret


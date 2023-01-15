; This will just repeat the input text, but with syscalls
global main

section .data
    inputPrompt: db "Enter text: ", 10, 0
    inputPromptLen: equ $ - inputPrompt

section .bss
    data: resb 128

section .text
main:
    ; Setup
    push rbp

    ; Input prompt
    mov rax, 1
    mov rdi, 1
    mov rsi, inputPrompt
    mov rdx, inputPromptLen
    syscall

    ; Input
    mov rax, 0
    mov rdi, 0
    mov rsi, data
    mov rdx, 128
    syscall

    ; Output
    mov rax, 1
    mov rdi, 1
    mov rsi, data
    mov rdx, 128
    syscall

    ; Exit
    pop rbp
    mov rax, 60
    xor rdi, rdi
    syscall

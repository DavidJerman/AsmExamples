section .data
	inputPrompt: db "Enter text:", 10, 0
	inputPromptLen: equ $-inputPrompt	

section .bss
	data: resb 128
	

section .text

global main

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
	mov rdi, 0     ; Syscall for read
	mov rsi, data  ; Save location
	mov rdx, 128   ; Buffer size 
	syscall

	; Call function
	; In: %rbx - size in bytes
	; In: %rsi - text address
	; Out: %rax - text address
	mov rbx, rax
	mov rsi, data
	push rbx
	call .toLowerUnderscore
	pop rbx

	; Print
	mov rdi, 1
	mov rsi, rax
	mov rax, 1
	mov rdx, rbx
	syscall

	; Exit
	mov rax, 60
	mov rdi, 0
	syscall

.toLowerUnderscore:
	; Init
	push rsi
	mov rdi, rsi
	xor rcx, rcx     ; Counter

.toLowerLoop:
	; If
	cmp rcx, rbx
	jge .exitToLower
	inc rcx
	
	lodsb     ; Res in al (rax)
	cmp al, 0x20
	je .space
	cmp al, 65
	jl .skip
	cmp al, 90
	jg .skip
	add rax, 32
	jmp .skip
.space:
	mov rax, 95
.skip:
	; Goto
	stosb
	jmp .toLowerLoop

.exitToLower:
	pop rax
	ret


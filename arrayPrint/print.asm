extern printf
extern scanf

global main

section .data
	inputPrompt: db "Enter the number N:", 10, 0
	inputFormat: db "%ld", 0
	outputFormat: db "%ld", 10, 0

section .bss
	N: resq 1

section .text
main:
	; Setup
	push rbp

	; Input prompt
	mov rdi, inputPrompt
	xor rsi, rsi
	xor rax, rax
	call printf

	; Input
	mov rdi, inputFormat
	mov rsi, N
	xor rax, rax
	call scanf

	; Loop
	mov rbx, 0  ; i
.loop:
	inc rbx
	cmp rbx, [N]
	jg .end
	xor rdx, rdx
	mov rax, rbx
	mov rcx, 3
	div rcx
	cmp rdx, 0
	jne .loop
	; Print
	mov rdi, outputFormat
	mov rsi, rbx
	xor rax, rax
	call printf
	jmp .loop
.end:
	pop rbp
	mov rax, 60
	mov rdi, 0
	syscall

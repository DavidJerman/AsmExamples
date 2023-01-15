
extern printf
extern scanf

section .data
	inputPrompt: db "Enter numbers:", 10, 0
	inputFormat: db "%s", 0
	outputFormat: db "Max of %ld, %ld, %ld: %ld", 10, 0

section .bss
	data: resb 128

section .text

global main

main:
	; Setup
	push rbp

	; Input prompt
	mov rdi, inputPrompt
	xor rax, rax
	call printf

	; Input
	mov rdi, inputFormat
	mov rsi, data
	xor rax, rax
	call scanf

	; Call function
	mov rdi, data
	call .maxOf3

	; Print
	mov rdi, outputFormat
	mov rsi, rax
	mov r8, rdx
	mov rcx, rcx
	mov rdx, rbx
	call printf

	; Exit
	pop rbp
	mov rax, 60
	xor rdi, rdi
	syscall

; Function
; Input:
; 	%rdi - Array address
; Output:
; 	%rax - A
; 	%rbx - B
; 	%rcx - C
; 	%rdx - Max
.maxOf3:
	; Setup
	mov rsi, rdi
	xor rax, rax ; A
	xor rbx, rbx ; B
	xor rcx, rcx ; C
	xor rdx, rdx ; D = Max
	xor rdi, rdi ; Counter

	cld

.loop:
	; If end
	lodsb
	cmp al, 0
	jz .endLoop
	inc rdi
	jmp .loop

.endLoop:
	; Setup
	sub rsi, 2

	; Not enough numbers
	cmp rdi, 3
	jl .exitFault

	; Get the numbers
	std
	lodsb
	mov rcx, rax
	sub rcx, 48
	lodsb
	mov rbx, rax
	sub rbx, 48
	lodsb
	sub rax, 48

	; Maximum of three
	cmp rax, rbx
	jl .bc
	cmp rax, rcx
	jl .c
	mov rdx, rax
	jmp .exit

.bc:
	cmp rbx, rcx
	jl .c
	mov rdx, rbx
	jmp .exit

.c:
	mov rdx, rcx
	jmp .exit

.exitFault:
	mov rax, 0
	mov rbx, 0
	mov rcx, 0
	mov rdx, 0
.exit:
	ret

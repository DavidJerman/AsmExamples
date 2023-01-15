extern printf
extern scanf

global main

section .data
	inputPrompt: db "Enter the array:", 10, 0
	inputFormat: db "%s", 0
	outputFormat: db "Avg: %ld", 10, 0

section .bss
	data: resb 128

section .text
main:
	push rbp

	; Prompt
	mov rdi, inputPrompt
	xor rsi, rsi
	mov rax, 0
	call printf

	; Input
	mov rdi, inputFormat
	mov rsi, data
	xor rax, rax
	call scanf

	; Function call	
	; In:
	; 	rdi - data array
	; Out:
	; 	rax - result
	mov rdi, data
	call .avg

	; Output
	mov rdi, outputFormat
	mov rsi, rax
	xor rax, rax
	call printf

	; Exit
	pop rbp
	mov rax, 60
	mov rdi, 0
	syscall

.avg:
	xor rbx, rbx ; Sum
	xor rcx, rcx ; Counter
	mov rsi, rdi
	cld
.loop:
	lodsb
	cmp al, 0
	jz .end
	sub rax, 48
	add rbx, rax
	inc rcx
	jmp .loop
.end:
	cmp rcx, 0
	jz .error
	mov rax, rbx
	div rcx
	ret
.error:
	mov rax, 0
	ret






extern printf
extern scanf 

section .data
	inputPrompt: db "Enter the numbers:", 10, 0
	inputFormat: db "%s", 0
	outputFormat: db "Sum: %ld", 10, 0

section .bss
	data: resb 128
	N: resq 1

section .text

global main

main:
	push rbp
	
	mov rdi, inputPrompt
	xor rax, rax
	call printf

	mov rdi, inputFormat
	mov rsi, data
	xor rax, rax
	call scanf

	mov rdi, data
	call .sum

	mov rdi, outputFormat
	mov rsi, rax
	xor rax, rax
	call printf

	pop rbp
	xor rax, rax
	ret

.sum:
	xor rbx, rbx
	xor rax, rax
	mov rsi, rdi

.loop:	
	lodsb
	cmp al, 0
	jz .end
	
	sub al, 48
	add rbx, rax 
	jmp .loop

.end:
	mov rax, rbx
	ret	

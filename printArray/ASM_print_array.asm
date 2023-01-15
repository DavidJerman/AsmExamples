extern printf

section .data
	data: db "Hello world!", 10, 0
	output: db "%c ", 10, 0 

section .text
	
global main

main:
	; Setup
	push rbp
	mov rsi, data	

.loop:
	xor rax, rax
	lodsb
	cmp al, 0
	jz .end

	push rsi	
	mov rbx, rsi
	mov rdi, output
	mov rsi, rax
	xor rax, rax
	call printf
	mov rsi, rbx
	pop rsi	

	jmp .loop

.end:
	pop rbp
	xor rax, rax
	ret

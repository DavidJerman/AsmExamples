extern scanf
extern printf

section .data
	in: db "%ld", 0
	out: db "%ld", 10, 0

section .bss
	i resq 1
	N resq 1

section .text
global main

main:
	push rbp

	mov rdi, in
	mov rsi, N
	mov rax, 0
	call scanf

	mov qword [i], 1
	
.loop:
	mov rax, [i]
	cmp rax, [N]

	jg .exit

	mov rsi, 11
	mov rdx, 0
	div rsi
	cmp rdx, 0

	jne .skip

	mov rdi, out
	mov rsi, [i]
	mov rax, 0
	call printf

.skip:
	inc qword [i]

	jmp .loop

.exit:
	pop rbp
	mov rax, 0
	ret
	

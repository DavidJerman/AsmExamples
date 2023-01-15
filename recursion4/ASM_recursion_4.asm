extern printf
extern scanf

section .data
	inputPrompt: db "Enter the number n: ", 0
	inputFormat: db "%ld", 0
	outputFormat: db "f(%ld) = %ld", 10, 0

section .bss
	i: resq 1
	N: resq 1

section .text

global main

main:
	; Setup
	push rbp
	mov qword [i], 0

	; Input prompt
	mov rdi, inputPrompt
	xor rax, rax
	call printf

	; Input
	mov rdi, inputFormat
	mov rsi, N
	xor rax, rax
	call scanf

	; Loop
.loop:
	mov rax, [i]
	cmp rax, [N]
	jg .exit

	; Function call
	mov rdi, [i]
	call .recursion
	
	; Print
	mov rdi, outputFormat
	mov rsi, [i]
	mov rdx, rax
	xor rax, rax
	call printf

	inc qword [i]
	
	jmp .loop

; f(n) = 2*f(n - 1) + 7*f(n - 2) + f(n - 3)/3
.recursion:
	cmp rdi, 0
	jz .rec0

	cmp rdi, 1
	jz .rec1

	cmp rdi, 2
	jz .rec2

	; f(n - 1)
	push rdi
	sub rdi, 1
	call .recursion

	; f(n - 2)
	pop rdi
	push rax
	push rdi
	sub rdi, 2
	call .recursion

	; f(n - 3)
	pop rdi
	push rax
	push rdi
	sub rdi, 3
	call .recursion

	; Sum
	pop rdi
	xor rcx, rcx ; Sum
	xor rdx, rdx
	mov rbx, 3
	div rbx
	add rcx, rax

	pop rax
	mov rdx, 7
	mul rdx
	add rcx, rax

	pop rax
	shl rax, 1
	add rcx, rax

	mov rax, rcx
	ret

.rec0:
	mov rax, 6
	ret

.rec1:
	mov rax, 10
	ret

.rec2:
	mov rax, 13
	ret

.exit:
	pop rbp
	xor rax, rax
	ret

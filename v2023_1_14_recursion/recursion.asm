; f(n) = f(n - 1) + f(n - 2) + f(n - 3) + 5
; f(0) = 1
; f(1) = 3
; f(2) = 7
extern printf
extern scanf

global main

section .data
	inputPrompt: db "Enter the data:", 10, 0
	inputFormat: db "%ld", 0
	outputFormat: db "f(%ld) = %ld", 10, 0

section .bss
	N: resq 1

section .text
main:
	; Setup
	push rbp

	; Input prompt
	mov rdi, inputPrompt
	xor rax, rax
	call printf

	; Input
	mov rdi, inputFormat
	mov rsi, N
	mov rax, 0
	call scanf

	; Function
	; In:
	; 	rdi - N
	; Out:
	; 	rax - result
	mov rdi, [N]
	call .Fn
	
	; Output
	mov rdi, outputFormat
	mov rsi, [N]
	mov rdx, rax
	xor rax, rax
	call printf

	; Exit
	pop rbp
	mov rax, 0
	ret

.Fn:
; f(n) = f(n - 1) + f(n - 2) + f(n - 3) + 5
; f(0) = 1
; f(1) = 3
; f(2) = 7
	cmp rdi, 0
	jz .F0
	cmp rdi, 1
	jz .F1
	cmp rdi, 2
	jz .F2		

	push rdi
	dec rdi    ; n - 1
	call .Fn
	
	pop rdi
	push rax
	push rdi
	sub rdi, 2 ; n - 2
	call .Fn

	pop rdi
	push rax
	push rdi
	sub rdi, 3 ; n - 3
	call .Fn

	xor rbx, rbx ; Sum
	pop rdi
	add rbx, 5
	add rbx, rax
	pop rax
	add rbx, rax
	pop rax
	add rbx, rax

	mov rax, rbx
	ret
.F0:
	mov rax, 1
	ret
.F1:
	mov rax, 3
	ret
.F2:
	mov rax, 7
	ret


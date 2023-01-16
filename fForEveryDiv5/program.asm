; There is a crash, but will investigate later

extern scanf
extern printf

global main

section .data
	inputPrompt: db "Enter the array:", 10, 0
	inputFormat: db "%s", 0
	outputFormat: db "f(%ld) = %ld", 10, 0

section .bss
	data: resb 128
	
section .text
main:
    mov rbp, rsp; for correct debugging
	; Setup
	push rbp
	
	; Input prompt
	mov rdi, inputPrompt
	xor rsi, rsi
	xor rax, rax
	call printf

	; Input
	mov rdi, inputFormat
	mov rsi, data
	xor rax, rax
	call scanf

	; Function call
	; In:
	; 	%rdi - data
	; Out:
	; 	- nothing
	mov rdi, data
	call .loop5
	
	; Exit
        pop rbp
	pop rbp	
	mov rax, 60
	mov rdi, 0
	syscall

.loop5:
	mov rsi, rdi
.loop:
	lodsb
	cmp al, 0
	je .endLoop5
	sub rax, 48
	push rax
	mov rbx, 5
	xor rdx, rdx
	div rbx
	cmp rdx, 0
	jne .loop
	pop rax
        push rax
	call .Fn
        pop rax
	mov rbx, rdi
	mov rdi, outputFormat
	mov rsi, rax
	mov rdx, rbx
        xor rax, rax
        push rbp
	call printf
        pop rbp
	jmp .loop
.endLoop5:
	ret
; F(n) = f(n - 3) * 2 + f(n - 1)
; In:
; 	%rax - n
; Out:
;	%rdi - f(n)
.Fn:
	cmp rax, 0
	je .F0
	cmp rax, 1
	je .F1
	cmp rax, 2
	je .F2
	
	push rax
	dec rax
	call .Fn
	
	pop rax
	push rdi
	push rax
	sub rax, 2
	call .Fn

	mov rax, rdi
	mov rcx, 2
	mul rcx
	pop rdi
	pop rdi
	add rax, rdi
	mov rdi, rax
	ret
.F0:
	mov rdi, 2
	ret
.F1:
	mov rdi, 3
	ret
.F2:
	mov rdi, 5
	ret

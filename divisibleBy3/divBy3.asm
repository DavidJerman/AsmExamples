extern scanf
extern printf

global main

section .data
	inputPrompt: db "Enter the number array:", 10, 0
	inputFormat: db "%s", 0
	outputFormat: db "%s", 10, 0

section .bss
	data: resb 128
	divBy3: resb 128

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
	mov rsi, data
	xor rax, rax
	call scanf

	; Function call
	mov rdi, data
	mov rsi, divBy3
	call .div3
	
	; Print
	mov rdi, outputFormat
	mov rsi, rax
	xor rax, rax
	call printf

	; Exit
	pop rbp
	mov rax, 0
	ret

; Function
; In:
; 	%rdi - data
; 	%rsi - div3data
; Out:
;	%rax - div3data
.div3:
	mov rbx, rsi
	mov rsi, rdi ; data
	mov rdi, rbx ; div3data
	mov r8, rdi  ; Org 3data
	cld
.loop:
	lodsb
	cmp al, 0
	jz .endLoop
	sub rax, 48
	push rax
	mov rbx, 3
	xor rdx, rdx
	div rbx
	pop rax
	cmp rdx, 0
	jne .loop
	add rax, 48
	stosb
	jmp .loop
.endLoop:
	mov rax, r8
	ret

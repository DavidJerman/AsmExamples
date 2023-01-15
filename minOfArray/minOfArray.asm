extern printf
extern scanf

global main

section .data
	inputPrompt: db "Please enter the numbers: ", 0
	inputFormat: db "%s", 0
	outputFormat: db "Min (%s) = %d", 10, 0

section .bss
	data: resb 1024

section .text
main:
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
	; 	rdi - data source
	; Out:
	; 	rax - min of data
	mov rdi, data	
	call .min
	
	; Print
	mov rdi, outputFormat
	mov rsi, data	
	mov rdx, rax
	xor rax, rax	
	call printf

	; Exit
	pop rbp
	mov rax, 60
	mov rdi, 0
	syscall

.min:
	mov rsi, rdi
	xor rax, rax	
	xor rbx, rbx
	mov bl, byte [rsi] ; Min
	sub bl, 48    ; ASCII to actual number -> Assumes numbers are entered
	inc rdi
	cld
.loop:
	lodsb
	cmp al, 0
	jz .end
	sub al, 48
	cmp bl, al
	jl .loop
	mov bl,al
	jmp .loop
.end:
	mov al, bl
	ret

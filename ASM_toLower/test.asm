extern printf
extern scanf

section .data
	inputPrompt: db "Enter the numbers (0 - 9): ", 0
	inputFormat: db "%s", 0
	outputFormat: db "Average: %ld", 10, 0

section .bss
	data: resb 128
	temp: resq 1

global main

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
	call .average
	
	; Print out the result
	mov rdi, outputFormat
	mov rsi, rax
	xor rax, rax
	call printf

	; End of the program
	pop rbp
	xor rax, rax
	ret
	
.average:
	; Function - Average of numbers
	; Input:	
	; 	%rdi - Data address
	; Output:
	; 	%rax - Average value
	
	; Init
	xor rbx, rbx ; Sum
	xor rcx, rcx ; Count
	mov rsi, rdi
	
.averageLoop:
	; Load the data
	lodsb
	
	; If end of the loop
	cmp al, 0
	jz .averageEnd
	inc rcx

	; Process value
	; ASCII convert
	mov byte [temp], al
	mov rax, [temp]
	sub rax, 48
	add rbx, rax ; Cannot add 8-bit register to 64-bit register?
	
	jmp .averageLoop

.averageEnd:
	; Divide here
	mov rax, rbx
	div rcx
	
	; Return result
	ret

extern scanf
extern printf

section .data
	inputPrompt: db "Enter text: ", 0
	inputFormat: db "%s", 0
	outputFormat: db "Text: %s", 10, 0
	outputFormatA: db "Reversing... %ld and %ld", 10, 0

section .bss
	text: resb 1024

global main

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
	mov rsi, text
	xor rax, rax
	call scanf

; Function call, rax output, rdi input
	mov rdi, text
	call .reverse

	mov rdi, outputFormat
	mov rsi, text
	xor rax, rax
	call printf

	pop rbp
	xor rax, rax
	ret

.reverse:
	mov rsi, rdi
	cld
.length:
	lodsb
	cmp al, 0
	jnz .length
	
	; End of text
	sub rsi, 2

.swap:
	cmp rsi, rdi
	jle .endSwap
	mov byte dl, [rdi]
	std
	lodsb
	mov byte [rsi+1], dl
	cld
	stosb

	jmp .swap

.endSwap:
	ret

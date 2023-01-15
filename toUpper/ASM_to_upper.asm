extern printf
extern scanf 

section .data
	inputPrompt: db "Enter data:", 10, 0
	inputFormat: db "%s", 0
	outputFormat: db "To upper case: %s", 10, 0

section .bss
	data: resb 128

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
	call .toUpper

	; Output
	mov rdi, outputFormat
	mov rsi, data
	xor rax, rax
	call printf

	; Exit
	pop rbp
	xor rax, rax
	ret

; Cast letters to upper letters
; Input:
; 	%rdi - Text address
; Output:
; 	%rax - Text address
.toUpper:
	; Setup
	xor rax, rax
	mov rbx, rdi
	mov rsi, rdi

	; Loop
.loop:
	; If last symbol, return
	lodsb
	cmp al, 0
	jz .end
	
	; If letter, to upper case, otherwise increase rdi
	cmp al, 97
	jl .skipUpper
	cmp al, 122
	jg .skipUpper
	sub al, 32
.skipUpper:
	stosb
	jmp .loop

.end:
	mov rax, rbx
	ret

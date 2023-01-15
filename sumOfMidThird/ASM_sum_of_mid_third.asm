extern printf
extern scanf

section .data
	inputPrompt: db "Enter the numbers:", 10, 0
	inputFormat: db "%s", 0
	outputFormat: db "Sum of [%s]: %ld", 10, 0

section .bss
	data: resb 128

section .text

global main

main:
	; Setup
	push rbp

	; Input prompt
	mov rdi, inputPrompt
	xor rax, rax
	call printf

	; Input
	mov rdi, inputFormat
	mov rsi, data
	xor rax, rax
	call scanf

	; Function call
	mov rdi, data
	call .sum

	; Print result
	mov rdi, outputFormat
	mov rsi, data
	mov rdx, rax
	xor rax, rax
	call printf

	; Exit
	pop rbp
	xor rax, rax
	ret

.sum:
	; Setup
	mov rsi, rdi
	xor r8, r8   ; Size counter
                     ; Begin - rsi
	xor r10, r10 ; End
	xor rax, rax ; Sum

	; Length of the word
	cld
.length:
	lodsb
	cmp al, 0
	jz .endLength
	inc r8
	jmp .length

.endLength:
	; Divide - get begin and end
	mov rax, r8
	mov rcx, 3
	div rcx
	mov rsi, rdi
	add rsi, rax
	shl rax, 1
	mov r10, rdi
	add r10, rax

	; Add together
	xor rax, rax
	xor r8, r8 ; Sum

.sumLoop:
	lodsb
	cmp rsi, r10
	jg .endSum
	add r8, rax
	sub r8, 48
	jmp .sumLoop

.endSum:
	mov rax, r8
	ret

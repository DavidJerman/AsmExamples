extern scanf
; Output using syscall

section .data
	inputPrompt: db "Enter the text: ", 10, 0
	inLen: equ $-inputPrompt
	inputFormat: db "%s", 0
	newLine: db " ", 10, 0
	newLineLen: equ $-newLine

section .bss
	data: resb 128

section .text

global main

main:
	; Setup
	push rbp

	; Input prompt
	mov rax, 1
	mov rdi, 1
	mov rsi, inputPrompt
	mov rdx, inLen
	syscall

	; Input
	mov rdi, inputFormat
	mov rsi, data
	xor rax, rax
	call scanf

	; Function call
	mov rdi, data
	call .removeLast3

	; Print result
	mov rax, 1
	mov rdi, 1
	mov rsi, data
	syscall
	mov rax, 1
	mov rdi, 1
	mov rsi, newLine
	mov rdx, newLineLen
	syscall

	; Exit
	pop rbp
	ret

; Input: rdi - address
; Output: rax - address
;         rdx - size
.removeLast3:
	; Setup
	xor rdx, rdx ; Counter
	mov rsi, rdi
	cld

.loop:
	; If end of data
	lodsb
	cmp al, 0
	jz .exitLoop
	inc rdx
	jmp .loop

.exitLoop:
	sub rsi, 2

	; Check if enough letters
	cmp rdx, 3
	jl .exitFailure

	; Quick hack - just place a zero at the right spot
	mov byte [rsi-2], 0
	jmp .exit

.exitFailure:
	mov rax, rdi
.exit:
	sub rdx, 3
	ret

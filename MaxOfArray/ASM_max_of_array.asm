extern printf
extern scanf

section .data
	inputPrompt: db "Enter the numbers (0 - 9): ", 10, 0
	inputFormat: db "%s", 0
	outputFormat: db "Largest number: %ld", 10, 0

section .bss
	data: resb 128
	n: resq 1

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

; Function: data address in rdi, output in rax
	mov rdi, data
	call .maxOfNumbers

	; End
	; Print result
	mov rdi, outputFormat
	; mov qword [n], rax
	mov rsi, [n]
	xor rax, rax
	call printf

	; Exit
	pop rbp
	xor rax, rax
	ret

.maxOfNumbers:
	; Init
	mov bl, 0
	mov rsi, rdi
	
.maxOfNumbersLoop:
	; If end of the loop
	lodsb
	cmp al, 0
	jz .maxOfNumbersEnd

	sub al, 48
	cmp al, bl	
	jle .maxOfNumbersLoop
.isBigger:
	mov bl, al
	jmp .maxOfNumbersLoop

.maxOfNumbersEnd:
	mov byte [n], bl
	; mov rax, [n]
	ret

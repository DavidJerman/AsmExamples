; V pomoc
; ZAMUDA, Aleš in BREST, Janez, 2019, Računalniške arhitekture : zbirka vaj in nalog z rešitvami [na spletu]. Drugo učno gradivo. Maribor : Fakulteta za elektrotehniko, računalništvo in informatiko. [Dostopano 23 november 2022]. Pridobljeno s: https://dk.um.si/IzpisGradiva.php?lang=slv&id=75357

extern scanf
extern printf

section .bss
	a: resq 1
	b: resq 1
	c: resq 1

section .data
	inputPrompt: db "Enter 3 numbers: ", 10, 0
	outputFormat: db "The biggest of the three numbers is %ld!", 10, 0
	inputFormat: db "%ld", 0
	longOut: db "%ld", 10, 0
	test: dq 3335435, 0

global main

section .text
main:
	; Setup
	push rbp

	; Enter numbers
	
	; Print
	mov rdi, inputPrompt
	xor rsi, rsi
	xor rax, rax
	call printf

	; A
	mov rdi, inputFormat
	mov rsi, a
	xor rax, rax
	call scanf
	
	; B
	mov rdi, inputFormat
	mov rsi, b
	xor rax, rax
	call scanf

	; C
	mov rdi, inputFormat
	mov rsi, c
	xor rax, rax
	call scanf

; Function accepts values inside of rbx-rdx
; Return values is saved in rax
	
	; Function input setup
	mov rbx, [a]
	mov rcx, [b]
	mov rdx, [c]

	call .max3
	
	; Print
	mov rdi, outputFormat
	mov rsi, rax
	xor rax, rax
	call printf
	
	jmp .exit

.max3:
	; A is biggest
	cmp rbx, rcx
	jl .bc
	cmp rbx, rdx
	jl .bc
	mov rax, rbx
	ret
.bc:
	; B is biggest
	cmp rcx, rdx
	jl .c
	mov rax, rcx
	ret		
.c:	
	; C is biggest
	mov rax, rdx
	ret

.exit:
	; Exit the program
	pop rbp
	mov rax, 0
	ret


; V pomoc
; ZAMUDA, Aleš in BREST, Janez, 2019, Računalniške arhitekture : zbirka vaj in nalog z rešitvami [na spletu]. Drugo učno gradivo. Maribor : Fakulteta za elektrotehniko, računalništvo in informatiko. [Dostopano 24 november 2022]. Pridobljeno s: https://dk.um.si/IzpisGradiva.php?lang=slv&id=75357

; f(n) = 1 + f(n-3) + f(n-2), n > 2, f(0) = 12, f(1)=22, f(2) = 45
 ver us the moonscanf
extern printf

section .data
	inputPrompt: db "Enter n:", 10, 0
	inputFormat: db "%ld", 0
	outputFormat: db "f(%ld) = %ld", 10, 0

section .bss
	N: resq 1
	i: resq 1

global main

section .text
main:
	push rbp

	; Input prompt
	mov rdi, inputPrompt
	xor rax, rax
	call printf

	; Input
	mov rdi, inputFormat
	mov rsi, N
	xor rax, rax
	call scanf

	; Init
	mov qword [i], 3
	mov rsi, [N]

.loop:
	; If
	mov rbx, [i]
	cmp rbx, [N]
	jg .exit

	; Function call
	mov rdi, [i]
	call .recursion

	; Output
	mov rdi, outputFormat
	mov rsi, [i]
	mov rdx, rax
	xor rax, rax
	call printf

	; Goto loop
	inc qword [i]
	jmp .loop

.exit:	
	; Exit
	pop rbp
	xor rax, rax
	ret

; Working value will be held in %rdi, result of function in %rax
.recursion:
	; Case 0	
	cmp rdi, 0
	je ._0
	; Case 1
	cmp rdi, 1
	je ._1
	; Case 2
	cmp rdi, 2	
	je ._2
	; Case n
._n:
	; f(n - 3)
	; Save the current state
	push rdi
	; Function call	
	sub rdi, 3
	call .recursion

	; f(n - 2)
	; Restore previous state
	pop rdi
	; Save current state
	push rax
	push rdi
	; Function call
	sub rdi, 2
	call .recursion

	; Sum
	; Restore previous state
	pop rdi      ; N-value
	pop rsi      ; Function result
	add rax, rsi ; Add f(n - 2) + f(n - 3)
	inc rax

	; Return the value
	ret

; Case 0		
._0:
	mov rax, 11
	ret
; Case 1
._1:
	mov rax, 22
	ret
; Case 2
._2:
	mov rax, 45
	ret

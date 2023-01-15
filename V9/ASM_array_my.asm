; V pomoc
; ZAMUDA, Aleš in BREST, Janez, 2019, Računalniške arhitekture : zbirka vaj in nalog z rešitvami [na spletu]. Drugo učno gradivo. Maribor : Fakulteta za elektrotehniko, računalništvo in informatiko. [Dostopano 24 november 2022]. Pridobljeno s: https://dk.um.si/IzpisGradiva.php?lang=slv&id=75357

extern scanf
extern printf

; Scanf, printf formats
section .data
	inputPrompt: db "Enter text:", 10, 0
	inputFormat: db "%s", 0
	outputFormat: db "Reversed: %s", 10, 0

section .bss
	text: resb 1024 ; Fixed size

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
	mov rsi, text
	xor rax, rax
	call scanf

	mov rdi, text
	call .reverse

	; End 
	; Print
	mov rdi, outputFormat
	mov rsi, text
	xor rax, rax
	call printf	

	; Exit
	pop rbp
	xor rax, rax
	ret
	
	; Reverse function
.reverse:
	mov rsi, rdi
	cld	
	
	; Get the end pointer 
.endPtr:	
	lodsb
	cmp al, 0
	jnz .endPtr
	sub rsi, 2 ; Decrease by two
	
.reverseLoop:
	; If pointers cross
	cmp rdi, rsi
	jge .endReverse		
	
.swap:	
	; Swap the bytes
	mov byte dl, [rdi]
	std
	lodsb
	cld
	stosb
	mov byte [rsi+1], dl
	jmp .reverseLoop
	
.endReverse:
	; End of the function
	ret

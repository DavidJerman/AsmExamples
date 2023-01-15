; Narejeno s pomocjo
; ZAMUDA, Aleš in BREST, Janez, 2019, Računalniške arhitekture : zbirka vaj in nalog z rešitvami [na spletu]. Drugo učno gradivo. Maribor : Fakulteta za elektrotehniko, računalništvo in informatiko. [Dostopano 23 november 2022]. Pridobljeno s: https://dk.um.si/IzpisGradiva.php?lang=slv&id=75357

extern scanf
extern printf

section .data
	in: db "%ld", 0
	out: db "%ld", 10, 0

section .bss
	i resq 1
	N resq 1

global main

section .text
main:
	push rbp
	
	; Input
	mov rdi, in
	mov rsi, N
	mov rax, 0         ; Vhodni parameter, zaradi variablinega podajanja parametrov
			   ; Why is rax not used to pass parameters in asssembly?
	call scanf

	mov rsi, [N]
	; "Divide" by two
	ror rsi, 1 ; N/2

	mov qword [N], rsi ; N
	mov qword [i], 1   ; Counter

.loop:
	mov rax, [i]        ; "IF counter > N"
	cmp rax, [N]
	jg .exit

	xor rdx, rdx        ; Clear rdx
	mov rsi, 47         ; Save divisor to rsi
	div rsi             ; Value counter - razlaga za tipe c dokumentaciji
	
	mov rbx, 0          ; Save 0 to rbx
	cmp rdx, rbx        ; Comapre remainder and 0
		
	; inc qword [i]      ; Increase

	; jg .loop           ; Remainder > 0? Skip -> why wont this work?

	jne .skip            ; Skip if remainder != 0
	
	; Print
	mov rdi, out
	mov rsi, [i]
	mov rax, 0
	call printf

.skip:
	inc qword [i]   ; Increase counter by 1
	jmp .loop       ; Goto loop

.exit:                  ; Exit
	pop rbp
	mov rax, 0
	ret



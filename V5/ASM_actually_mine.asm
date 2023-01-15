; Za pomoc uporabil
; ZAMUDA, Aleš in BREST, Janez, 2019, Računalniške arhitekture : zbirka vaj in nalog z rešitvami [na spletu]. Drugo učno gradivo. Maribor : Fakulteta za elektrotehniko, računalništvo in informatiko. [Dostopano 23 november 2022]. Pridobljeno s: https://dk.um.si/IzpisGradiva.php?lang=slv&id=75357

extern printf      ; Zunanje C-funckije
extern scanf  

global main

section .bss       ; Sekcija z neinicializiranimi podatki
	i: resq 1   ; Rezerviramo 1 qword za stevec
	N: resq 1   ; Rezerviramo se 1 qword za zadnje stevilo

section .data      ; Tule nastavimo parametra za scanf in printf
	in: db "%ld", 0
	out: db "%ld", 10, 0  ; Izpisovali in brali bomo celi stevili velikosti 64-bit long

section .text
main:
	push rbp   ; Shranimo frame

	mov rdi, in  ; Kaksen tip podatka vnasamo
	mov rsi, N ; Kam shranjujemo - PAZI: Spremenljivka se ni inicializirana, brez tega ne gre!
	mov rax, 0   ; Nevem kaj tocno je namen tele nicle
	call scanf   ; Klicemo scanf
 
	mov qword [i], 1 ; Inicializiramo vrednost i
	dec qword [N]

.loop:
	mov rax, [i]     ; Shranimo vrednost i v rax
	cmp rax, [N]     ; Primerjava
	jg .exit         ; Pod pogojem da je i vecje zakljucimo

	
	mov rdi, out     ; Oblika izpisa
	mov rsi, [i]     ; Kaj izpisujemo
	mov rax, 0       ; Tudi tule nisem siguren
	call printf      ; Klicemo printf

	inc qword [i]    ; Povecamo stevec

	jmp .loop        ; Goto zacetek

.exit:
	pop rbp    ; Popnemo nazaj frame
	mov rax, 0
	ret

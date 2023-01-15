; Narejeno s pomocjo
; ZAMUDA, Aleš in BREST, Janez, 2019, Računalniške arhitekture : zbirka vaj in nalog z rešitvami [na spletu]. Drugo učno gradivo. Maribor : Fakulteta za elektrotehniko, računalništvo in informatiko. [Dostopano 23 november 2022]. Pridobljeno s: https://dk.um.si/IzpisGradiva.php?lang=slv&id=75357 

extern scanf                 ; Zunanji C-jevski funkciji scanf in printf
extern printf

; Ce uporabljamo libc, damo main funkcijo, ker libc skrbi za interakcijo s sistemom
global main

section .text            ; Sekcija za kodo
main:
	push rbp         ; Shranimo registre kadar bomo delali z njimi ter jih na koncu obnovimo

	mov rdi, in      ; Shranimo naslov do oblike vnosa - vnasamo celo 64-bitno stevilo, zato %ld
	mov rsi, N       ; Scanf bo na to mesto shranil vrednost
	mov rax, 0       ; Tole mi ni cisto jasno kaj dela, zakaj rabi scanf niclo v rax
	call scanf       ; Pozenemo ukaz scanf

	mov qword [i], 1 ; Nastavimo stevec na 1

.loop:                   ; Glavna zanka
	mov rax, [i]     ; Shranimo vrednost stevca v rax
	cmp rax, [N]     ; To je kot if stavek, nastavi se dolocena zastavica - primerjamo N in stevec v rax

	jg .exit         ; Ce je stevec vecji, zapustimo program
 
	mov rdi, out     ; V kaksni obliki izpisujemo s printf - naslov do tega formata
	mov rsi, [i]     ; V rsi shranimo stevec, ki ga bomo izpisali
	mov rax, 0       ; Zakaj tole nastavimo?
	call printf      ; Poklicemo printf

	inc qword [i]    ; Povecamo stevec za 1

	jmp .loop        ; Se vrnemo nazaj v loop, deluje po principu while ( if goto )

.exit:                   ; Konec programa
	pop rbp          ; Obnoimo vrednosti registrov
	mov rax, 0       ; Izhodna vrednost za ret
	ret              ; Izhod in vracanje vrednosti iz programa


section .data                ; Sekcija s podatki
	in: db "%ld", 0      ; Vpis podatkov - ld pomeni 64-bitno stevilo
	out: db "%ld", 10, 0 ; Izpis podatkov

section .bss                 ; Neinicializirani podatki
	i resq 1             ; Ustvarimo novo spremenljivko i velikosti 64-bit [qword - 4 x 16-bit]
	N resq 1             ; In pa se spremenljivka za koncno stevilo

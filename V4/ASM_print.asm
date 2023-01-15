; Narejeno s pomocjo
; ZAMUDA, Aleš in BREST, Janez, 2019, Računalniške arhitekture : zbirka vaj in nalog z rešitvami [na spletu]. Drugo učno gradivo. Maribor : Fakulteta za elektrotehniko, računalništvo in informatiko. [Dostopano 23 november 2022]. Pridobljeno s: https://dk.um.si/IzpisGradiva.php?lang=slv&id=75357

; Parametre nastavimo preko registrov
; Ukazi so opisani na strani, ki sem jo ze nasel

global _start

section .text
_start:
	mov rax, 1    ; St. sistemskega klicia
	mov rdi, 1    ; Parameter za operacijo - izhod 1 (stdout)
	mov rsi, msg  ; Naslov sporocila
	mov rdx, len  ; St. bajtov
	syscall       ; Sistemski klic (izpis na 1)
	mov rax, 60   ; St. sistemskega klica
	xor rdi, rdi  ; Koda izhoda - 0 (uspeh)
	syscall       ; Sistemski klic (izhod)

section .data
	msg: db "David Jerman E1133725", 10 ; Sporocilo
	len: equ $-msg                      ; Dolzina sporocila - pseudo instrukcija

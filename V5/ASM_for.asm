extern scanf                 ; Zunannja C-jevska funkcija
extern printf

; Ce uporabljamo libc, damo main funkcijo, ker libc skrbi za interakcijo s sistemom
global main

section .text
main:
	push rbp         ; Save the register values

	mov rdi, in      ; Save the address of in - we are saving a single number
	mov rsi, N       ; Where scanf saves the number
	mov rax, 0       ; Operation that we are calling?
	call scanf       ; Pozenemo vnos

	mov dword [i], 1

.loop:
	mov rax, [i]
	cmp rax, [N]

jg .exit
	mov rdi, out
	mov rsi, [i]
	mov rax, 0       ; Zakaj tole nastavimo?
	call printf

	inc dword [i]

	jmp .loop

.exit:
	pop rbp
	mov rax, 0
	ret


section .data
	in: db "%ld", 0      ; Vpis podatkov - ld pomeni 64-bitno stevilo
	out: db "%ld", 10, 0 ; Izpis podatkov

section .bss                 ; Neinicializirani podatki
	i resq 1
	N resq 1

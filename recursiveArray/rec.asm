; Naj ta program gre cez array, in za vrednosti v njem izracuna rekurzivno f(n) = f(n - 1) * 2 + f(n - 2) - f(n - 3)
; f(0) = 3
; f(1) = 5
; f(2) = 7
; It also checks if the numbers are valid
extern scanf 
extern printf

global main

section .data
	inputPrompt: db "Please enter the array:", 10, 0
	inputFormat: db "%s", 0
	outputFormat: db "f(%ld) = %ld", 10, 0
	errorMsg: db "Error: invalid number!", 10, 0

section .bss
	data: resb 128
	N: resq 1

section .text
main:
	; Setup
	push rbp
	
	; Input prompt
	mov rdi, inputPrompt
	xor rsi, rsi ; No arg
	xor rax, rax	
	call printf

	; Input
	mov rdi, inputFormat
	mov rsi, data
	xor rax, rax
	call scanf

	; Loop
	mov rsi, data
	cld
.loop:
	lodsb
	cmp al, 0
	jz .endMain
	cmp al, 48
	jl .errorMain
	cmp al, 57
	jg .errorMain
	sub rax, 48
	mov qword [N], rax
	; Function call
	; In:
	; 	rdi - n
	; Out:
	; 	rax - f(n)
	mov rdi, rax
	push rsi
	call .Fn
	pop rsi

	mov rbx, rsi
	
	; Print
	mov rdi, outputFormat
	mov rsi, [N]
	mov rdx, rax
	xor rax, rax
	call printf

	mov rsi, rbx

	jmp .loop

.errorMain:
	; Print error
	mov rdi, errorMsg
	xor rsi, rsi
	xor rax, rax	
	call printf

	; Exit
	pop rbp
	mov rax, 60
	mov rdi, 1
	syscall
	
.endMain:
	pop rbp

	; Exit
	mov rax, 60
	mov rdi, 0
	syscall

; Naj ta program gre cez array, in za vrednosti v njem izracuna rekurzivno f(n) = f(n - 1) * 2 + f(n - 2) - f(n - 3)
; f(0) = 3
; f(1) = 5
; f(2) = 7
; It also checks if the numbers are valid
; -> rdi - n
; <- rax - f(n)
.Fn:
	cmp rdi, 0
	jz .F0
	cmp rdi, 1
	jz .F1
	cmp rdi, 2
	jz .F2	

	push rdi
	dec rdi    ; n - 1
	call .Fn
	
	pop rdi
	push rax
	push rdi
	sub rdi, 2 ; n - 2
	call .Fn

	pop rdi
	push rax
	push rdi
	sub rdi, 3 ; n - 3
	call .Fn

	pop rdi      ; n
	xor rbx, rbx ; Sum = 0
	sub rbx, rax ; + f(n - 3)
	pop rax
	add rbx, rax
	pop rax
	mov rcx, 2
	mul rcx
	add rbx, rax
	
	mov rax, rbx
	ret

.F0:
	mov rax, 3
	ret
.F1:
	mov rax, 5
	ret
.F2:
	mov rax, 7
	ret

	

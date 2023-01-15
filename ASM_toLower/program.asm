extern printf
extern scanf

section .data
	inputPrompt:  db "Enter the string: ", 10, 0
	inputFormat:  db "%s", 0
	outputFormat: db "%s -> %s", 10, 0

section .bss
	org: resb 1024
	res: resb 1024

section .text
global main
main:
	push rbp

	; Prompt
	mov rdi, inputPrompt
	xor rsi, rsi
	xor rax, rax
	call printf

	; Input
	mov rax, 0
	mov rdi, 0     ; Syscall for read
	mov rsi, org   ; Save location
	mov rdx, 128   ; Buffer size 
	syscall	

	; Function call
	; rdi - message address
	; rax - new message address
	mov rdi, org
	call .to_upper

	; Print
	mov rdi, outputFormat
	mov rsi, org
	mov r8, rax
	mov rcx, rax
	mov rdx, rax
	xor rax, rax
	call printf

	; Exit
	pop rbp
	ret

.to_upper:
	mov rsi, rdi
	mov rdi, res

	cld

.loop:
	lodsb
	cmp al, 0
	jz .end
	cmp al, 32
	je .space
	cmp al, 65
	jl .next
	cmp al, 90
	jg .next
	add rax, 32
.next:
	stosb
	jmp .loop 
.space:
	add rax, 63
	jmp .next
.end:	
	mov rax, res
	ret

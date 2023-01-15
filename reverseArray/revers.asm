extern printf
extern scanf

section .data
	inputPrompt: db "Please enter the array to reverse: ", 0
	inputFormat: db "%s", 0
	outputFormat: db "Reversed array: %s", 10, 0

section .bss
	data: resb 1024

section .text
global main
main:
	push rbp
	
	; Input prompt
	mov rdi, inputPrompt
	xor rsi, rsi
	xor rax, rax
	call printf

	; Input
	mov rdi, inputFormat
	mov rsi, data
	xor rax, rax
	call scanf

	; Function call
	; rdi - Address to data
	; rax - Address to updated data
	mov rdi, data
	call .reverse
	
	; Print
	mov rdi, outputFormat
	mov rsi, rax
	xor rax, rax
	call printf

	; Exit
	pop rbp
	mov rax, 60
	mov rdi, 0
	syscall

.reverse:
	mov rbx, rdi ; Temp store start
	mov rsi, rdi
.len:
	; While
	lodsb
	cmp al, 0
	jz .loopInit
	jmp .len
.loopInit:
	sub rsi, 2
	mov rdi, rbx
	mov rcx, rbx
	cld
.loop:
	mov al, byte [rsi]
	mov bl, byte [rdi]
	stosb
	mov byte [rsi], bl
	dec rsi
	cmp rsi, rdi
	jle .end
	jmp .loop
.end:
	mov rax, rcx
	ret

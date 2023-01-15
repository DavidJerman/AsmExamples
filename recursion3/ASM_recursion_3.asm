extern scanf
extern printf

section .data
	outputFormat: db "f(%ld) = %ld", 10, 0

section .bss
	i: resq 1
	N: resq 1

section .text

global main

main:
	; Setup 
	push rbp
	mov qword [i], 1
	mov qword [N], 20

	; Loop
.loop:
	mov rax, [i]
	cmp rax, [N]
	jg .exit
	
	; Call function
	; rdx - n
	; rax - result
	mov rdx, [i]
	call .rec
	
	; Print
	mov rdi, outputFormat
	mov rsi, [i]
	mov rdx, rax
	xor rax, rax
	call printf

	inc qword [i]

	; Jump back
	jmp .loop

.rec:
	; n in %RDX
	; f(n) = 2*f(n - 1) - f(n - 2) + 3*f(n - 3)
	cmp rdx, 0
	jz .rec0
	
	cmp rdx, 1
	jz .rec1

	cmp rdx, 2
	jz .rec2

	; f(n - 1)
	push rdx
	sub rdx, 1
	call .rec

	; f(n - 2)
	pop rdx
	push rax
	push rdx
	sub rdx, 2
	call .rec

	; f(n - 3)
	pop rdx
	push rax
	push rdx
	sub rdx, 3
	call .rec

	; Sum
	pop rdx
	xor rcx, rcx
	mov rbx, 3
	mul rbx
	add rcx, rax

	pop rax
	neg rax
	add rcx, rax

	pop rax
	shl rax, 1
	add rcx, rax
	mov rax, rcx
	ret

.rec0:
	mov rax, 2
	ret
.rec1:
	mov rax, 5
	ret
.rec2:
	mov rax, 11
	ret


.exit:
	pop rbp
	xor rax, rax
	ret

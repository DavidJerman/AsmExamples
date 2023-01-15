; f(x) = f(x - 1) + f(x - 2) + f(x - 3)
; f(0) = 2
; f(1) = 5
; f(2) = 7
extern printf

section .data
	outputFormat: db "f(%ld) = %ld", 10, 0

section .bss
	i: resq 1
	N: resq 1

section .text

global main
; Results are pushed on stack
; State is saved on stack
main:
	; Setup
	push rbp

	mov qword [N], 10
	mov qword [i], 0
.loop:
	; While
	mov rax, [i]
	cmp rax, [N]

	jg .exit
	
	mov rcx, [i]   ; n
	xor rdx, rdx   ; retVal
 	call .f

	; Print
	mov rdi, outputFormat
	mov rsi, [i]
	mov rdx, rdx
	xor rax, rax
	call printf
		
	inc qword [i]

	jmp .loop 
.f:
	cmp rcx, 0
	jz ._f0

	cmp rcx, 1
	jz ._f1

	cmp rcx, 2
	jz ._f2

	; f (n - 1)
	push rcx
	dec rcx
	call .f
	
	pop rcx
	; f (n - 2)
	push rdx
	push rcx
	sub rcx, 2
	call .f

	pop rcx
	; f (n - 3)
	push rdx
	push rcx
	sub rcx, 3
	call .f

	; Sum
	pop rcx
	xor rbx, rbx
	add rbx, rdx
	pop rdx
	add rbx, rdx
	pop rdx
	add rbx, rdx
	mov rdx, rbx
	ret
._f0:
	mov rdx, 2
	ret	
._f1:
	mov rdx, 5
	ret
._f2:
	mov rdx, 7
	ret
.exit:
	pop rbp
	xor rax, rax
	ret

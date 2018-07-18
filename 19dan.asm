global main,_start

section .bss
	buffer: resb 128
	input: resb 128

section .data
fmt:	db "%d",0
ft:	db "%d * %d = %d",10,0
in:	db "Input Number(1~19) : "
cr:	db 10, 0

section .text
	extern printf
	extern scanf
	extern exit
gugu:
	push rbp
	mov rbp, rsp
	xor rax, rax
	xor rbx, rbx

	push 0 ;	hap [rsp+16]
	push 0 ; 	second [rsp+8]
	push 0 ; 	first [rsp]
floop:
	mov dword [rsp+8] ,0
	inc dword [rsp]
	cmp dword [rsp],20
	JAE _end
sloop:
	inc dword [rsp+8]
	cmp dword [rsp+8],20
	JAE floop
	mov rax, [rsp]
	mov rdx, [rsp+8]
	mul rdx
	mov [rsp+16], rax
	
	mov rcx, [rsp+16]
	mov rdx, [rsp+8]
	mov rsi, [rsp]
	mov rdi, ft
	mov rax, 0
	call printf
	
	jmp sloop
ngugu:
	push rbp
	mov rbp, rsp
	xor rax, rax
	xor rbx, rbx
	push 0	;hap [rsp+8] 
	push 0 	;second [rsp]

	mov rbx, [rdi]
loop:		
	inc dword [rsp]
	cmp dword [rsp], 20
	jae _end
	mov rax, rbx
	mov rdx, [rsp]
	mul rdx
	mov [rsp+8], rax
	
	mov rcx, [rsp+8]
	mov rdx, [rsp]
	mov rsi, rbx
	mov rdi, ft
	mov rax, 0
	call printf
	jmp loop
_error:
	push rbp
	mov rbp, rsp
	xor rax, rax
	xor rbx, rbx

	mov rax, 1
	mov rdi, 1
	mov rsi, message
	mov rdx, 16
	syscall
_end:
	mov eax, 0
	leave
	ret

main:
_start:
	push rbp
	mov rsi, buffer
	mov rdi, fmt
	mov rax, 0
	call scanf
	
	mov rbx, 0
	inc rbx	
	cmp [buffer], rbx
	je _ifgugu
	inc rbx 
	cmp [buffer], rbx
	je _ifngugu
	call _error
	jmp _exit
	
_ifgugu:
	call gugu
	jmp _exit		

_ifngugu:
Nloop:
	mov rdi , in
	mov rax, 0
	call printf
	mov rsi, input
	mov rdi, fmt
	mov rax, 0
	call scanf
	
	xor rbx, rbx
	cmp [input], rbx
	JBE Nloop
	mov rbx, 20
	cmp [input], rbx
	jAE Nloop
	mov rdi, input
	call ngugu
	jmp _exit		
_exit:
	mov rdi, cr
	mov rax, 0
	call printf	
	call exit
	pop rbp
	ret

section .data
message: db "Input number 1~2", 16

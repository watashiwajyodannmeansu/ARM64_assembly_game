.include "library/lv_1/heap.asm"
.include "library/lv_1/stack.asm"
.include "library/lv_1/svc.asm"
.include "library/lv_1/stdfd.asm"
.section .rodata
.balign 16
stdout:
	.ascii "STDOUT;"
	stdout_len=.-stdout
stderr:
	.ascii "STDERR;"
	stderr_len=.-stderr
message:
	.ascii "Hello, World!"
	message_len=.-message
.section .text
.global _start
_start:
	bl _start_stack
	bl _start_heap
	b main
.global main
main:
	//write 1

	//setting args
	bl _set_heap
	mov x0, _STDOUT
	str x0, [sp], #0x10
	ldr x0, =stdout
	str x0, [sp], #0x10
	mov x0, stdout_len
	str x0, [sp]
	//calling write
	bl _set_stack
	adr x0, write
	bl call

	//write 2

	//setting args
	bl _set_heap
	mov x0, _STDOUT
	str x0, [sp], #0x10
	ldr x0,=message
	str x0, [sp], #0x10
	mov x0, message_len
	str x0, [sp]
	//calling write
	bl _set_stack
	adr x0, write
	bl call

	//write 3

	//setting args
	bl _set_heap
	mov x0, _STDERR
	str x0, [sp], #0x10
	ldr x0,	=stderr
	str x0, [sp], #0x10
	mov x0, stderr_len
	str x0, [sp]
	//calling write
	bl _set_stack
	adr x0, write
	bl call

	//write 4

	//setting args
	bl _set_heap
	mov x0, _STDERR
	str x0, [sp], #0x10
	ldr x0,=message
	str x0, [sp], #0x10
	mov x0, message_len
	str x0, [sp]
	//calling write
	bl _set_stack
	adr x0, write
	bl call

	//exiting
	mov x0, #0
	b exit

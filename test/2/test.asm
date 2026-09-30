.include "library/lv_1/heap.asm"
.include "library/lv_1/stack.asm"
.include "library/lv_1/svc.asm"
.include "library/lv_1/stdfd.asm"
.section .rodata
.balign 16
reading:
	.ascii "READING...\n"
	reading_len=.-reading
.section .data
buf:
	.space 1024
	buf_len=.-buf
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
	ldr x0, =reading
	str x0, [sp], #0x10
	mov x0, reading_len
	str x0, [sp]
	//calling write
	bl _set_stack
	adr x0, write
	bl call

	//read 1

	//setting args
	bl _set_heap
	mov x0, _STDIN
	str x0, [sp], #0x10
	ldr x0, =buf
	str x0, [sp], #0x10
	mov x0, buf_len
	str x0, [sp]
	//calling read
	bl _set_stack
	adr x0, read
	bl call

	//write 2

	//setting args
	bl _set_heap
	mov x0, _STDOUT
	str x0, [sp], #0x10
	ldr x0, =buf
	str x0, [sp], #0x10
	mov x0, buf_len
	str x0, [sp]
	//calling write
	bl _set_stack
	adr x0, write
	bl call

	//exiting
	mov x0, #0
	b exit

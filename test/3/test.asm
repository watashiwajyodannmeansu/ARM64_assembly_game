.include "library/lv_1/heap.asm"
.include "library/lv_1/stack.asm"
.include "library/lv_1/svc.asm"
.include "library/lv_1/stdfd.asm"
.include "library/lv_2/pages.asm"
.section .rodata
.balign 16
reading:
	.ascii "READING...\n"
	reading_len=.-reading
opening:
	.ascii "OPENING... \n"
	opening_len=.-opening
writing:
	.ascii "WRITING... \n"
	writing_len=.-writing
.section .data
buf:
	.space 1024
	buf_len=.-buf
.section .text
.global _start
_start:
	bl _start_pages
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
	ldr x0, =opening
	str x0, [sp], #0x10
	mov x0, opening_len
	str x0, [sp]
	//calling write
	bl _set_stack
	adr x0, write
	bl call

	//open 1
	
	//setting args
	bl _set_pages
	ldr x0, [sp, #0x10]
	bl _set_heap
	str x0, [sp, #0x10]
	mov x0, #-100
	str x0, [sp, #-0x10]
	mov x0, #0
	str x0, [sp, #0x20]
	//calling open
	bl _set_stack
	adr x0, open
	bl call
	//storing fd
	bl _set_heap
	ldr x0, [sp]
	bl _set_pages
	str x0, [sp, #0x20]

	//write 2
	
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
	bl _set_pages
	ldr x0, [sp, #0x20]
	bl _set_heap
	str x0, [sp], #0x10
	ldr x0, =buf
	str x0, [sp], #0x10
	mov x0, buf_len
	str x0, [sp]
	//calling read
	bl _set_stack
	adr x0, read
	bl call
	//storing number of bytes
	bl _set_heap
	ldr x0, [sp]
	bl _set_pages
	str x0, [sp, #0x40]

	//write 3

	//setting args
	bl _set_heap
	mov x0, _STDOUT
	str x0, [sp], #0x10
	ldr x0, =writing
	str x0, [sp], #0x10
	mov x0, writing_len
	str x0, [sp]
	//calling write
	bl _set_stack
	adr x0, write
	bl call
	
	//write 4

	//setting args
	bl _set_heap
	mov x0, _STDOUT
	str x0, [sp], #0x10
	ldr x0, =buf
	str x0, [sp], #0x10
	bl _set_pages
	ldr x0, [sp, #0x40]
	bl _set_heap
	str x0, [sp, #0x20]
	//calling write
	bl _set_stack
	adr x0, write
	bl call

	//close 1

	bl _set_pages
	ldr x0, [sp, #0x20]
	bl _set_heap
	str x0, [sp]
	//calling close
	bl _set_stack
	adr x0, close
	bl call

	//exiting
	mov x0, #0
	b exit

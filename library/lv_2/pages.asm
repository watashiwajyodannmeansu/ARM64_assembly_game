.ifndef return
	.include library/lv_1/stack.asm
.endif
.ifndef _set_heap
	.include library/lv_1/heap.asm
.endif
.section .data
pages:
	.space 1024
	pages_size=.-pages
.space 16
.section .text
_start_page:
	ldr x0, pages
	mov x1, sp
	str x1, [sp]
	ldr x1, [x0], #0x10
	add x1, sp, #8
	str x1, [sp]
	ldr x0, x1
	ret
_set_page:
	ldr sp, =pages
	ret

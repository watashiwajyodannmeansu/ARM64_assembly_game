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
_start_pages:
	ldr x0, =pages
	ldr x1, [sp]
	str x1, [x0], #0x10
	add x1, sp, #8
	ldr x1, [x1]
	str x1, [x0]
	ret
_set_pages:
	ldr x29, =pages
	mov sp, x29
	ret

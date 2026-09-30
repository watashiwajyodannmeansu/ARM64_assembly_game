.ifndef "_set_stack"
.include library/lv_1/stack.asm
.endif
.ifndef "_set_heap"
.include library/lv_1/heap.asm
.endif
.ifndef "read"
.include library/lv_1/svc.asm
.endif
cmp_void:
	bl _set_heap
	ldr x0, [sp], #0x20
	ldr x1, [sp], #-0x20
	sub x0, x0, x1
	cmp xzr, x0
	b.ne cmp_void_exit
	mov x0, #0
	ldr x2, [sp, #0x10]
	ldr x3, [sp, #0x20]
	cmp_void_loop:
		ldr x4, [x2], #0x10
		ldr x5, [x3], #0x10
		sub x1, x1, #1
		cmp x4, x5
		b.eq cmp_void_loop_true
		add x0, x0, #1
		cmp_void_loop_true:
		cmp x1, xzr
		b.gt cmp_void_loop
	cmp_void_exit:
	bl _set_heap
	str x0, [sp]
	bl _set_stack
	b return
void_splice:
	bl _set_heap
	ldr x0, [sp], #0x20
	ldr x1, [sp], #0x20
	add x1, x0, x1
	ldr x0, [sp]
	cmp x0, x1
	b.ge void_splice_valid
	mov x0, #0
	b void_splice_exit
	void_splice_valid:
	ldr x2, [sp, #0x20]
	bl _set_heap
	//splice void
	void_splice_exit:
	bl _set_heap
	str x0, [sp]
	bl _set_stack
	b return

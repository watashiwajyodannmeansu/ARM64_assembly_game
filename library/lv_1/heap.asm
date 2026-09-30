.section .data
.balign 16
heap:
	.space 4096
heap_end:
	.space 16
.section .text
.global _start_heap
_start_heap:
	//to be used with the BL instruction in _start, not b stack.asm.call
	adr x16, heap
	mov x17, #0
	adr x18, heap_end
	_start_heap_loop:
		str x17, [x16], #8
		cmp x16, x18
		b.le _start_heap_loop
	ret
.global _set_heap
_set_heap:
	//sets sp to heap, to be used with BL
	adr x29, heap
	mov sp, x29
	ret

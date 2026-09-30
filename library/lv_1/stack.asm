.ifndef _svc_num_sigsend
.include "library/svc_nums.asm"
.endif
.section .rodata
stack_overflow_msg:
	.ascii "Stack overflowed, sigfault!\n\0"
	stack_overflow_msg_len=.-stack_overflow_msg
stack_underflow_msg:
	.ascii "Stack underflowed, sigfault!\n\0"
	stack_underflow_msg_len=.-stack_underflow_msg
.section .data
.balign 16
stack:
	.space 4096
stack_end:
	.space 16
.section .text
.global _set_stack
_set_stack:
	//sets sp to stack_end, to be used with bl
	adr x29, stack_end
	mov sp, x29
	ret
.global _start_stack
_start_stack:
	//wipes stack, to be used in _start
	adr x16, stack_end
	mov sp, x16
	mov x16, SP
	sub x16, x16, #0x10
	str x16, [SP]
	ret
.global call
call:
	//jump to the address at x0, and push x30 to stack
	ldr x1, [SP]
	sub x1, x1, #0x10
	str x1, [sp]
	str x30, [x1]
	ldr x2, =stack
	cmp x1, x2
	b.lt _stack_overflow
	br x0
.global return
return:
	//jump to the address at [[sp]], write 0 to [[sp]], and decrease [sp] by 16
	ldr x1, [SP]
	ldr x30, [x1]
	mov x0, #0
	str x0, [x1]
	add x1, x1, #0x10
	mov x0, sp
	cmp x1, x0
	b.ge _stack_underflow
	str x1, [sp]
	ret
.global _stack_underflow
_stack_underflow:
	//print stack underflow message
	mov x0, #2
	ldr x1, =stack_underflow_msg
	mov x2, stack_underflow_msg_len
	mov x8, #64
	svc #0
	//send sigsegv to self
	mov x0, #0
	mov x1, #11
	b _stack_sigsend
.global _stack_overflow
_stack_overflow:
	//print stack overflow message
	mov x0, #2
	ldr x1, =stack_overflow_msg
	mov x2, stack_overflow_msg_len
	mov x8, #64
	svc #0
	//send sigsegv to self
	mov x0, #0
	mov x1, #11
	b _stack_sigsend
.global _stack_sigsend
_stack_sigsend:
	//send signal for stack related reasons
	mov x8, _svc_num_sigsend
	svc #0
	ret

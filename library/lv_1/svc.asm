.ifndef heap
.include "library/lv_1/heap.asm"
.endif
.ifndef stack
.include "library/lv_1/stack.asm"
.endif
.ifndef _svc_num_write
.include "library/svc_nums.asm"
.endif
.section .text
.global write
write:
	//x0=file descriptor, x1=message, x2=length
	//get args
	bl _set_heap
	ldr x0, [sp], #0x10
	ldr x1, [sp], #0x10
	ldr x2, [sp]
	//print
	bl _set_heap
	mov x8, _svc_num_write 
	svc #0
	//str output
	str x0, [sp], #0x10
	str x1, [sp]
	//return
	bl _set_stack
	b return
.global read
read:
	//x0=file descriptor, x1=ptr, x2=length
	//get args
	bl _set_heap
	ldr x0, [sp], #0x10
	ldr x1, [sp], #0x10
	ldr x2, [sp]
	//read
	bl _set_heap
	mov x8, _svc_num_read
	svc #0
	//str output
	str x0, [sp], #0x10
	str x1, [sp]
	//return
	bl _set_stack
	b return
.global open
open:
	//x0=dirfd,x1=path,x2=flags,x3=mode
	//get args
	bl _set_heap
	ldr x0, [sp], #0x10
	ldr x1, [sp], #0x10
	ldr x2, [sp], #0x10
	ldr x3, [sp]
	//open file
	bl _set_heap
	mov x8, _svc_num_open
	svc #0
	//str output
	str x0, [sp]
	//return
	bl _set_stack
	b return
.global open
close:
	//x0=fd
	//get args
	ldr x0, [sp], #0x10
	//close fd
	bl _set_heap
	mov x8, _svc_num_close
	svc #0
	//str output
	str x0, [sp]
	//return
	bl _set_stack
	b return
.global sigsend
sigsend:
	//No return value. x0=pid, x1=sig
	//get args
	bl _set_heap
	ldr x0, [sp], #0x10
	ldr x1, [sp]
	//send
	mov x8, _svc_num_sigsend
	svc #0
	//return
	bl _set_stack
	b return
.global exit
exit:
	mov x8, _svc_num_exit
	svc #0

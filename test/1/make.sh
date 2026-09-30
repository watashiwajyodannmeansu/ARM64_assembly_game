rm test/1/asm.err 2> /dev/null
rm test/1/ld.err 2> /dev/null
if as test/1/test.asm -o test/1/test.unlinked 2> test/1/asm.err; then
	objdump -D test/1/test.unlinked &> test.unlinked.dis
	if ld test/1/test.unlinked -o test/1/test 2> test/1/ld.err; then
		objdump -D test/1/test &> test/1/test.dis
	else
		echo "TEST 1: linker failed"
	fi
else
	echo "TEST 1: assembler failed"
fi

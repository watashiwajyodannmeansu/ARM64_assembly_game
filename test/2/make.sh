rm test/2/asm.err 2> /dev/null
rm test/2/ld.err 2> /dev/null
if as test/2/test.asm -o test/2/test.unlinked 2> test/2/asm.err; then
	objdump -D test/2/test.unlinked &> test/2/test.unlinked.dis
	if ld test/2/test.unlinked -o test/2/test 2> test/2/ld.err; then
		objdump -D test/2/test &> test/2/test.dis
	else
		echo "TEST 2: linker failed"
	fi
else
	echo "TEST 2: assembler failed"
fi

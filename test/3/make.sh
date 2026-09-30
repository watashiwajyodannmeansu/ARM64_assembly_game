rm test/3/asm.err 2> /dev/null
rm test/3/ld.err 2> /dev/null
if as test/3/test.asm -o test/3/test.unlinked 2> test/3/asm.err; then
	objdump -D test/3/test.unlinked &> test.unlinked.dis
	if ld test/3/test.unlinked -o test/3/test 2> test/3/ld.err; then
		objdump -D test/3/test &> test/3/test.dis
	else
		echo "TEST 3: linker failed"
	fi
else
	echo "TEST 3: assembler failed"
fi

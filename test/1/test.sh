cat README
./test/1/make.sh
if [ $? -ne 0 ]; then
	echo "TEST 1 FAILED!"
	exit $?
fi
./test/1/test&>test/1/test.out
if [ "STDOUT;Hello, World!STDERR;Hello, World!" == "$(cat test/1/test.out)" ]; then
	echo "TEST 1 PASSED!"
	exit 0
else
	echo "TEST 1 FAILED!"
	exit 1
fi
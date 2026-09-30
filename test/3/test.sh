cat test/3/README
./test/3/make.sh;
if [ $? -ne 0 ]; then
	echo "TEST 3 FAILED!"
	exit $?
fi
./test/3/test "test/3/test.txt"&>test/3/test.out
if [ "$(cat test/3/test.expected)" == "$(cat test/3/test.out)" ]; then
	echo "TEST 3 PASSED!"
	exit 0
else
	echo "TEST 3 FAILED!"
	exit 1
fi

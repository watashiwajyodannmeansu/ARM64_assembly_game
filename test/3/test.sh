cat test/2/README
./test/2/make.sh;
if [ $? -ne 0 ]; then
	echo "TEST 2 FAILED!"
	exit $?
fi
cat test/2/test.txt|./test/2/test&>test/2/test.out
if [ "$(cat test/2/test.expected)" == "$(cat test/2/test.out)" ]; then
	echo "TEST 2 PASSED!"
	exit 0
else
	echo "TEST 2 FAILED!"
	exit 1
fi

echo "STARTING TESTING"
for i in 1 2 3
do
	echo "TEST $i"
	./test/$i/test.sh
	if [ $? -ne 0 ]; then
		echo "TEST FAILED, ENDING TEST SERIES"
	fi
done

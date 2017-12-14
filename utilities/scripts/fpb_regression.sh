clear
TODAY=$(date)
HOST=$(hostname)
echo "Date: $TODAY         Host:$HOST"
COUNTER=1

# This script is placed in code/systemtest/script folder. Change the working directory to code 
   
if [ -f fail.txt ]
then
mv fail.txt fail_bkp.txt
fi

echo "The test groups will be executed for $COUNTER number of times"
testid=1  
while read inputline;
do
    for ((  i = 0 ;  i < $COUNTER;  i++  ))
    do
        grpname=$inputline
        echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
        echo "TEST GROUP NAME : $grpname"
        echo " TEST GROUP ID : $testid ITERATION : `expr $i + 1`"
        echo "Current Time is : `date`"	
        echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
        echo "Group Name : $grpname" >> fail.txt
        echo "---------------------------------------------" >> fail.txt
        START=$(date +%s)
        ../$inputline.expect 10 11 12 13 
        END=$(date +%s)
        DIFF=$(( $END - $START ))
        grep 'error(s) occured' $grpname.expect.log >> fail.txt
        echo It took $DIFF seconds.
        sleep 10
    done
    testid=`expr $testid + 1` 
done < fpb_regression.tool
FAIL=`grep -c 'error(s) occured' fail.txt`
SUCCESS=`expr $testid - $FAIL - 1`

echo "======MODULE TESTING REPORT FOR FPB==========================="
TODAY=$(date)
HOST=$(hostname)
echo "Date: $TODAY         Host:$HOST"
echo "Each test group has been executed for $COUNTER number of times"
echo "The total test cases success are $SUCCESS"
echo "The total test cases failed  are $FAIL"
echo "=============================================================="

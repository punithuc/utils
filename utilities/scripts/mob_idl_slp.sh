clear
	TODAY=$(date)
	HOST=$(hostname)
	echo "Date: $TODAY         Host:$HOST"
   	COUNTER=1
	
# This script is placed in code/systemtest/script folder. Change the working directory to code 
cd ../../
make -f Makefile_st clean
make -f Makefile_st depend
make -f Makefile_st >a
       
if [ -d build ]
then
   cd build/posix/st_fw_app/bin
   if [ -f Wimax_posix_tfw_app ]
       then
       echo "Build Successful"
       cd -
       cd systemtest/script
       cp test_groups_nbradv_scan_ho.tool ../../build/posix/st_fw_app/bin/test_groups_nbradv_scan_ho.tool
       cd -
       cd build/posix/st_fw_app/bin/
       
        if [ -f test.txt ]
	    then
	    rm -f test.txt
		fi
		if [ -f fail.txt ]
	    then
	    rm -f fail.txt
		fi
		if [ -f success.txt ]
	    then
	    rm -f success.txt
		fi

		echo "The test groups will be executed for $COUNTER number of times"
        	testid=1  
		while read inputline;
		do
			echo "$inputline" > test.txt
			for ((  i = 0 ;  i < $COUNTER;  i++  ))
			do
 	       	grpname=`cut -c11-150 test.txt`
    	    echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
	        echo "TEST GROUP NAME : $grpname"
	        echo " TEST GROUP ID : $testid ITERATION : `expr $i + 1`"
			echo "Current Time is : `date`"	
    	    echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
	        echo "Group Name : $grpname" >> fail.txt
    	    echo "Group Name : $grpname" >> success.txt
        	echo "---------------------------------------------" >> fail.txt
        	echo "---------------------------------------------" >> success.txt
			START=$(date +%s)
			./Wimax_posix_tfw_app  < test.txt || echo "FAILED!!! segmentation fault">>test_report_"$grpname".trp 
			END=$(date +%s)
			DIFF=$(( $END - $START ))
			echo It took $DIFF seconds.
			sleep 10
	    	if [ -f test_report_"$grpname".trp ]
        	then
            	grep 'FAILED!!!' test_report_"$grpname".trp >> fail.txt
            	grep 'SUCCEEDED!' test_report_"$grpname".trp >> success.txt
				#take backup of the log files if any failure occurs. otherwise no need to backup log files
				FAILCTR=`grep -c 'FAILED!!!' test_report_"$grpname".trp`
				if [ 0 != $FAILCTR ]
				then
					cp -f report.fil report_"$grpname"_"$i".fil
					cat test_report_"$grpname".trp >> tfw_log.tlf && cp -f tfw_log.tlf test_report_"$grpname"_"$i".trp && rm -f test_report_"$grpname".trp
				else
					rm -f test_report_"$grpname".trp
				fi
        	else
       	 		echo 'FAILED!!!'>>fail.txt
   			fi
			done
			rm -f test.txt
        	testid=`expr $testid + 1` 
		done < test_groups_nbradv_scan_ho.tool
	SUCCESS=`grep -c SUCCEEDED! success.txt`
	FAIL=`grep -c FAILED!!! fail.txt`

	cp -f fail.txt fail_HO.txt
	cp -f success.txt success_HO.txt

    cd -
	echo "======SYSTEM TESTING REPORT FOR NBRHOOD, SCAN and HANDOVER===="
	TODAY=$(date)
	HOST=$(hostname)
	echo "Date: $TODAY         Host:$HOST"
	echo "Each test group has been executed for $COUNTER number of times"
	echo "The total test cases success are $SUCCESS"
	echo "The total test cases failed  are $FAIL"
	echo "=============================================================="

    else
       echo "Build Failed"
       echo "Exiting the Shell Script"
    fi
fi

if [ -d build ]
then
   cd build/posix/st_fw_app/bin
   if [ -f Wimax_posix_tfw_app ]
       then
       echo "Build Successful"
       cd -
       cd systemtest/script
       cp test_groups_idle_ON.tool ../../build/posix/st_fw_app/bin/test_groups_idle_ON.tool
       cd ../../
	   #This script will overwrite config.dat in subsequent sections. Taking a backup copy of the config.dat
 	   cp root/dat/config.dat root/dat/config_actual.dat
       cd build/posix/st_fw_app/bin/

        if [ -f test.txt ]
	    then
	    rm -f test.txt
	fi
	if [ -f fail.txt ]
	    then
	    rm -f fail.txt
	fi
	if [ -f success.txt ]
	    then
	    rm -f success.txt
	fi
        
	echo "The test groups will be executed for $COUNTER number of times"
	testid=1
	while read inputline;
	do
	echo "$inputline" > test.txt
	for ((  i = 0 ;  i < $COUNTER;  i++  ))
	do
	grpname=`cut -c11-150 test.txt`
    echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    echo "Test cases for IDLE MODE SUPPORT ON"
	echo "TEST GROUP NAME : $grpname"
	echo " TEST GROUP ID : $testid ITERATION : `expr $i + 1`"
	echo "Current Time is : `date`"	
    echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
	echo "Group Name : $grpname" >> fail.txt
    echo "Group Name : $grpname" >> success.txt
    echo "---------------------------------------------" >> fail.txt
    echo "---------------------------------------------" >> success.txt
	START=$(date +%s)
	./Wimax_posix_tfw_app  < test.txt || echo "FAILED!!! segmentation fault">>test_report_"$grpname".trp 
	END=$(date +%s)
	DIFF=$(( $END - $START ))
	echo It took $DIFF seconds.
	sleep 10
	if [ -f test_report_"$grpname".trp ]
	    then
			grep 'FAILED!!!' test_report_"$grpname".trp >> fail.txt 
			grep 'SUCCEEDED!' test_report_"$grpname".trp >> success.txt
		#take backup of the log files if any failure occurs. otherwise no need to backup log files
				FAILCTR=`grep -c 'FAILED!!!' test_report_"$grpname".trp`
				if [ 0 != $FAILCTR ]
				then
					cp -f report.fil report_"$grpname"_"$i".fil
					cat test_report_"$grpname".trp >> tfw_log.tlf && cp -f tfw_log.tlf test_report_"$grpname"_"$i".trp && rm -f test_report_"$grpname".trp
				else
					rm -f test_report_"$grpname".trp
				fi
		else
		echo 'FAILED!!!'>>fail.txt	
	fi	
	done
	rm -f test.txt
   	testid=`expr $testid + 1` 
	done < test_groups_idle_ON.tool
	SUCCESS=`grep -c SUCCEEDED! success.txt`
	FAIL=`grep -c FAILED!!! fail.txt`

	cp -f fail.txt fail_idle.txt
	cp -f success.txt success_idle.txt
#Finally restoring the original config data to config.dat file.	
	cd -
	cp root/dat/config_actual.dat root/dat/config.dat
	
	echo "======SYSTEM TESTING REPORT FOR IDLE MODE============="
	TODAY=$(date)
	HOST=$(hostname)
	echo "Date: $TODAY         Host:$HOST"
	echo "Each test group has been executed for $COUNTER number of times"
	echo "The total test cases success are $SUCCESS"
	echo "The total test cases failed  are $FAIL"
	echo "======================================================"
    else
       echo "Build Failed"
       echo "Exiting the Shell Script"
    fi
fi

if [ -d build ]
then
   cd build/posix/st_fw_app/bin
   if [ -f Wimax_posix_tfw_app ]
       then
       echo "Build Successful"
       cd -
       cd systemtest/script
       cp test_groups_sleep.tool ../../build/posix/st_fw_app/bin/test_groups_sleep.tool
       cd ../../
       cd build/posix/st_fw_app/bin/

        if [ -f test.txt ]
	    then
	    rm -f test.txt
	fi
	if [ -f fail.txt ]
	    then
	    rm -f fail.txt
	fi
	if [ -f success.txt ]
	    then
	    rm -f success.txt
	fi
        
	echo "The test groups will be executed for $COUNTER number of times"
	testid=1
	while read inputline;
	do
	echo "$inputline" > test.txt
	for ((  i = 0 ;  i < $COUNTER;  i++  ))
	do
	grpname=`cut -c11-150 test.txt`
    echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    echo "Test cases for SLEEP MODE "
	echo "TEST GROUP NAME : $grpname"
	echo " TEST GROUP ID : $testid ITERATION : `expr $i + 1`"
		echo "Current Time is : `date`"	
    echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
	echo "Group Name : $grpname" >> fail.txt
    echo "Group Name : $grpname" >> success.txt
    echo "---------------------------------------------" >> fail.txt
    echo "---------------------------------------------" >> success.txt
	START=$(date +%s)
	./Wimax_posix_tfw_app  < test.txt || echo "FAILED!!! segmentation fault">>test_report_"$grpname".trp 
	END=$(date +%s)
	DIFF=$(( $END - $START ))
	echo It took $DIFF seconds.

	sleep 10
	if [ -f test_report_"$grpname".trp ]
	    then
			grep 'FAILED!!!' test_report_"$grpname".trp >> fail.txt 
			grep 'SUCCEEDED!' test_report_"$grpname".trp >> success.txt
		#take backup of the log files if any failure occurs. otherwise no need to backup log files
				FAILCTR=`grep -c 'FAILED!!!' test_report_"$grpname".trp`
				if [ 0 != $FAILCTR ]
				then
					cp -f report.fil report_"$grpname"_"$i".fil
					cat test_report_"$grpname".trp >> tfw_log.tlf && cp -f tfw_log.tlf test_report_"$grpname"_"$i".trp && rm -f test_report_"$grpname".trp
				else
					rm -f test_report_"$grpname".trp
				fi
		else
		echo 'FAILED!!!'>>fail.txt	
	fi	
	done
	rm -f test.txt
   	testid=`expr $testid + 1` 
	done < test_groups_sleep.tool


	SUCCESS=`grep -c SUCCEEDED! success.txt`
	FAIL=`grep -c FAILED!!! fail.txt`

	echo "======SYSTEM TESTING REPORT FOR SLEEP MODE======="
	TODAY=$(date)
	HOST=$(hostname)
	echo "Date: $TODAY         Host:$HOST"
	echo "Each test group has been executed for $COUNTER number of times"
	echo "The total test cases success are $SUCCESS"
	echo "The total test cases failed  are $FAIL"
	echo "=================================================="
	cp -f fail.txt fail_sleep.txt
	cp -f success.txt success_sleep.txt
    else
       echo "Build Failed"
       echo "Exiting the Shell Script"
    fi
fi



#!/bin/tcsh -f
# Time-stamp: <2015-05-22 10:32:05 kmodi>
# Read from a file

foreach line ("`cat test.txt`")
    echo $line
end

set hour1_file = "/tmp/${USER}_hour1"
set min1_file  = "/tmp/${USER}_min1"
set hour2_file = "/tmp/${USER}_hour2"
set min2_file  = "/tmp/${USER}_min2"
alias set_time_alerts 'echo 17 >! ${hour1_file}; \\
                       echo 45 >! ${min1_file}; \\
                       echo 18 >! ${hour2_file}; \\
                       echo 00 >! ${min2_file}; \\
                      '
alias reset_time_alerts 'rm ${hour1_file} ${min1_file} ${hour2_file} ${min2_file}'

set hour1 = 16
set min1  = 45
if ( -e ${hour1_file} ) then
    echo here
    foreach line ("`cat ${hour1_file}`")
        set hour1 = `echo -n $line`
        echo reading line $hour1
    end
    foreach line ("`cat ${min1_file}`")
        set min1 = `echo -n $line`
        echo reading line $min1
    end
endif

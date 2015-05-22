#!/bin/tcsh -f
# Time-stamp: <2015-05-22 10:31:50 kmodi>

# Getting random numbers

alias getrandomseed 'date +%s%N | md5sum | tr "abcdef" "123456" | head -c 8'
alias std_use_case  'set temp = `getrandomseed`; echo `expr 3 + $temp % 15`' # std use case 3 to 17
alias getrandombit  'set temp = `getrandomseed`; echo `expr $temp % 2`' # 0 or 1

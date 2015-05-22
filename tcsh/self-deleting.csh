#!/bin/tcsh -fe
# Time-stamp: <2015-05-22 10:33:03 kmodi>

# Self-deleting script.

set called=($_)

if ( "${called}" != "" ) then  ### called by source
   # echo "branch 1"
   set script_file_name=`readlink -f $called[2]`
else                         ### called by direct excution of the script
   # echo "branch 2"
   set script_file_name=`readlink -f $0`
endif

# echo "A:$0"
# echo "B:${called}"
set script_dir=`dirname ${script_file_name}`

echo "Script file name: ${script_file_name}"
echo "Script dir: ${script_dir}"

if ( ${script_dir} == "/tmp" ) then
    echo "Self-deleting ${script_file_name} .."
    \rm -f ${script_file_name}
endif

unset ${script_file_name}
unset ${script_dir}
unset ${called}

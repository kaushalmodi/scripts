#!/bin/tcsh
# Time-stamp: <2015-05-22 10:25:45 kmodi>
# Check if atleast one file matching a wildcard expression exists

# The key is the "&&" operator here. Commands after && will be executed ONLY
# if the command before it did not have any error.
if ( `(\ls aliass_*.csh >& /tmp/log ) && ( cat /tmp/log | wc -l )` > 0 ) then
    echo Yay
else
    echo Nay
endif

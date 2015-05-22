#!/bin/tcsh -f
#Time-stamp: <2015-01-16 14:55:15 kmodi>

# Script to get the last modified FILE or the last modified FILE matching
# the optional argument

if ( $#argv == 1 ) then
    set name_search_str = $1
else
    set name_search_str = ""
endif

find . -maxdepth 1 \
     -not -type d -name "*${name_search_str}*" \
     ! \( -regex '.*\.swp' -o \
     -regex '.*\.SWP' -o \
     -regex '\.\/\..*' \) \
     -printf '%T@ %p\n' | sort -k 1n | \
     sed 's/^[^ ]* //' | tail -1

unset name_search_str

#!/bin/tcsh -f
# Time-stamp: <2015-05-22 10:27:12 kmodi>
# Color-rich diff
# Requires ack to be installed

\diff $argv[*] | \
\ack -h --flush --passthru --color --color-match='grey12'        '^< .*' | \
# when using diff -bur \
\ack -h --flush --passthru --color --color-match='grey12'        '^-[^-].*' | \
\ack -h --flush --passthru --color --color-match='grey12'        '^--- .*' | \
\ack -h --flush --passthru --color --color-match='grey5'         '^@@ .*' | \
# Deleted lines \
\ack -h --flush --passthru --color --color-match='bright_red'    '^[\d,]+d.*' | \
# Added lines \
\ack -h --flush --passthru --color --color-match='bright_green'  '^[\d,]+a.*' | \
# Changed lines \
\ack -h --flush --passthru --color --color-match='bright_yellow' '^[\d,]+c.*' | \
\ack -h --flush --passthru --color --color-match='grey5'         '^--- *$'

# Recursive diff between 2 directories
# diff -bur dir1/ dir2

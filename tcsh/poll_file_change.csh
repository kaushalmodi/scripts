#!/bin/tcsh -f
# Using inotifywait to poll file change

while ( 1 )
    inotifywait -e close_write temp.txt
    echo "Hey"
end

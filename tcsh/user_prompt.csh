#!/bin/tcsh -f
# Time-stamp: <2015-05-22 10:37:01 kmodi>

# User input prompt

echo "(1) Please enter some input: "
set input_variable = "$<" # supports spaces in user input
echo "You entered: $input_variable"

echo "(2) Please enter some input: "
set input_variable = $< # doesn't support spaces in user input
echo "You entered: $input_variable"

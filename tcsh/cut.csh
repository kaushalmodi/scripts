#!/bin/tcsh
# cut snippets

# get current project name
pwd | cut -d'/' -f3

# get the current dir and its parent dir's names
pwd | rev | cut -d'/' -f1-3 | rev

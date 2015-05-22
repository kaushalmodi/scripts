#!/bin/tcsh -f

# This script splits the pane depending on the current panes height and width
# The result is to not result in too narrow or too wide panes after split

set pane_height=`tmux display -p -F '#{pane_height}'`
set pane_width=`tmux display -p -F '#{pane_width}'`
# echo "Pane Height = $pane_height"
# echo "Pane Width  = $pane_width"

# for the small Dell monitor when the terminal is full screen
# Small Dell monitor resolution = 1600 x 1200
#  width in chars = 174, height in chars = 59
# Normalize the pane height and width (resolution/char)
set height_factor = `expr 1200 / 59`
set width_factor  = `expr 1600 / 174`
set pane_height_norm = `expr $pane_height \* $height_factor`
set pane_width_norm  = `expr $pane_width  \* $width_factor`
# echo "Pane Height factor = $height_factor"
# echo "Pane Width factor  = $width_factor"
# echo "Pane Height normalized = $pane_height_norm"
# echo "Pane Width  normalized = $pane_width_norm"

if ( $pane_width_norm > $pane_height_norm ) then
   tmux split-window -h "$*" # splits current pane vertically
else
   tmux split-window -v "$*" # splits current pane horizontally
endif

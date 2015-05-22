#!/bin/tcsh -f

set tmux_pane_history_file = /tmp/${USER}_tmux_pane_history
# set tmux_pane_history_file = "~/temp/buf.txt"

# Capture the current tmux pane
#  -p: Prints the captured content to stdout which is then piped to a file
#  -J: Joins the wrapping lines
#  * Line numbers:
#    - If line 0 is the topmost visible line in the pane, the next line visible
#      below it would be line 1.
#    - If line 0 is the topmost visible line in the pane, the line above
#      that line which is hidden would be -1.
#  -S <S_num>: Line number from which capturing needs to be started in *upward*
#              direction. Usually S_num is 0 or a +ve number.
#  -E <E_num>: Line number till which capturing needs to be done. E_num <= S_num.
#              In other words, E_num has to be *above* S_num (or can be the same
#              as S_num). Usually E_num is a -ve number.
tmux capture-pane -p -J -S 100 -E -100 >! ${tmux_pane_history_file}

# Use the special character `\K' and `positive zero-width lookahead' for
# filtering out text that you don't want to be output by ack
# Example: \ack -o '.*\Ktemp(?=.*0$)' /etc/watchdog.conf
#  Here, only `temp' will be output
#   - Stuff *preceeding* \K will *not* be output
#   - Stuff in the `positive zero-width lookahead' will *not* be output

# Get the nobackup results folder
# set nobackup_dir = `ackb 'Results Directory' ${tmux_pane_history_file} | tail -n 1 | awk -F- '{print $2}' | tr -d ' '`
set nobackup_dir = `ackb -o '.*Results Directory\s*\-\s*\K[/\w]+(?=\s*)' ${tmux_pane_history_file}`
# echo ${nobackup_dir}

# Get the pattern name
# set pattern_name = `ackb 'Pattern=' ${tmux_pane_history_file} | tail -n 1 | awk -F= '{print $2}' | awk '{print $1}' | tr -d ' '`
set pattern_name = `ackb -o '.*Pattern=\K.*?(?=\s+.*)' ${tmux_pane_history_file}`
# echo ${pattern_name}

set sim_dir_name = ${nobackup_dir}/${pattern_name}
# echo "Sim dir name ${sim_dir_name}"

# Get the compilation log file name in the event of compilation failure
set compile_dir_name = `ackb -o '.*\K/nobackup.*?(?=/nc_rtl_compile.*:\s*Compilation Failed.*$)' ${tmux_pane_history_file}`
# echo "Compile dir name ${compile_dir_name}"

if ( ${compile_dir_name} == "" ) then
    echo ${sim_dir_name}
else
    echo ${compile_dir_name}
endif

unset nobackup_dir
unset pattern_name
unset sim_dir_name
unset compile_dir_name

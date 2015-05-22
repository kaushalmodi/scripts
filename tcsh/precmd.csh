#!/bin/tcsh -f
# Time-stamp: <2015-05-22 10:30:42 kmodi>
# TCSH Prompt

set root_dir          = `pwd | cut -d"/" -f2`
set root2_dir         = `pwd | cut -d"/" -f3`
set root3_dir         = `pwd | cut -d"/" -f4`
set dir_depth         = `pwd | awk -F/ '{ print NF-1 }'`
set prompt_prefix_sep = ''
set prompt_prefix2    = ''

# /home/...
if ( ${root_dir} == 'home' ) then
    if ( $USER == ${root2_dir} ) then
        if ( $dir_depth == 2 ) then
            set prompt_base   = 2
            set prompt_prefix = \~/
        else
            set prompt_base   = 3
            set prompt_prefix = \~/${root3_dir}/
        endif
    else
        set prompt_base   = 2
        set prompt_prefix = \~${root2_dir}
    endif
# /proj/...
else if ( ${root_dir} =~ 'proj*' ) then
    set prompt_prefix = `echo ${root2_dir} | \
        sed -r 's/^ad[v]*([0-9]+.*)/\1/p' | \
        head -c 1 | \
        tr "a-z" "A-Z"``echo ${root2_dir} | \
        sed -r 's/^ad[v]*([0-9]+.*)/\1/p' | \
        head -c 3 | \
        tail -c 2`.`echo ${root2_dir} | \
        tail -c 2 | \
        tr "a-z" "A-Z"`
    if ( $dir_depth == 2 ) then
        set prompt_base = 2
    else
        set prompt_base = 3
        if ( ${root3_dir} =~ "*$USER" ) then
            set prompt_prefix2 = \~
        else
            set prompt_prefix_sep = \|
            set prompt_prefix2    = `echo ${root3_dir} | sed s/sos_// | head -c 5`
        endif
    endif
# /nobackup/...
else if ( ${root_dir} =~ 'nobackup' ) then
    if ( $dir_depth >= 2 ) then
        if ( ${root2_dir} =~ "$USER" ) then
            set prompt_prefix2 = \~
        else
            set prompt_prefix_sep = \|
            set prompt_prefix2    = `echo ${root2_dir} | head -c 5`
        endif
    endif
    if ( $dir_depth <= 2 ) then
        set prompt_base   = ${dir_depth}
        set prompt_prefix = /${root_dir}
    else
        set prompt_base       = 3
        set prompt_prefix_sep = " nob|"
        set prompt_prefix = `echo ${root3_dir} | \
            sed -r 's/^results_(.*)/\1/p' | \
            sed -r 's/^ad[v]*([0-9]+.*)/\1/p' | \
            head -c 1 | \
            tr "a-z" "A-Z"``echo ${root3_dir} | \
            sed -r 's/^results_(.*)/\1/p' | \
            sed -r 's/^ad[v]*([0-9]+.*)/\1/p' | \
            head -c 3 | \
            tail -c 2`.`echo ${root3_dir} | \
            tail -c 2 | \
            tr "a-z" "A-Z"`
    endif
else
    set prompt_base   = 1
    set prompt_prefix = /${root_dir}
endif

if ( $dir_depth == $prompt_base ) then
    set trailing_dir_names = ''
else if ( $dir_depth == `expr $prompt_base + 1` ) then
    set trailing_dir_names = `pwd | rev | cut -d/ -f1 | rev`
else if ( $dir_depth == `expr $prompt_base + 2` ) then
    set trailing_dir_names = `pwd | rev | cut -d/ -f1-2 | rev`
else if ( $dir_depth > `expr $prompt_base + 3` ) then
    set trailing_dir_names = "../`pwd | rev | cut -d/ -f1-3 | rev`"
else
    set trailing_dir_names = `pwd | rev | cut -d/ -f1-3 | rev`
endif

if ( $?VIRTUAL_ENV ) then
    set virtual_env_prefix = "[py-env] "
else
    set virtual_env_prefix = ''
endif

# ################################################################################
# # Set the rprompt based on time
# ################################################################################
# set hour1_file = "/tmp/${USER}_hour1"
# set min1_file  = "/tmp/${USER}_min1"
# set hour2_file = "/tmp/${USER}_hour2"
# set min2_file  = "/tmp/${USER}_min2"
# alias set_time_alerts 'echo 17 >! ${hour1_file}; \\
#                        echo 45 >! ${min1_file}; \\
#                        echo 18 >! ${hour2_file}; \\
#                        echo 00 >! ${min2_file}; \\
#                       '
# alias reset_time_alerts 'rm ${hour1_file} ${min1_file} ${hour2_file} ${min2_file}'
# alias delay_time_alerts 'echo 23 >! ${hour1_file}; \\
#                          echo 23 >! ${min1_file}; \\
#                          echo 23 >! ${hour2_file}; \\
#                          echo 23 >! ${min2_file}; \\
#                         '

# # Warn that it's about time to leave at 4:45pm
# set hour1 = 16
# set min1  = 45
# if ( -e ${hour1_file} ) then
#     foreach line ("`cat ${hour1_file}`")
#         set hour1 = `echo -n $line`
#     end
#     foreach line ("`cat ${min1_file}`")
#         set min1 = `echo -n $line`
#     end
# endif

# if ( $hour1 > 12 ) then
#     set hour1_12 = `expr $hour1 - 12`
# else
#     set hour1_12 = $hour1
# endif

# # Stronger warning; hard limit at 5:00pm
# set hour2 = 17
# set min2  = 00
# if ( -e ${hour2_file} ) then
#     foreach line ("`cat ${hour2_file}`")
#         set hour2 = `echo -n $line`
#     end
#     foreach line ("`cat ${min2_file}`")
#         set min2 = `echo -n $line`
#     end
# endif

# if ( $hour2 > 12 ) then
#     set hour2_12 = `expr $hour2 - 12`
# else
#     set hour2_12 = $hour2
# endif

# set hour = `date | awk '{ print $4 }' | awk -F: '{ print $1}'`
# set min  = `date | awk '{ print $4 }' | awk -F: '{ print $2}'`
# # The hour and min variables can contain leading zeros
# # Below hack converts them to numbers and gets rid of the leading zeros
# set hour = `expr $hour + 0`
# set min  = `expr $min + 0`

# if ( $hour > 12 ) then
#     set hour_12 = `expr $hour - 12`
#     set pm      = "pm"
# else
#     set hour_12 = $hour
#     set pm      = ''
# endif

# if ( ( ( $hour == $hour2 ) && ( $min >= $min2 ) ) || ( $hour > $hour2 ) ) then
#     set rprompt = '%{\033[5;37;41m%}It'"'"'s already %${hour_12}:%${min}%${pm}\\! LEAVE\\!\\!%{\033[0m%} '
# else if ( ( ( $hour == $hour1 ) && ( $min >= $min1 ) ) || ( $hour > $hour1 ) ) then
#     set rprompt = '%{\033[0;34;43m%}It is %${hour_12}:%${min}%${pm}. Time to leave soon.%{\033[0m%} '
# else
#     unset rprompt
# endif

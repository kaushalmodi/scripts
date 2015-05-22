#!/bin/tcsh
# Time-stamp: <2015-05-22 10:24:05 kmodi>
# Experiments with tcsh alias arguments

alias test1 'echo All arguments                          : \!*'
test1 a b c d e f

alias test1 'echo All arguments                          : \!:*'
test1 a b c d e f

alias test1 'echo Name of the alias                      : \!:0'
test1 a b c d e f

alias test1 'echo 1st argument                           : \!:1'
test1 a b c d e f

alias test1 'echo 1st argument                           : \!^'
test1 a b c d e f

alias test1 'echo 1st argument                           : \!:^'
test1 a b c d e f

alias test1 'echo 2nd argument                           : \!:2'
test1 a b c d e f

alias test1 'echo 3rd argument                           : \!:3'
test1 a b c d e f

alias test1 'echo 2nd and onwards arguments              : \!:2*'
test1 a b c d e f

alias test1 'echo 2nd-\>4th arguments                    : \!:2-4'
test1 a b c d e f

alias test1 'echo 2nd and 4th arguments                  : \!:2 \!:4'
test1 a b c d e f

alias test1 'echo last argument                          : \!:$'
test1 a b c d e f

alias test1 'echo last argument                          : \!$'
test1 a b c d e f

alias test1 'echo 3rd-\>last arguments                   : \!:3-$'
test1 a b c d e f

alias test1 'echo first 3 arguments                      : \!^-3'
test1 a b c d e f

alias test1 'echo first 3 arguments                      : \!:^-3'
test1 a b c d e f

alias test1 'echo all arguments except the last          : \!:*-'
test1 a b c d e f

alias test1 'echo 4th-\>second last arguments            : \!:4-'
test1 a b c d e f

alias test1 'echo alias name + all arguments             : \!:0*'
test1 a b c d e f

alias test1 'echo alias name + all arguments             : \!:-*'
test1 a b c d e f

alias test1 'echo alias name + all arguments             : \!:-$'
test1 a b c d e f

alias test1 'echo alias name + all arguments except last : \!:--'
test1 a b c d e f

alias test1 'echo \!\! | awk -F" " '"'"'{ print NF - 1 }'"'"' '
# alias test1 'echo \!\!'
test1 a b c d e f

echo ""

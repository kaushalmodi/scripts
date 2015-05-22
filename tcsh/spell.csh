#!/bin/tcsh -f
# Time-stamp: <2015-05-22 10:34:53 kmodi>
# Command line spell-check

set noglob

set spell_checker = 'aspell'
# set spell_checker = 'hunspell'

if ( ${spell_checker} == 'aspell' ) then
    set spellchk_result  = `echo $argv[*] | aspell -a | sed '/Aspell/d'`
else if ( ${spell_checker} == 'hunspell' ) then
    set spellchk_result  = `echo $argv[*] | hunspell | sed '/Hunspell/d'`
endif
# echo ${spellchk_result}

set correct_spelling = `echo ${spellchk_result} | \ag -c '^[\*\+]'`

if ( ${correct_spelling} == 1 ) then
    cecho bgreen "Correct Spelling!"
else
    cechon bred "Correction Suggestions:"
    if ( ${spell_checker} == 'aspell' ) then
        echo $argv[*] | aspell -a | \ack '^\&.*:\s+(.*)' | cut -d: -f2
    else if ( ${spell_checker} == 'hunspell' ) then
        echo $argv[*] | hunspell | \ack '^\&.*:\s+(.*)' | cut -d: -f2
    endif
endif

unset {spellchk_result}
unset {correct_spelling}

unset noglob

# alias spell 'eval "if ( `echo \!:1 | hunspell | \ack -c '"'"'^[\*\+]'"'"'` == 1 ) then \\
#                        cecho bgreen Correct Spelling!; \\
#                        else \\
#                        cechon bred Correction Suggestions:; \\
#                        echo \!:1 | hunspell | \ack '"'"'^\&.*:\s+(.*)'"'"' | cut -d: -f2; \\
#                        endif"; \\
#                        '

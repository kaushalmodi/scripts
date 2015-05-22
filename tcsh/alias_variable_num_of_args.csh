#!/bin/tcsh
# Time-stamp: <2015-05-22 10:23:58 kmodi>
# Experiments with variable number of arguments

################################################################################
# S O L U T I O N
################################################################################
echo ""
alias test4 'set arg1 = `echo \!:1* | awk '"'"'{ print $1 }'"'"'`; \\
      echo -n "Arg num 1 = $arg1 "; \\
      set arg2 = `echo \!:2* | awk '"'"'{ print $1 }'"'"'`; \\
      echo -n "Arg num 2 = $arg2 "; \\
      set arg3 = `echo \!:3* | awk '"'"'{ print $1 }'"'"'`; \\
      echo -n "Arg num 3 = $arg3 "; \\
      set arg4 = `echo \!:4* | awk '"'"'{ print $1 }'"'"'`; \\
      echo -n "Arg num 4 = $arg4 "; \\
      set arg5 = `echo \!:5* | awk '"'"'{ print $1 }'"'"'`; \\
      echo -n "Arg num 5 = $arg5 "; \\
      echo ""; \\
      '
test4 abc
test4 abc def ghi
test4 abc def ghi jkl
test4 abc def ghi jkl mno
test4 abc def ghi jkl mno pqr
################################################################################

alias test5 'echo \!:1*'
test5 abc def

alias test1 'set arg1=`echo \!* | awk '"'"'{ print $1 }'"'"'`; \\
      set arg2=`echo \!* | awk '"'"'{ print $2 }'"'"'`; \\
      set arg3=`echo \!* | awk '"'"'{ print $3 }'"'"'`; \\
      echo $arg1 $arg2 $arg3; \\
      eval "if ( $arg1 == '"'"''"'"' ) then \\
      echo No arguments \\
      else if ( $arg2 == '"'"''"'"' ) then \\
      echo Only 1 argument \\
      else if ( $arg3 == '"'"''"'"' ) then \\
      echo 2 arguments \\
      else \\
      echo 3 or more arguments \\
      endif \\
      "; \\
      echo ""; \\
      '

test1
test1 a
test1 a b
test1 a b c
test1 a b c d

echo ""
echo "Test 2"
alias test2 'echo \!:1* \!:2* \!:3* \!:4*'
# alias test2 'echo \!:3*'
test2 a
test2 a b
test2 a b c
test2 a b c d
test2 a b c d e

echo ""
alias test3 'eval "if ( !:2* == '"'"''"'"'  ) then \\
      echo '"'"'1st arg = \!:1*'"'"' \\
      else \\
      echo '"'"'1st arg = \!:1*'"'"' \\
      endif \\
      "; \\
      '
test3 a
test3 a b
test3 a b c
test3 a b c d


############################################################################
# Get alias arguments
############################################################################
alias getargs 'set alias_arg1=`echo \!* | awk '"'"'{ print $1 }'"'"'`; \\
      set alias_arg2=`echo \!* | awk '"'"'{ print $2 }'"'"'`; \\
      set alias_arg3=`echo \!* | awk '"'"'{ print $3 }'"'"'`; \\
      set alias_arg4=`echo \!* | awk '"'"'{ print $4 }'"'"'`; \\
      set alias_arg5=`echo \!* | awk '"'"'{ print $5 }'"'"'`; \\
      '
############################################################################

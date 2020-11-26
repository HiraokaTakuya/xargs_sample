#!/bin/bash

if [ $# -ne 1 ]; then
    echo "The number of arguments is $#."
    echo "Expected 1 argument."
    echo "USAGE:
    ${0} <parallel-num>"
  exit 1
fi

seq_format="%04g"
seq_begin=0
seq_end=127
parallel_num=${1}
each_args_num=8

function do_command()
{
    # Implement as you like.
    echo ${1} ${2} ${3} ${4} ${5} ${6} ${7} ${8}
}

export -f do_command

# xargs can't use the arguments as redirects.
# If we want to use redirects, we use part of the arguments as redirects via do_command.
seq -s" " -f ${seq_format} ${seq_begin} ${seq_end} | xargs -n ${each_args_num} echo | xargs -P ${parallel_num} -I % bash -c "do_command %"

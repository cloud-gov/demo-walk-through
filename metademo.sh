#!/bin/bash

. ./settings.sh

intro() {
    p "I want to make it easy to run a demo of cloud.gov"
    p "without having to remember a particular order of commands"
    p "or resorting to copy/paste"

    p "The demo-magic framework at https://github.com/paxtonhare/demo-magic"
    p "helps. It uses 'pipeviewer' (pv) to echo commands as if you were"
    p "typing them, then 'eval's them. Like this:"
}

metademo() {
    echo
    pe "mycmd='cf target'; echo \$mycmd"
    p "echo \$mycmd| pv --quiet --rate-limit 5"
    echo $mycmd| pv --quiet --rate-limit 5
    p "eval \"\$mycmd\""
    eval "$mycmd"
}

intro
metademo
p "Now view demo.sh and try running it"

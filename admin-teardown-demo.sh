#!/usr/bin/env bash

########################
# include the magic
########################
. .demo-magic/demo-magic.sh


########################
# Configure the options
########################

#
# speed at which to simulate typing. bigger num = faster
#
TYPE_SPEED=40

#
# custom prompt
#
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
#
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W "

# hide the evidence
clear

if cf target | grep -q 'user.*peter.burkholder@gsa.gov'; then
  echo "OK"
else
  echo "need to login as peter.burkholder@gsa.gov"
  exit 1
fi

pe "neworg=demo-usda"
pe "cf delete-org $neworg"
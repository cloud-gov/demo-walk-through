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
pe "user=peter.burkholder"
pe "cf create-org $neworg -q default"
pe "cf set-org-role $user@connect.gov $neworg OrgManager"

pe "cf create-space -o $neworg dev"
pe "cf create-space -o $neworg stage"
pe "cf create-space -o $neworg preprod"

echo 
printf "Now login to \e[38;5;81mhttps://dashboard.fr.cloud.gov\e[0m as $user@connect.gov and invite $user@cao.gov\n"
echo 
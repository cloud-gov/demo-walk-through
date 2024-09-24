#!/usr/bin/env bash

# source the goodness
. ./init.sh

# hide the evidence
clear

# put your demo awesomeness here
pe "cf apps ; cf services ; cf routes"


pe "cf delete sample-app -f"
pe "cf delete-orphaned-routes -f"
pe "rm -rf sample-app"

echo
p "# Next step will delete a DB that takes 10m to create, ^c if you don't want to do this"
pe "cf delete-service sample-app-db -f"

# show a prompt so as not to reveal our true nature after
# the demo has concluded
p ""

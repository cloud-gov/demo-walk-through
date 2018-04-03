#!/usr/bin/env bash

# source the goodness
. ./settings.sh

check_i_am_devloper

# hide the evidence
clear

# put your demo awesomeness here
pe "cf apps ; cf services ; cf routes"

pe "cf delete cf-spring -f"
pe "cf delete-service cf-spring-db -f"
pe "cf delete-orphaned-routes -f"
pe "rm -rf cf-sample-app-spring"

# show a prompt so as not to reveal our true nature after
# the demo has concluded
p ""

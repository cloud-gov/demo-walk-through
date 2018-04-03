#!/usr/bin/env bash

# setup the goodness
. ./settings.sh

# hide the evidence
clear

check_i_am_admin

pe "cf create-org $org -q default"
pe "cf set-org-role $user@connect.gov $org OrgManager"

cf target -o $org

pe "cf create-space -o $org dev"
pe "cf create-space -o $org stage"
pe "cf create-space -o $org preprod"

pe "cf spaces"

echo 
printf "Now login to \e[38;5;81mhttps://dashboard.fr.cloud.gov\e[0m as $user@connect.gov and invite $user@cao.gov\n"
echo 

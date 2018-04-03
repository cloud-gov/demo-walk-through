#!/usr/bin/env bash

########################
# include the magic
########################
. ./settings.sh

# hide the evidence
clear

check_i_am_admin

pe "neworg=$org"
pe "cf delete-org $neworg"

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
TYPE_SPEED=20

#
# custom prompt
#
# see
# http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html
# for escape sequences
#
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W "


function fail() {
  echo $@
  exit 1
}

# DEFAULT to using the GSA Sandbox Acct
cf target > /dev/null || fail "Need to login to cloud.gov for this to work"
user=$(cf target | perl -ne '/^user:\s+([\w\.-]+?)@/ && print "$1"')
devdomain=gsa.gov
org=sandbox-gsa
space=$user

# Override the above setting if we have a specific demo user to use
[ -r ./demo-user-setup.sh ] && source ./demo-user-setup.sh

function check_i_am_devloper() {
  if cf target | grep -q "user.*$user@$devdomain"; then
    echo "OK"
  else
    echo "need to login as $user@$devdomain"
    exit 1
  fi
}

function check_i_am_admin() {
  if cf target | grep -q "user.*$user@gsa.gov"; then
    echo "OK"
  else
    echo "need to login as $user@gsa.gov"
    exit 1
  fi
}

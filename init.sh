########################
# include the magic
########################
source .demo-magic/demo-magic.sh
set -e

# DEFAULTS
# speed at which to simulate typing. bigger num = faster
TYPE_SPEED=20

# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W "

# set to 'true' to run all the way through
NO_WAIT=false

# override defaults if desired
[ -r $HOME/.cgdemorc ] && . $HOME/.cgdemorc

function fail() {
  echo FAIL: "$@"
  exit 1
}

cf version 1>/dev/null || fail "Need 'cf' CLI installed"

cf target 2>&1 | grep -q "Use .cf login. to log in" >/dev/null && 
  fail "'cf target' error. Are you logged into a cloud.gov sandbox account\?"

cf target | grep -q '^org: *sandbox-' || 
  fail "'cf target' says you're not connected to a sandbox org. Try 'cf target'"

cf curl /v2/organizations | grep -q "Authentication has expired" &&
  fail "Authentication has expired.  Please log back in to re-authenticate."

org_count=$(cf orgs | wc -l)
if [ "$org_count" -gt 10 ]
then
  echo "#########################"
  echo "#########################"
  echo   WARNING: you see more than 10 orgs
  echo   "If you're an operator, consider using"
  echo   "an unprivileged account for demos"
  echo "#########################"
  echo "#########################"
fi

CFORG=$(cf target | perl -ane 'm/^org: *(\S+)/ and print "$1\n"')
CFUSER=$(cf target | perl -ane 'm/^user: *([^@]+)/ and print "$1\n"')

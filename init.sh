########################
# include the magic
########################
source .demo-magic/demo-magic.sh

# DEFAULTS
# speed at which to simulate typing. bigger num = faster
TYPE_SPEED=20

# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W "

# pause time
NAPTIME=8

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
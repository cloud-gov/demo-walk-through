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
# TYPE_SPEED=20

#
# custom prompt
#
# see
# http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html
# for escape sequences
#
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W "

case $CG_SCENARIO in
  "demo-usda")
    user=peter.burkholder
    devdomain=cao.gov
    org="demo-usda"
    space=dev
    ;;
  *)
    user=peter.burkholder
    devdomain=cao.gov
    org=sandbox-cao
    space=peter.burkholder
    ;;
esac

function check_i_am_devloper() {
  if cf target | grep -q "user.*$user@$devdomain"; then
    echo "OK"
  else
    echo "need to login as $user@$devdomain"
    exit 1
  fi
}

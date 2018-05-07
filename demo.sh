#!/usr/bin/env bash

# include the goodness
. ./settings.sh
naptime=8

# hide the evidence
clear

check_i_am_devloper

if cf target | grep -q "user.*$user@$devdomain"; then
  echo "OK"
else
  echo "need to login as $user@$devdomain"
  exit 1
fi

# put your demo awesomeness here
pe "cf help"

asldfkj90() {
p "# view https://github.com/18F/cf-sample-app-spring"
[ -d cf-sample-app-spring ] && rm -rf cf-sample-app-spring/
pe "git clone https://github.com/18F/cf-sample-app-spring"

pe "cd cf-sample-app-spring"
p "cf login -a https://api.fr.cloud.gov --sso"
cat<<END
API endpoint: https://api.fr.cloud.gov

One Time Code ( Get one at https://login.fr.cloud.gov/passcode )>
^C
END

pe "cf target -o $org -s $space"
(sleep $naptime && open -a "Google Chrome.app" \
  "https://github.com/18F/cg-workshop/raw/master/images/app_push_flow_diagram_diego.png") &
pe "cf push" 

pe "cf marketplace"
pe "cf marketplace -s aws-rds"
pe "cf create-service aws-rds shared-mysql cf-spring-db"
pe "cf bind-service cf-spring cf-spring-db"

(sleep $naptime && open -a "Google Chrome.app" https://logs.fr.cloud.gov ) &

pe "cf restage cf-spring"
pe "cf app cf-spring"
pe "cf scale -i 2 cf-spring"
pe "cf app cf-spring"
}

pe "cf ssh cf-spring -c 'ps -ef'"

# show a prompt so as not to reveal our true nature after
# the demo has concluded
echo
echo "If you're done, run ./demo-cleanup.sh"
echo "-- fini $0 --"
echo
p ""

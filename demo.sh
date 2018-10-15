#!/usr/bin/env bash

# include the goodness
source ./init.sh
REPO=https://github.com/cloudfoundry-samples/spring-music

cleanup() {
  echo "DOING PRE-DEMO CLEAN UP" 
  cf delete cf-spring -f >/dev/null
  cf delete-service cf-spring-db -f >/dev/null
  rm -rf spring-music
}

cleanup
# clean up screen before continuing
clear

# put your demo awesomeness here
p "# cf help confirms that we have the CF CLI installed"
pe "cf help"

p "# now lets clone the sample app from $REPO"

exit
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

echo "Let's SSH in..."
pe "cf ssh cf-spring"

# show a prompt so as not to reveal our true nature after
# the demo has concluded
echo
echo "If you're done, run ./demo-cleanup.sh"
echo "-- fini $0 --"
echo
p ""

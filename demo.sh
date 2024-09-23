#!/usr/bin/env bash 

set -e

# include the goodness
source ./init.sh
REPO=https://github.com/cloudfoundry-tutorials/sample-app
DIR=sample-app
APP=sample-app

cleanup() {
  echo "DOING PRE-DEMO CLEAN UP" 
  cf delete sample-app -f >/dev/null
  cf delete-service sample-app-db -f >/dev/null
  cf delete-orphaned-routes -f
}

function launch() {
cleanup
# clean up screen before continuing
clear

# put your demo awesomeness here
p "# cf help confirms that we have the CF CLI installed"
pe "cf help"

echo
p "# now lets clone the sample app from $REPO"

/bin/rm -rf $DIR
pe "git clone $REPO"

echo
p "# and cd into the directory, $DIR"
pe "cd $DIR"

echo
p "# at this point, log in if you've not already done so, e.g:"
p "cf login -a https://api.fr.cloud.gov --sso"
cat<<END
API endpoint: https://api.fr.cloud.gov

One Time Code ( Get one at https://login.fr.cloud.gov/passcode )>
^C
END

echo
p "# set the target org and space"
pe "cf target -o $CFORG -s $CFUSER"


echo
p "# We can now push the app to Cloud Foundry"
p "# while it runs, we can walk the seq diagram at"
echo  "https://github.com/18F/cg-workshop/raw/master/images/app_push_flow_diagram_diego.png"
pe "cf push" 
}

launch


route=$(cf app $APP | perl -ane 'm/routes: *(\S+)/ && print "$1\n"')
echo 
p "# if you haven't already, view the running app at its route:"
echo "https://${route}"

echo
p "# to add a backend service, see what's in the 'marketplace'"
pe "cf marketplace"

echo
p "# use the -s switch for details on the aws-rds offering"
pe "cf marketplace -e aws-rds"

echo 
p "# create a micro-mysql instance 'sample-app-db'"
pe "cf create-service aws-rds micro-mysql sample-app-db"

echo
p "# it takes a few minutes for AWS to create the DB"
p "# so let's discuss other features while I used the "
p "# watch + cf commands to check the status:"
pe "watch --chgexit -n 15 'cf service sample-app-db'"

echo
p "# 'binding' provides the app the env vars to connect to the service"
pe "cf bind-service sample-app sample-app-db"

echo
p "# now we restage the app so it can use the backend DB"
p "# while that runs, we can view logs at"
p "#        https://logs.fr.cloud.gov"
pe "cf restage sample-app"

echo 
p "# Now see services at https://${route}"

echo
p "# We have logs for debugging, and also ssh"

if (nc -zw 1 ssh.fr.cloud.gov 2222 ) >/dev/null; then
  p "# but SSH is blocked so we'll skip that"
else
  pe "cf ssh sample-app -c 'ps'"
fi


echo 
p "# cleanup is easy. if you're done, run ./demo-cleanup.sh"
p "# THANK YOU FOR TOURING cloud.gov"
p ""

#!/usr/bin/env bash 

set -e

# include the goodness
source ./init.sh
REPO=https://github.com/pburkholder/sample-app
DIR=sample-app
APP=sample-app

cleanup() {
  echo "DOING PRE-DEMO CLEAN UP" 
  cf delete sample-app -f >/dev/null
  # cf delete-service sample-app-db -f >/dev/null
  cf delete-orphaned-routes -f
}

cleanup
# clean up screen before continuing
clear

# put your demo awesomeness here
p "# demo assumes:"
p "# a. a Cloud.gov account and that you have logged in with:"
p "cf login -a https://api.fr.cloud.gov --sso"
cat<<END
API endpoint: https://api.fr.cloud.gov

One Time Code ( Get one at https://login.fr.cloud.gov/passcode )>
^C
END

p "# b. you have Git and the CF CLI installed"
pe "cf help"

echo
p "# First, lets clone the sample app from $REPO"

/bin/rm -rf $DIR
pe "git clone $REPO"

echo
p "# and cd into the directory, $DIR"
pe "cd $DIR"

echo

echo
p "# Set the CF target org and space"
pe "cf target -o $CFORG -s $CFUSER"

echo
p "# THAT IS ALL! We can now push the app to Cloud Foundry"
p "# while it runs, we can walk the seq diagram at"
echo  "https://github.com/18F/cg-workshop/raw/master/images/app_push_flow_diagram_diego.png"

pe "cf push --random-route" 


route=$(cf app $APP | perl -ane 'm/routes: *(\S+)/ && print "$1\n"')
echo 
p "# View the running app at its route:"
echo "https://${route}"

echo
p "# To add a backend service, see what's in the 'marketplace'"
pe "cf marketplace"

echo
p "# Use the -e switch for details on the aws-rds offering"
pe "cf marketplace -e aws-rds"

echo 
p "# Create a micro-mysql instance 'sample-app-db'"
p "cf create-service aws-rds micro-mysql sample-app-db"
echo "Creating service instance sample-app-db in org sandbox-gsa / space peter.burkholder as peter.burkholder@gsa.gov..."
p "...but here I've cheated a created this DB before the demo"

echo
p "# 'binding' provides the app the env vars to connect to the service"
pe "cf bind-service sample-app sample-app-db"

echo
p "# Restage the app so it can use the backend DB"
p "# While it restages, we'll view the logs at https://logs.fr.cloud.gov"
pe "cf restage sample-app"

echo 
p "# See app with services at https://${route}"

echo
p "# You can SSH into the running container"
#if (nc -zw 1 ssh.fr.cloud.gov 2222 ) >/dev/null; then
#  p "# but SSH is blocked so we'll skip that"
#else
  pe "cf ssh sample-app"
#fi

echo 
p "# cleanup is easy. If you're done, run ./demo-cleanup.sh"
p "# THANK YOU FOR TOURING cloud.gov"
p ""

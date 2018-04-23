########################
# include the magic
########################
. ../.demo-magic/demo-magic.sh

########################
# Configure the options
########################

#
# speed at which to simulate typing. bigger num = faster
#
TYPE_SPEED=40

#
# custom prompt
#
# see
# http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html
# for escape sequences
#
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W "

# hide the evidence
clear

pe "export CFHOST=https://djangopong.app.cloud.gov"

pe "curl -v -X DELETE \$CFHOST/all"
pe "curl -v -H \"Content-Type: application/json\" -X PUT \$CFHOST/match_requests/peterb -d '{\"player\": \"peter\"}'"
echo
pe "curl -v -H \"Content-Type: application/json\" -X PUT \$CFHOST/match_requests/serena -d '{\"player\": \"serena\"}'"
echo


p "# Let's get the match_id as \$matchid"

pe "curl -sX GET \$CFHOST/match_requests/peterb"
echo
pe "curl -sX GET \$CFHOST/match_requests/peterb -q | jq -r '.match_id'"
echo

pe "matchid=\$(curl -sX GET \$CFHOST/match_requests/peterb -q | jq -r '.match_id')"

pe "echo matchid: \$matchid"

p "# POST works, but does nothing:"
pe "curl -v -H \"Content-Type: application/json\" -X POST \$CFHOST/results -d '{ \"match_id\":\"\$matchid\", \"winner\":\"serena\", \"loser\":\"peter\" }'"

pe "curl -X GET \$CFHOST/matches/\$matchid"
echo


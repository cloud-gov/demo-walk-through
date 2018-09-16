#!/bin/bash -xe -o pipefail

function deploy_node() {
    (cd node-app; cf push --random-route)
}

node_app_host=$(
    cf curl /v2/apps/$(cf app hello-iife --guid)/summary | 
     jq -r '.routes[0].host')
node_app_domain=$(
    cf curl /v2/apps/$(cf app hello-iife --guid)/summary | 
     jq -r '.routes[0].domain.name')

function run_ab(){
    H=https://$node_app_host.$node_app_domain/
    curl $H
    ab -n 100 -c 10 $H/
}

run_ab
#!/bin/bash -xe -o pipefail

function deploy_node() {
    (cd node-app; cf push --random-route)
}

function setup_vars() {
    node_app_host=$(
        cf curl /v2/apps/$(cf app hello-iife --guid)/summary | 
        jq -r '.routes[0].host')
    node_app_domain=$(
        cf curl /v2/apps/$(cf app hello-iife --guid)/summary | 
        jq -r '.routes[0].domain.name')
}

function run_ab(){
    H=https://$node_app_host.$node_app_domain/
    curl $H
    ab -n 120 -c 15 $H/
}

function deploy_ratelimiter() {
    (cd ratelimit-service && cf push ratelimiter)
    cf create-user-provided-service ratelimiter-service -r https://ratelimiter.app.cloud.gov
    cf bind-route-service app.cloud.gov ratelimiter-service --hostname $node_app_host
}

function clean_up() {
    cf delete -f hello-iife
    cf unbind-route-service app.cloud.gov -f ratelimiter-service --hostname $node_app_host
    cf delete-route app.cloud.gov --hostname ratelimiter -f
    cf ds -f ratelimiter-service
    cf delete -f ratelimiter
    cf delete-orphaned-routes -f
    

}

deploy_node
setup_vars
run_ab
deploy_ratelimiter
run_ab
clean_up


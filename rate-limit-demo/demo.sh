#!/bin/bash -xe -o pipefail

function deploy_node() {
    cf delete-orphaned-routes -f
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
    cf routes && sleep 2
    setup_vars
    H=https://$node_app_host.$node_app_domain/
    curl $H
    siege -r 12 -c 10 -b $H
}

function deploy_ratelimiter() {
    setup_vars
    (cd ratelimit-service && cf push ratelimiter)
    cf create-user-provided-service ratelimiter-service -r https://ratelimiter.app.cloud.gov
    cf bind-route-service app.cloud.gov ratelimiter-service --hostname $node_app_host
}

function clean_up() {
    setup_vars
    cf delete -f hello-iife
    cf unbind-route-service app.cloud.gov -f ratelimiter-service --hostname $node_app_host
    cf delete-route app.cloud.gov --hostname ratelimiter -f
    cf ds -f ratelimiter-service
    cf delete -f ratelimiter
    cf delete-orphaned-routes -f
}

doall() {
    deploy_node
    run_ab
    deploy_ratelimiter
    run_ab
    clean_up
}

eval $1



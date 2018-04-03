# Before a demo:

0. login as a sandbox-only user (e.g. w/ @cao.org email account)
0. delete all apps and services and routes
0. make sure all the step below work
0. For a group walkthrough, set up an empty Windows box, then:
* Install chocolatey
* Install mysql client

# Simple Demo

We're using this as our standard demo app since a) it uses the Java buildpack, b) the code is pretty simple

### Login

```
cf api https://api.fr.cloud.gov
cf login --sso
```

### Show empty state

```
cf target
cf apps
cf services
```

### Launch

```
cf push
```

During push, describe what's going on:

![Staging](https://github.com/18F/cg-workshop/raw/master/images/app_push_flow_diagram_diego.png)

### Connect up app to a database

```
cf marketplace
cf marketplace -s aws-rds
cf create-service aws-rds shared-mysql cf-spring-db
cf bind-service cf-spring cf-spring-db
```

# 2. Demo w/ management options

Scenario: 
  * `$user@connect.gov` is an OrgManager for `demo-$department`
  * `$user@connect.gov` is logged in to dashboard
  * `$user` goes to `demo-$department`, creates 3 spaces
    * Nope - can't do this
  * `$user` invites `$user@cao.gov` to the `dev` space

## Before the demo

1. Terminal with developer user, $user@cao.gov, logged in with `cf`, and CF_HOME=~/.cf-cao
1. Terminal with admin user, $user@gsa.gov, logged in
1. Browser with OrgManager, $user@connect.gov, logged in to dashboard
1. Browser with /quickstart
1. Browser with logs.fr.cloud.gov

## Demo

TEXT: Usually we direct people to the /quickstart for sandbox, but let's do this exercise as if USDA had a prototyping organization, which will call `demo-usda`. We'll create that 'org', then three space within it.  Since I don't have a USDA user, I'll use my alias 'peter.burkholder@connect.gov' as the OrgManager (meaning I have full rights). I run this as a cloud.gov OPERATOR

ADMIN: run `admin-setup-demo.sh`

The point here is not to demonstrate just the developer experience, but the full automation around a building out an entire self-service system management.

Now the cloud.gov operators let the USDA org manager now they can get to work, so they invite a developer `$user@cao.gov` to be a development 'developer'

BROWSER: go to dashboard invite $user@cao.gov

DEVELOPER: (do the quickstart)

That shows the beginning of the developer experience
- let's add a DB
- marketplace, marketplace -s, create-service, bind-service, restage

While that restage, let's look at the logs

Other features:
- scale up/down
- ssh







1. As the uses@connect.gov, login to dashboard:
1. As the user@cao.gov, login to CF at the command line (use CF_HOME=~/.cf-cao)

## Demo

Dashboard:
1. Invite `$user@cao.gov` to the dev space
1. Set perms to `developer` only (managee things, not people)

CLI as user@cao.gov, confirm settings are OK

```
cf orgs
cf target -o demo-usda -s dev
cf target
```

CLI as 

### Demo reset

As ADMIN

```
cf target -o $neworg -s dev
cf delete cf-spring
cf ds cf-spring-db
cf delete-orphaned-routes
cf unset-space-role peter.burkholder@cao.gov demo-usda dev SpaceDeveloper
```





# Choose your own adventure

* View the logs, command line and w/ Kibana
* Connect to app with SSH
* Connect to DB with `connect-to-service`
* View other available services
* Visit the dashboard 

# Clean up

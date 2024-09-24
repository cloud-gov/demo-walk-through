# cloud.gov Demos

This project provides several live interactive demonstrations of 
cloud.gov functionality.

## Useful links for the demo:

* [cloud.gov login](https://login.fr.cloud.gov/login)
* [cloud.gov dashboard](https://dashboard.fr.cloud.gov)
* [sample-app repository](https://github.com/pburkholder/sample-app)
* [orgs, spaces, and apps](http://basics-workshop.cloudfoundry.org/slides/#/20)
* [users roles by org and space](https://docs.run.pivotal.io/console/images/pws/invite-members.png)
* [cf push sequence diagram](https://raw.githubusercontent.com/18F/cg-workshop/master/images/app_push_flow_diagram_diego.png)
* [example projects at cloud.gov](https://cloud.gov/docs/apps/frameworks/#customer-example-applications)
* [open service broker API](https://www.openservicebrokerapi.org/)

## Prerequisites

* `pv` - the [pipe viewer utility](https://www.ivarch.com/programs/pv.shtml) for *nix systems
  * Install with, e.g, `brew install pv` or `apt-get install pv` or `yum install pv`
* `cf` - the [Cloud Foundry command line interface](https://github.com/cloudfoundry/cli)
  * Install with, e.g, `brew install cf-cli` or `apt-get install cf-cli` or `yum install cf-cli`
* A sandbox account on cloud.gov, which you can sign up for here: https://account.fr.cloud.gov/signup

## Quickstart Demo

This is a demo of the [Java application demo](https://cloud.gov/quickstart/).

Before the demo:
  * Use `git` to clone this repository, then `cd` into it.
  * Login to cloud.gov: `cf login -a https://api.fr.cloud.gov --sso`

Run the demo:
```
./demo.sh
```

Clean up:
```
./demo-cleanup.sh
```

## Auditing

We spell out how to use audit endpoints at:
https://cloud.gov/docs/compliance/auditing-activity/. This directory ... has a
stub for using audit.

## Testing/Developing

These demos all rely on [demo-magic](https://github.com/paxtonhare/demo-magic), which is included at `.demo-magic/demo-magic.sh`

## Other demos

* Cloud.gov identity provider demo (in dev): https://github.com/pburkholder/demo-cloud-gov-identity

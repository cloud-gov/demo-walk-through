# cloud.gov Demos

This project provides several live interactive demonstrations of 
cloud.gov functionality.

## Prerequisites

* `pv` - the [pipe viewer utility](https://www.ivarch.com/programs/pv.shtml) for *nix systems
  * Install with, e.g, `brew install pv` or `apt-get install pv`
* `cf` - the [Cloud Foundry command line interface](https://github.com/cloudfoundry/cli)
  * Install with, e.g, `brew install cf-cli` or `apt-get install cf-cli`
* A sandbox account on cloud.gov, which you can sign up for here: https://account.fr.cloud.gov/signup

## Quick Demo

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

## Auditing

We spell out how to use audit endpoints at:
https://cloud.gov/docs/compliance/auditing-activity/. This directory ... has a
stub for using audit.

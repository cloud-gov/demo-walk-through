# Demos

These demos rely on [demo-magic](https://github.com/paxtonhare/demo-magic), which is included in the `.demo-magic` directory. You will need to install the `pv` utility to use the demos. The demos work by invoking the script, then pressing \[return\] repeatedly to "type" and execute the commands.

## Quick Demo

Before the demo:
  1. login to `cf cli` as your `user@cao.gov` user: `cf login --sso`
  1. update `settings.sh`

Demo:
```
./demo.sh
```

Clean up:
```
./demo-cleanup.sh
```

## Orgs and users demo

Before the demo:

  1. in ADMIN terminal, login to `cf cli` as your `user@gsa.gov` user (assuming you're an operator)
  2. in DEVELOPER terminal, login to `cf cli` as your `user@cao.gov` user
  3. in BROWSER, login to https://dashboard.fr.cloud.gov as  the OrgManager,
     `user@connect.gov`
  4. update `settings.sh` 

Demo:

  1. Note: Usually we direct people to the /quickstart for sandbox run-through, but let's do this exercise as if YOUR AGENCY had a prototyping organization, which will call `demo-YOURAGENCY`. We'll create that `Org`, then three `spaces` within it.  Since I don't have a YOUR AGENCY user, I'll use my alias 'USER@connect.gov' as the `OrgManager` (meaning I have full rights to the Org). I run this as a cloud.gov OPERATOR
  1. ADMIN: `admin-setup-demo.sh`
  1. Note: The point here is not to demonstrate just the developer experience, but the full automation around a building out an entire self-service system management solution.  Now the cloud.gov operators let the YOUR AGENCY OrgManager know they can get to work, so they invite a developer `$user@cao.gov` to be a dev space 'developer'
  1. BROWSER: go to dashboard, and invite $user@cao.gov 
  1. DEVELOPER: `./demo.sh`

Clean up:
  1. DEVELOPER: `./demo-cleanup.sh`
  1. ADMIN: `admin-teardown-demo.sh`


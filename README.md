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

  1. Note: Usually we direct people to the /quickstart for sandbox, but let's do this exercise as if YOUR AGENCY had a prototyping organization, which will call `demo-YOURAGENCY`. We'll create that 'org', then three space within it.  Since I don't have a USDA user, I'll use my alias 'USER@connect.gov' as the OrgManager (meaning I have full rights). I run this as a cloud.gov OPERATOR
  1. ADMIN: `admin-setup-demo.sh`
  1. Note: The point here is not to demonstrate just the developer experience, but the full automation around a building out an entire self-service system management.  Now the cloud.gov operators let the YOUR AGENCY org manager now they can get to work, so they invite a developer `$user@cao.gov` to be a development 'developer'
  1. BROWSER: go to dashboard invite $user@cao.gov 
  1. DEVELOPER: `./demo.sh`

Clean up:
  1. DEVELOPER: `./demo-cleanup.sh`
  1. ADMIN: `admin-teardown-demo.sh`


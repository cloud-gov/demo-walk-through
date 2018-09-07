#!/bin/bash

GUID=$(cf space peter.burkholder --guid)

EVENTS=$(cat << END_EVENTS | perl -ne 's/[\n\s]/,/g; print'
app.crash
audit.app.copy-bits
audit.app.create
audit.app.delete-request
audit.app.droplet.mapped
audit.app.map-route
audit.app.package.create
audit.app.package.delete
audit.app.package.download
audit.app.package.upload
audit.app.restage
audit.app.ssh-authorized
audit.app.ssh-unauthorized
audit.app.start
audit.app.stop
audit.app.unmap-route
audit.app.update
audit.app.upload-bits
audit.organization.create
audit.organization.delete-request
audit.organization.update
audit.route.create
audit.route.delete-request
audit.route.update
audit.service.create
audit.service.delete
audit.service.update
audit.service_binding.create
audit.service_binding.delete
audit.service_broker.create
audit.service_broker.delete
audit.service_broker.update
audit.service_dashboard_client.create
audit.service_dashboard_client.delete
audit.service_instance.bind_route
audit.service_instance.create
audit.service_instance.delete
audit.service_instance.unbind_route
audit.service_instance.update
audit.service_key.create
audit.service_key.delete
audit.service_plan.create
audit.service_plan.delete
audit.service_plan.update
audit.service_plan_visibility.create
audit.service_plan_visibility.delete
audit.service_plan_visibility.update
audit.user_provided_service_instance.create
audit.user_provided_service_instance.delete
audit.user_provided_service_instance.update
audit.app.build.create
audit.app.droplet.create
audit.app.droplet.delete
audit.app.droplet.download
audit.app.process.crash
audit.app.process.create
audit.app.process.delete
audit.app.process.scale
audit.app.process.terminate_instance
audit.app.process.update
audit.app.task.cancel
audit.app.task.create
audit.service_instance.share
audit.service_instance.unshare
END_EVENTS
)

echo "Running query for GUID: $GUID, EVENTS: $EVENTS"
timestamp='2018-08-31T16:00'

set -x

cf curl '/v2/events?&results-per-page=100&q=timestamp>'$timestamp'&q=type+IN+'$EVENTS'&q=space_guid:'$GUID |
  jq -c -r '.resources[].entity | [ .timestamp, .actor_username, .type, .actee_name ] | @csv' > me.csv

set +x
#audit.app.start,audit.app.stop,audit.app.update,audit.app.create,audit.app.delete-request,audit.app.ssh-authorized,audit.app.ssh-unauthorized,audit.space.create,audit.space.update,audit.space.delete-request,audit.service_broker.create,audit.service_broker.update,audit.service_broker.delete,audit.service.create,audit.service.update,audit.service.delete,audit.service_plan.create,audit.service_plan.update,audit.service_plan.delete,audit.service_plan_visibility.create,audit.service_plan_visibility.update,audit.service_plan_visibility.delete,audit.service_dashboard_client.create,audit.service_dashboard_client.delete,audit.service_instance.create,audit.service_instance.update,audit.service_instance.delete,audit.user_provided_service_instance.create,audit.user_provided_service_instance.update,audit.user_provided_service_instance.delete,audit.service_binding.create,audit.service_binding.delete,audit.service_key.create,audit.service_key.delete'

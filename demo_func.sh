cleanup() {
  cf delete cf-spring -f
  cf delete-service cf-spring-db -f
  cf delete-orphaned-routes -f
  rm -rf cf-sample-app-spring
}

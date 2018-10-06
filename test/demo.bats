#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source ./demo_func.sh

@test "function cleanup is loaded" {
  run type cleanup
  [ "$status" -eq 0 ]
  assert_output --regexp 'cleanup is a function'
}


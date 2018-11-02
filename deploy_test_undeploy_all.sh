#!/usr/bin/env bash

set -e


for D in $(find . -maxdepth 1 -mindepth 1 -not -path '*/\.*'  -type d); do
  pushd ${D} > /dev/null
  ../deploy_test_undeploy_single.sh
  sleep 10
  popd > /dev/null
done


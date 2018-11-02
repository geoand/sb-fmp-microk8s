#!/usr/bin/env bash

set -e

SCRIPT_ABSOLUTE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
mvnCmd="${SCRIPT_ABSOLUTE_DIR}"/mvnw

export KUBECONFIG=/tmp/kubeconfig

echo "Starting application deployment to cluster"
$mvnCmd clean package fabric8:build fabric8:push fabric8:deploy

echo "Finished deployment"
echo "Starting the integration tests"
$mvnCmd verify -Pit -Dfabric8.skip

echo "Successfully executed integration tests"
echo "Undeploying application"
$mvnCmd fabric8:undeploy

#!/usr/bin/env bash

set -e

export KUBECONFIG=/tmp/kubeconfig

./mvnw clean package fabric8:build fabric8:push fabric8:deploy
./mvnw verify -Pit -Dfabric8.skip
./mvnw fabric8:undeploy

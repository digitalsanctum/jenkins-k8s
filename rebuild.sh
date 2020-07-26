#!/bin/bash

set -e

shopt -s expand_aliases
source ~/.bash_aliases

kc delete -f kubernetes/service.yaml || true
kc delete -f kubernetes/deployment.yaml || true
kc delete -f kubernetes/persistent-volume-claim.yaml || true
kc delete -f kubernetes/persistent-volume.yaml || true
kc delete -f kubernetes/service-account.yaml || true
kc delete -f kubernetes/namespace.yaml || true

echo
echo "Building jenkins image with the following plugins:"
cat downloads/plugins-latest.txt
echo

docker build -t digitalsanctum/jenkins .
docker login
docker push digitalsanctum/jenkins

kc create -f kubernetes/namespace.yaml
kc apply -f kubernetes/service-account.yaml
kc apply -f kubernetes/persistent-volume.yaml
kc apply -f kubernetes/persistent-volume-claim.yaml
kc apply -f kubernetes/deployment.yaml
kc apply -f kubernetes/service.yaml --validate=false

echo
source ./node.sh
echo
source ./url.sh
echo



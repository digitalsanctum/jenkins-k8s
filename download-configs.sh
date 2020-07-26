#!/bin/bash 

# Downloads configuration files from a pod.

set -e

shopt -s expand_aliases
source ~/.bash_aliases

NAMESPACE="jenkins"
TIMESTAMP=$(date +"%Y-%m-%d-%H-%M-%S")
RELATIVE_DIR="downloads/${TIMESTAMP}"
LOCAL_DIR="$(pwd)/${RELATIVE_DIR}"

export POD=$(kc get pod -n jenkins --no-headers=true -o wide | cut -d' ' -f1)

mkdir -p "${LOCAL_DIR}"
mkdir -p "${LOCAL_DIR}/jobs"
mkdir -p "${LOCAL_DIR}/secrets"
mkdir -p "${LOCAL_DIR}/users"

echo "Created ${LOCAL_DIR} directory."

echo "Downloading configurations from ${POD} pod."

# echo
# echo "kc cp jenkins/${POD}:/var/jenkins_home/config.xml ${RELATIVE_DIR}/config.xml || true"
# touch ${RELATIVE_DIR}/config.xml
kc cp jenkins/${POD}:/var/jenkins_home/config.xml ${RELATIVE_DIR}/config.xml || true
kc cp jenkins/${POD}:/var/jenkins_home/jobs/ ${RELATIVE_DIR}/jobs/ || true
kc cp jenkins/${POD}:/var/jenkins_home/secrets/master.key ${RELATIVE_DIR}/secrets/master.key || true
kc cp jenkins/${POD}:/var/jenkins_home/users/ ${RELATIVE_DIR}/users/ || true

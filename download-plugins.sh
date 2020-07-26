#!/bin/bash 

# Downloads installed plugins list from Jenkins.

set -e

shopt -s expand_aliases
source ~/.bash_aliases

IP=$(kc describe pod -n jenkins | grep -e ^Node: | cut -d'/' -f 2)
PORT=$(kc describe svc -n jenkins |grep -e ^NodePort | cut -d'/' -f1 | cut -d'>' -f2 | tr -d ' ')
TIMESTAMP=$(date +"%Y-%m-%d-%T")
URL="http://${IP}:${PORT}/pluginManager/api/xml"
# echo "${URL}"

OUTPUT_FILE="downloads/plugins-${TIMESTAMP}.txt"

curl -sSL "${URL}?depth=1&xpath=/*/*/shortName|/*/*/version&wrapper=plugins" | \
     perl -pe 's/.*?<shortName>([\w-]+).*?<version>([^<]+)()(<\/\w+>)+/\1 \2\n/g'|sed 's/ /:/' > \
     ${OUTPUT_FILE}

cat ${OUTPUT_FILE} | sort > downloads/plugins-latest.txt

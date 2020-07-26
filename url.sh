#!/bin/bash

set -e

shopt -s expand_aliases
source ~/.bash_aliases

IP=$(kc describe pod -n jenkins | grep -e ^Node: | cut -d'/' -f 2)
PORT=$(kc describe svc -n jenkins |grep -e ^NodePort | cut -d'/' -f1 | cut -d'>' -f2 | tr -d ' ')

echo "URL: http://${IP}:${PORT}"

#!/bin/bash

set -e

shopt -s expand_aliases
source ~/.bash_aliases

NODE=$(kc describe pod -n jenkins | grep -e ^Node: | cut -d'/' -f 1 | cut -d':' -f2 | tr -d ' ')

echo "Node: ${NODE}"

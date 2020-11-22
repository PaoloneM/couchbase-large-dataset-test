#!/bin/bash

# This script create config map from file

if [ -z "$1" ]
  then
    echo "No argument supplied, provide input filename"
    exit 1
fi

kubectl create configmap doc-template --from-file=$1 -o yaml --dry-run=client | sed 's/.*\|-.*/  DocTemplate.json: |-/' > _doc-template_configmap.yaml

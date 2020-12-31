#!/usr/bin/env bash

terraform init

terraform plan -var-file="variables.tfvars" -out=broadcaster.plan
terraform apply broadcaster.plan

rm -f broadcaster.plan
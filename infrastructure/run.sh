#!/usr/bin/env bash

# rm -rf ./.terraform

terraform init

terraform workspace select default

terraform plan -var-file="variables.tfvars" -out=broadcaster.plan
terraform apply broadcaster.plan

rm -f broadcaster.plan
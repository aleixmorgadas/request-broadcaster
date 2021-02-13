#!/usr/bin/env bash

terraform plan --destroy -out=broadcaster.plan
terraform apply broadcaster.plan

rm -f broadcaster.plan
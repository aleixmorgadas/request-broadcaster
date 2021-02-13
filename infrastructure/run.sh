#!/usr/bin/env bash

cd ../lambda


zip ../infrastructure/lambda_function_payload.zip index.js

cd -

terraform init

terraform plan -out=broadcaster.plan
terraform apply broadcaster.plan

rm -f broadcaster.plan
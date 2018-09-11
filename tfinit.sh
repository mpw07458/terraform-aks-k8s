#!/usr/bin/env bash
terraform init \
  -backend-config "storage_account_name=tfsstate" \
  -backend-config="container_name=tfsstate"
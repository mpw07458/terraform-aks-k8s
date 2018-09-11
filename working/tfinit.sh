#!/usr/bin/env bash
terraform init \
  -backend-config "storage_account_name=cloudshellstoragempw" \
  -backend-config="container_name=mpwcontainer"

#!/usr/bin/env bash
az storage blob lease break -b tfsstate -c tfsstate --account-name tfsstate

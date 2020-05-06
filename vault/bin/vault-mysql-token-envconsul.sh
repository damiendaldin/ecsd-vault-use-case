#!/bin/bash
# Generate token for readonly credentials for MYSQL. 
# Confirm this new token can’t do anything else.
# https://learn.hashicorp.com/vault/developer/sm-app-integration
# https://www.vaultproject.io/docs/commands/token/create


READONLY_TOKEN=`vault token create -policy=readonly -field token`
vault token lookup $READONLY_TOKEN

VAULT_TOKEN=$READONLY_TOKEN envconsul -config=/vault/config/envconsul-vault.hcl -secret="mysql/creds/readonly" python /scripts/getFromEnv.py

#!/bin/bash
docker-compose up -d --build
# Step 1
# Initialise Vault /vault/bin/vault-install.sh
docker-compose exec vault /scripts/vault-install.sh
# Step 2
# Unseal/Login Vault & Setup Mysql+Vault Env
docker-compose exec vault /scripts/vault-startup.sh
# Step 3
# Setup Mysql+Vault Env
docker-compose exec vault /scripts/vault-mysql.sh
# Step 4
# -----
docker-compose exec vault /scripts/vault-mysql-token-envconsul.sh
#

#docker-compose down
#rm -rf ./consul/data ./vault/data ./vault/logs ./mysql-data


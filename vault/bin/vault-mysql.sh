#!/bin/bash
echo "Connecting to database.. will wait upto a minute"
num=1
while [ $num -le 10 ]
do
    nc mysql 3306 -z
    if [ "$?" -ne 0 ]; then
        echo "$(($num * 5)) seconds gone, waiting 5 more.."
        sleep 5
        let num++
    else
    # Enable dynamic secrets engine
    # https://www.vaultproject.io/docs/secrets/databases/mysql-maria
    vault secrets enable mysql

    vault write mysql/config/connection \
    connection_url="root:my-secret-pw@tcp(mysql:3306)/"

    vault write mysql/roles/readonly \
    sql="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON *.* TO '{{name}}'@'%';" 
    #default_ttl="1h" \
    # max_ttl="24h"


    # Write Policy 
    # https://www.vaultproject.io/docs/commands/policy/write
    vault policy write readonly /vault/config/readonly-policy.hcl
    exit 0
    fi
done



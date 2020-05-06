#!/bin/bash
KEY=/vault/data/key.txt
if test -f "$KEY"; then
    echo "Vault appears to have been initialised"
    echo "DO NOT DELETE FILE /vault/data/key.txt"
    echo "You can remove the contents of /vault/data/key.txt and save it somewhere safe!!" 
    exit
else 
    echo "Initialising Vault and creating token and key."
    echo
    echo "Please wait upto a minute.."
touch /vault/data/key.txt
fi
sleep 10
num=2
while [ $num -le 8 ]
do
    if [ ! -s /vault/data/key.txt ]
    then
        vault operator init >> /vault/data/key.txt  
    else
        cat /vault/data/key.txt
        echo "DO NOT DELETE FILE /vault/data/key.txt"
        echo "You can remove the contents of /vault/data/key.txt and save it somewhere safe!!" 
        exit
    fi
    echo "$(($num * 5)) seconds gone, waiting 5 more.."
    sleep 5
    let num++
done




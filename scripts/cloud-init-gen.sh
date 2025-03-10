#!/bin/bash

mkdir -p ./data
mkdir -p ./http

# mkpasswd install
apt-get update && apt-get install whois -y

export USER="ubuntu"
export PASSWD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13)
export PASSWD_HSH="$(mkpasswd --method=SHA-512 --rounds=4096 \"$PASSWD\")"
export VM_SETTINGS=$(./scripts/genn.sh)
export VM_NAME=$(echo $VM_SETTINGS | jq -r ".name")
export VM_SLUG=$(echo $VM_SETTINGS | jq -r ".slug")
export VM_BUILD=$(date +"%Y-%m-%d %H:%M:%S")

export CREDENTIALS=$(jq -n --arg password "$PASSWD" --arg hash "$PASSWD_HSH" '{"password":$password, "hash":$hash}')
echo $CREDENTIALS > ./data/credentials.json

echo "" > ./http/meta-data
cat <<EOF > ./http/user-data
#cloud-config
autoinstall:
  version: 1
  identity:
    hostname: $VM_SLUG
    password: "$PASSWD_HSH"
    username: $USER
  ssh:
    install-server: yes
    allow-pw: yes
EOF

jq -n --arg name "$VM_NAME" --arg slug "$VM_SLUG" --arg build "$VM_BUILD" --arg password "$PASSWD" --arg hash "$PASSWD_HSH" '{"name":$name,"slug":$slug,"build":$build,"credentials":{"password":$password,"hash":$hash}}'

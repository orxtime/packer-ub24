#!/bin/bash

# if [ ! -f ./data/vm.json ]; then
#   # Create directory if not exists
#   mkdir -p ./data
#   # download program for naming
#   wget https://raw.githubusercontent.com/ON8RU/service-naming/refs/heads/master/genn.sh -qO /tmp/genn > /dev/null
#   chmod +x /tmp/genn > /dev/null
#   # generate name for vm
#   GENN="$(/tmp/genn -of animals)"
#   GENN_SLUG="$(echo "$GENN" | iconv -t ascii//TRANSLIT | sed -r s/[^a-zA-Z0-9]+/-/g | sed -r s/^-+\|-+$//g | tr A-Z a-z)"
#   # export result to json and save to file
#   jq -n --arg name "$GENN" --arg slug "$GENN_SLUG" '{"vmName":$name, "vmSlug":$slug}'
# else
#   VM_SETTINGS=$(cat ./data/vm.json)
#   GENN=$(echo $VM_SETTINGS | jq -r ".\"vmName\"")
#   GENN_SLUG=$(echo $VM_SETTINGS | jq -r ".\"vmSlug\"")
#   jq -n --arg name "$GENN" --arg slug "$GENN_SLUG" '{"vmName":$name, "vmSlug":$slug}'
# fi

wget https://raw.githubusercontent.com/ON8RU/service-naming/refs/heads/master/genn.sh -qO /tmp/genn > /dev/null
chmod +x /tmp/genn > /dev/null
# generate name for vm
GENN="$(/tmp/genn -of animals)"
GENN_SLUG="$(echo "$GENN" | iconv -t ascii//TRANSLIT | sed -r s/[^a-zA-Z0-9]+/-/g | sed -r s/^-+\|-+$//g | tr A-Z a-z)"
# export result to json and save to file
jq -n --arg name "$GENN" --arg slug "$GENN_SLUG" '{"vmName":$name, "vmSlug":$slug}'

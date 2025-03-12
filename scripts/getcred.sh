#!/bin/bash

cat <<EOF

######################################
# For SSH connection use this data:  #
# ---------------------------------- #
# Username: $(cat data/vm.json | jq -r '.vmUser')                   #
# Password: $(cat data/vm.json | jq -r '.vmPass')            #
######################################

EOF

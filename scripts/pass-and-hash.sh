export PASSWD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13)
export PASSWD_HSH="$(mkpasswd --method=SHA-512 --rounds=4096 \"$PASSWD\")"

jq -n --arg password "$PASSWD" --arg hash "$PASSWD_HSH" '{"password":$password, "hash":$hash}' > ./data/credentials.json
cat ./data/credentials.json

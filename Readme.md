# Readme

## Installation Packer by HashiCorp

```bash
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install packer
```

## Set enviroments

```bash
# Run (This will add the initial settings for the VM template)
./scripts/cloud-init-gen.sh
```

### Set settings for connection to xen host

```bash
# Xen Username
export XEN_USER=""
# Xen Password
export XEN_PASSWORD=""
# Xen Host/IP
export XEN_HOST=""
# Xen Storage for Disks
export XEN_SR=""
# Xen Storage for ISO images
export XEN_SR_ISO=""
```

### Set settings for new VM

```bash
# User VM
export VM_USER="ubuntu"
# User Password VM
export VM_PASS=$(cat ./data/credentials.json | jq -r ".password")
# User Password Hash VM (ubuntu stores password as hashes)
export VM_HASH=$(cat ./data/credentials.json | jq -r ".hash")
# VM Name (human friendly)
export VM_NAME=$(cat ./data/vm.json | jq -r ".name")
# VM Slaug (without spaces, lower case, kebab case)
export VM_SLUG=$(cat ./data/vm.json | jq -r ".slug")

```

### Create file with values for packer variables

```bash
cat <<EOF > ./terraform.tfvars
xen-user     = "$XEN_USER$"
xen-password = "$XEN_PASSWORD"
xen-host     = "$XEN_HOST"
xen-sr       = "$XEN_SR"
xen-sr-iso   = "$XEN_SR_ISO"
# ------------------------------------
vm-user      = "$VM_USER"
vm-pass      = "$VM_PASS"
vm-hash      = "$VM_HASH"
vm-name      = "$VM_NAME"
vm-slug      = "$VM_SLUG"
EOF
```

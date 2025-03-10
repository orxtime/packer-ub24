# Readme

## Installation Packer by HashiCorp

```bash
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install packer
```

## Set enviroments

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

### Write values to packer variable values file

```bash
cat <<EOF > ./xen.pkrvars.hcl
remote_username     = "$XEN_USER"
remote_password     = "$XEN_PASSWORD"
remote_host         = "$XEN_HOST"
sr_name             = "$XEN_SR"
sr_iso_name         = "$XEN_SR_ISO"
EOF
```

### Create values of variables

```bash
# Run (This will add the initial settings for the VM template)
./scripts/cloud-init-gen.sh
```

## Start building VM Template

### For first run use this command.

This will install the necessary plugins for packer.

```bash
packer init -upgrade -var-file="xen.pkrvars.hcl" -var-file="data/vm.json" .
```

### Build start

```bash
packer build -var-file="xen.pkrvars.hcl" -var-file="data/vm.json" .
```

## Clear project

```bash
rm -rf ./data
rm -rf ./http
rm -rf xen.pkrvars.hcl
```

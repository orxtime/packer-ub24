packer {
  required_plugins {
    xenserver= {
      version = ">= v0.5.2"
      source = "github.com/ddelnano/xenserver"
    }
  }
}

# Defines
locals {
  timestamp     = regex_replace(timestamp(), "[- TZ:]", "")
  iso_registry  = "https://releases.ubuntu.com"
  ub_version    = "24.04"
  ub_template   = "Ubuntu Noble Numbat 24.04"
}

data "http" "sha256_HTTP" {
  url           = "${local.iso_registry}/${local.ub_version}/SHA256SUMS"
}

local "sha256_ISO" {
  expression    = regex("([A-Za-z0-9]+)[\\s\\*]+ubuntu-.*server", data.http.sha256_HTTP.body)
}

local "url_ISO" {
  expression    = regex("[A-Za-z0-9]+[\\s\\*]+(ubuntu-${local.ub_version}.(\\d+)-live-server-amd64.iso)", data.http.sha256_HTTP.body)
}

data "external" "name_vm" {
  program = [
    "bash", "${path.module}/scripts/cloud-init-gen.sh"
  ]
}


# Variables
variable "xen-host" {
  type        = string
  description = "The ip or fqdn of your XenServer. This will be pulled from the env var 'PKR_VAR_XAPI_HOST'"
  sensitive   = true
  default     = null
}

variable "xen-user" {
  type        = string
  description = "The username used to interact with your XenServer. This will be pulled from the env var 'PKR_VAR_XAPI_USERNAME'"
  sensitive   = true
  default     = null

}

variable "xen-password" {
  type        = string
  description = "The password used to interact with your XenServer. This will be pulled from the env var 'PKR_VAR_XAPI_PASSWORD'"
  sensitive   = true
  default     = null
}

variable "xen-sr-iso" {
  type        = string
  default     = ""
  description = "The ISO-SR to packer will use"

}

variable "xen-sr" {
  type        = string
  default     = ""
  description = "The name of the SR to packer will use"
}


# Builder
source "xenserver-iso" "ubuntu" {
  iso_checksum              = "sha256:${local.sha256_ISO[0]}"
  iso_url           = "${local.iso_registry}/${local.ub_version}/${local.url_ISO[0]}"

  sr_iso_name    = var.xen-sr-iso
  sr_name        = var.xen-sr
  # tools_iso_name = ""

  remote_host     = var.xen-host
  remote_username = var.xen-user
  remote_password = var.xen-password

  clone_template = local.ub_template

  vm_name        = "Ubuntu ${local.ub_version} PCK ${data.external.name_vm.result.name}"
  vm_description = "Build started: ${local.build}"
  vm_memory      = 4096
  disk_size      = 20480

  http_directory = "http"

  boot_wait            = "3s"
  boot_command         = [
    "e<wait>",
    "<down><down><down><end><left><left><left>",
    " quiet autoinstall \"ds=nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/\" ",
    "<f10>"
  ]

  network_names = [ "Pool-wide network associated with eth0" ]

  vm_tags                 = [ "ubuntu ${local.ub_version}", "packer" ]

  ssh_username            = "ubuntu"
  ssh_password            = data.external.name_vm.result.credentials.password
  ssh_wait_timeout        = "60000s"
  ssh_handshake_attempts  = 10000

  output_directory = "packer-ubuntu"

  # always, never or on_success
  keep_vm          = "never"
}

build {
  sources = ["xenserver-iso.ubuntu"]
}

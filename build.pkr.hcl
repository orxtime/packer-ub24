packer {
  required_plugins {
    xenserver = {
      version = ">= v0.5.2"
      source  = "github.com/ddelnano/xenserver"
    }
  }
}

locals {
  ubuntu_version  = "24.04"
  ubuntu_template = "Ubuntu Noble Numbat 24.04"
  ubuntu_registry = "https://releases.ubuntu.com"
}



data "http" "sha256_source" {
  url = "${local.ubuntu_registry}/${local.ubuntu_version}/SHA256SUMS"
}

local "sha256" {
  expression = regex("([A-Za-z0-9]+)[\\s\\*]+ubuntu-.*server", data.http.sha256_source.body)
}

local "iso_url" {
  expression = regex("[A-Za-z0-9]+[\\s\\*]+(ubuntu-${local.ubuntu_version}.\\d+-live-server-amd64.iso)", data.http.sha256_source.body)
}


source "xenserver-iso" "ubuntu" {
  iso_checksum = "sha256:${local.sha256[0]}"
  iso_url      = "${local.ubuntu_registry}/${local.ubuntu_version}/${local.iso_url[0]}"

  sr_iso_name = var.sr_iso_name
  sr_name     = var.sr_name
  # tools_iso_name = "guest-tools.iso"

  remote_host     = var.remote_host
  remote_password = var.remote_password
  remote_username = var.remote_username

  # Change this to match the ISO of ubuntu you are using in the iso_url variable
  clone_template = local.ubuntu_template
  vm_name        = "Ubuntu ${local.ubuntu_version} - ${var.vmName}"
  vm_description = "Build started: ${var.vmBuild}"
  vm_memory      = 4096
  disk_size      = 30720

  floppy_files = [
    "http/meta-data",
    "http/user-data",
  ]

  # http_directory = "http"
  # boot_wait = "3s"
  # boot_command = [
  #   "e<wait>",
  #   "<down><down><down><end><left><left><left>",
  #   " quiet autoinstall \"ds=nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/\" ",
  #   "<f10>"
  # ]

  vm_tags = ["ubuntu-${local.ubuntu_version}", "packer"]

  network_names = [var.vmNetwork]

  ssh_username           = "${var.vmUser}"
  ssh_password           = "${var.vmPass}"
  ssh_wait_timeout       = "60000s"
  ssh_handshake_attempts = 10000

  output_directory = "packer-ubuntu-iso"
  keep_vm          = "always"
}

build {
  sources = ["xenserver-iso.ubuntu"]
}

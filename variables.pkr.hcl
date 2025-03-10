# Settings for connection to xen host

# Xen Host/IP
variable "xen-host" {
  type        = string
  description = "The ip or fqdn of your XenServer. This will be pulled from the env var 'PKR_VAR_XAPI_HOST'"
  sensitive   = true
  default     = null
}

# Xen Username
variable "xen-user" {
  type        = string
  description = "The username used to interact with your XenServer. This will be pulled from the env var 'PKR_VAR_XAPI_USERNAME'"
  sensitive   = true
  default     = null

}

# Xen Password
variable "xen-password" {
  type        = string
  description = "The password used to interact with your XenServer. This will be pulled from the env var 'PKR_VAR_XAPI_PASSWORD'"
  sensitive   = true
  default     = null
}

# Xen Storage for ISO images
variable "xen-sr-iso" {
  type        = string
  default     = ""
  description = "The ISO-SR to packer will use"

}

# Xen Storage for Disks
variable "xen-sr" {
  type        = string
  default     = ""
  description = "The name of the SR to packer will use"
}

# User VM
variable "vm-user" {
  type        = string
  default     = "ubuntu"
  description = "Username of VM default user for ssh access"
}

# User Password VM
variable "vm-pass" {
  type        = string
  default     = ""
  description = "Password for VM default user"
}

# User Password Hash VM (ubuntu stores password as hashes)
variable "vm-hash" {
  type        = string
  default     = ""
  description = "Password based hash for VM default user"
}

# Automatic generated Name of VM
variable "vm-name" {
  type        = string
  default     = "Tempestuous Neanderthal"
  description = "VM Name (human friendly)"
}

# VM Name Slug
variable "vm-slug" {
  type        = string
  default     = "tempestuous-neanderthal"
  description = "VM Slug (The name of the VM without spaces, in lowercase, in the kebab case (all words are separated by dashes))"
}

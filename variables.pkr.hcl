# VARIABLES
variable "remote_host" {
  type        = string
  description = "The ip or fqdn of your XenServer. This will be pulled from the env var 'PKR_VAR_XAPI_HOST'"
  sensitive   = true
  default     = null
}

variable "remote_password" {
  type        = string
  description = "The password used to interact with your XenServer. This will be pulled from the env var 'PKR_VAR_XAPI_PASSWORD'"
  sensitive   = true
  default     = null
}

variable "remote_username" {
  type        = string
  description = "The username used to interact with your XenServer. This will be pulled from the env var 'PKR_VAR_XAPI_USERNAME'"
  sensitive   = true
  default     = null
}

variable "sr_iso_name" {
  type        = string
  default     = ""
  description = "The ISO-SR to packer will use"
}

variable "sr_name" {
  type        = string
  default     = ""
  description = "The name of the SR to packer will use"
}

# User VM
variable "vmUser" {
  type        = string
  default     = "ubuntu"
  description = "Username of VM default user for ssh access"
}

# User Password VM
variable "vmPass" {
  type        = string
  default     = ""
  description = "Password for VM default user"
}

# User Password Hash VM (ubuntu stores password as hashes)
variable "vmHash" {
  type        = string
  default     = ""
  description = "Password based hash for VM default user"
}

# Automatic generated Name of VM
variable "vmName" {
  type        = string
  default     = "Tempestuous Neanderthal"
  description = "VM Name (human friendly)"
}

# VM Name Slug
variable "vmSlug" {
  type        = string
  default     = "tempestuous-neanderthal"
  description = "VM Slug (The name of the VM without spaces, in lowercase, in the kebab case (all words are separated by dashes))"
}

# Start of building template
variable "vmBuild" {
  type        = string
  default     = "2025-03-10 17:06:40"
  description = "Date and time when template building started"
}

# Name of network interface
variable "vmNetwork" {
  type        = string
  default     = "Pool-wide network associated with eth0"
  description = "Main interface for VM"
}

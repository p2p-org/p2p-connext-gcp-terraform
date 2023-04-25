variable "network_name" {
  type    = string
  default = "connext"
}

variable "region" {
  type = string
}

variable "cloudnat_name" {
  type    = string
  default = "connext"
}

variable "source_ranges" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "ssh_keys" {
  type = string
}

variable "module_name" {
  type    = string
  default = "router"
}

variable "routers" {
  type = map(object({
    name               = string
    router_ip          = optional(string)
  }))

  default     = {}
  description = "List of routers and its settings"
}

variable "subnetwork" {
  type    = string
  default = ""
}

variable "bastion_static_ip" {
  type    = string
  default = ""
}

variable "nat_static_ip" {
  type    = string
  default = ""
}

variable "bastion_ip" {
  type    = string
  default = ""
}

# variable "router_ip" {
#   type    = string
#   default = ""
# }

variable "monitoring_ip" {
  type    = string
  default = ""
}

variable "use_gcp_memstore" {
  type    = bool
  default = false
}

variable "use_monitoring_instance" {
  type    = string
  default = false
}

variable "use_web3signer_instance" {
  type    = string
  default = false
}

variable "router_instance" {
  type = object({
    availability_zone_name = string
    machine_type           = string
    disk_size              = string
    disk_type              = string
    image_type             = string
  })
}

variable "monitoring_instance" {
  type = object({
    availability_zone_name = string
    machine_type           = string
    disk_size              = string
    disk_type              = string
    image_type             = string
  })
}

variable "redis" {
  type = object({
    name           = string
    tier           = string
    primary_az     = string
    secondary_az   = string
    redis_version  = string
    memory_size_gb = number
  })
}

variable "bastion_instance" {
  type = object({
    availability_zone_name = string
    machine_type           = string
    disk_size              = string
    disk_type              = string
    image_type             = string
  })
}

variable "web3signer_instance" {
  type = object({
    availability_zone_name = string
    machine_type           = string
    disk_size              = string
    disk_type              = string
    image_type             = string
  })
}

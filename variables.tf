variable "project_name" {
  type = string
}

variable "region" {
  type = string
}

variable "network_name" {
  type = string
}

variable "cloudnat_name" {
  type = string
}

variable "source_ranges" {
  type = list(string)
}

variable "router_name" {
  type = string
}

variable "subnetwork" {
  type = string
}

variable "use_gcp_memstore" {
  type = string
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

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

variable "router_instance" {
    type = object({
      availability_zone_name = string
      machine_type           = string
      disk_size              = string
      disk_type              = string
      image_type             = string
    })
}

variable "redis_instance" {
    type = object({
      availability_zone_name = string
      machine_type           = string
      disk_size              = string
      disk_type              = string
      image_type             = string
      extended_disk_size     = string
      extended_disk_type     = string
    })
}

variable "sharezone_instance" {
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


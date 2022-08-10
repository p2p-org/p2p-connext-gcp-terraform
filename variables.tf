variable "project_name" {
  type = string
}

variable "region" {
  type = string
}

variable "network_name" {
  type = string
  default = "amarok"
}

variable "cloudnat_name" {
  type = string
  default = "amarok"
}

variable "source_ranges" {
  type = list(string)
  default = ["0.0.0.0/0"]
}

variable "router_name" {
  type = string
}

variable "subnetwork" {
  type = string
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

variable "use_gcp_memstore" {
  type = string
  default = false
}

variable "use_monitoring_instance" {
  type = string
  default = false
}

variable "use_web3signer_instance" {
  type = string
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

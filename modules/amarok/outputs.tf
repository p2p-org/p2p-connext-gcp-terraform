output "bastion-instance-info" {
  value = {
    "local_address"    = google_compute_instance.connext-amarok-bastion-instance.network_interface.0.network_ip
    "external_address" = google_compute_instance.connext-amarok-bastion-instance.network_interface.0.access_config.0.nat_ip
  }
}

output "web3signer-instance-info" {
  value = {
    "local_address" = google_compute_instance.connext-amarok-web3signer-instance.network_interface.0.network_ip
  }
}

output "redis-info" {
  value = {
    "local_address" = "${var.use_gcp_memstore ? google_redis_instance.cache[0].host : ""} "
  }
}

output "monitoring-instance-info" {
  value = {
    "local_address" = "${var.use_monitoring_instance ? google_compute_instance.connext-amarok-monitoring-instance[0].network_interface.0.network_ip : ""} "
  }
}

output "router-instance-info" {
  value = {
    "local_address" = google_compute_instance.connext-amarok-router-instance.network_interface.0.network_ip
  }
}

output "share-zone-instance-info" {
    value = {
      "local_address"       = google_compute_instance.connext-amarok-share-zone-instance.network_interface.0.network_ip
      "external_address"    = google_compute_instance.connext-amarok-share-zone-instance.network_interface.0.access_config.0.nat_ip
    }
}

output "web3signer-instance-info" {
    value = {
      "local_address"       = google_compute_instance.connext-amarok-web3signer-instance.network_interface.0.network_ip
    }
}

output "redis-instance-info" {
    value = {
      "local_address"       = google_compute_instance.connext-amarok-redis-instance.network_interface.0.network_ip
    }
}

output "router-instance-info" {
    value = {
      "local_address"       = google_compute_instance.connext-amarok-router-instance.network_interface.0.network_ip
    }
}


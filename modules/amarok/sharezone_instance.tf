resource "google_compute_instance" "connext-amarok-share-zone-instance" {
  depends_on = [
    google_compute_firewall.connext-amarok-firewall-basic,
    google_compute_firewall.connext-amarok-firewall-web3signer,
    google_compute_firewall.connext-amarok-firewall-sharezone
  ]

  name         = "connext-amarok-sharezone"
  machine_type = var.sharezone_instance.machine_type
  zone         = "${var.region}-${var.sharezone_instance.availability_zone_name}"

  tags = ["share-zone"]

  boot_disk {
    initialize_params {
      image = var.sharezone_instance.image_type
      type  = var.sharezone_instance.disk_type
      size  = var.sharezone_instance.disk_size
    }
  }

  network_interface {
    network = var.network_name

    access_config {
    }
  }

  allow_stopping_for_update = true

  metadata = {
    "ssh-keys" = "${var.ssh_keys}"
  }
}

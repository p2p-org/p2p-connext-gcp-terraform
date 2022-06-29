resource "google_compute_instance" "connext-amarok-web3signer-instance" {
  depends_on = [
    google_compute_firewall.connext-amarok-firewall-basic,
    google_compute_firewall.connext-amarok-firewall-web3signer,
    google_compute_firewall.connext-amarok-firewall-sharezone
  ]

  name         = "connext-amarok-web3signer"
  machine_type = var.web3signer_instance.machine_type
  zone         = "${var.region}-${var.web3signer_instance.availability_zone_name}"

  tags = ["web3signer"]

  boot_disk {
    initialize_params {
      image = var.web3signer_instance.image_type
      type  = var.web3signer_instance.disk_type
      size  = var.web3signer_instance.disk_size
    }
  }

  network_interface {
    network = var.network_name

  }

  allow_stopping_for_update = true

  metadata = {
    "ssh-keys" = "${var.ssh_keys}"
  }
}

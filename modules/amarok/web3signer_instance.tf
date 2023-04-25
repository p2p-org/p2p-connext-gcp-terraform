resource "google_compute_instance" "connext-amarok-web3signer-instance" {
  count = var.use_web3signer_instance ? 1 : 0

  depends_on = [
    google_compute_firewall.connext-amarok-firewall-router-to-web3signer
  ]

  name         = "${var.module_name}-web3signer"
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
    network    = var.network_name
    subnetwork = var.subnetwork == "" ? null : google_compute_subnetwork.connext-amarok-subnetwork[0].id
  }

  allow_stopping_for_update = true

  shielded_instance_config{
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }

  metadata = {
    "ssh-keys" = "${var.ssh_keys}"
  }
}

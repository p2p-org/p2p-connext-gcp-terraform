resource "google_compute_instance" "connext-amarok-bastion-instance" {
  depends_on = [
    google_compute_firewall.connext-amarok-firewall-basic,
    google_compute_firewall.connext-amarok-firewall-web3signer,
    google_compute_firewall.connext-amarok-firewall-bastion
  ]

  name         = "${var.router_name}-bastion"
  machine_type = var.bastion_instance.machine_type
  zone         = "${var.region}-${var.bastion_instance.availability_zone_name}"

  tags = ["bastion"]

  boot_disk {
    initialize_params {
      image = var.bastion_instance.image_type
      type  = var.bastion_instance.disk_type
      size  = var.bastion_instance.disk_size
    }
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnetwork == "" ? null : google_compute_subnetwork.connext-amarok-subnetwork[0].id

    access_config {
    }
  }

  allow_stopping_for_update = true

  metadata = {
    "ssh-keys" = "${var.ssh_keys}"
  }
}

resource "google_compute_instance" "connext-amarok-bastion-instance" {
  depends_on = [
    google_compute_firewall.connext-amarok-firewall-from-bastion,
    google_compute_firewall.connext-amarok-firewall-bastion-from-external
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
    network_ip = var.bastion_ip == "" ? null : var.bastion_ip

    access_config {
      nat_ip = var.bastion_static_ip == "" ? null : var.bastion_static_ip
    }
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

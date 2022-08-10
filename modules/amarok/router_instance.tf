resource "google_compute_instance" "connext-amarok-router-instance" {
  depends_on = [
    google_compute_firewall.connext-amarok-firewall-from-bastion
  ]

  name         = "${var.router_name}-router"
  machine_type = var.router_instance.machine_type
  zone         = "${var.region}-${var.router_instance.availability_zone_name}"

  tags = ["router"]

  boot_disk {
    initialize_params {
      image = var.router_instance.image_type
      type  = var.router_instance.disk_type
      size  = var.router_instance.disk_size
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

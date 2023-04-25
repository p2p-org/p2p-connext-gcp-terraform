resource "google_compute_instance" "connext-amarok-router-instance" {
  depends_on = [
    google_compute_firewall.connext-amarok-firewall-from-bastion
  ]

  for_each = var.routers

  name         = "${each.value.name}-router"
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
    network_ip = each.value.router_ip == "" ? null : each.value.router_ip
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

resource "google_compute_instance" "connext-amarok-monitoring-instance" {
  count = var.use_monitoring_instance ? 1 : 0

  depends_on = [
    google_compute_firewall.connext-amarok-firewall-from-monitoring,
    google_compute_firewall.connext-amarok-firewall-bastion-to-monitoring
  ]

  name         = "${var.module_name}-monitoring"
  machine_type = var.monitoring_instance.machine_type
  zone         = "${var.region}-${var.monitoring_instance.availability_zone_name}"

  tags = ["monitoring"]

  boot_disk {
    initialize_params {
      image = var.monitoring_instance.image_type
      type  = var.monitoring_instance.disk_type
      size  = var.monitoring_instance.disk_size
    }
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnetwork == "" ? null : google_compute_subnetwork.connext-amarok-subnetwork[0].id
    network_ip = var.monitoring_ip == "" ? null : var.monitoring_ip
  }

  allow_stopping_for_update = true
  enable_display            = true

  shielded_instance_config{
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }

  metadata = {
    "ssh-keys" = "${var.ssh_keys}"
    "serial-port-enable" = "true" 
  }
}

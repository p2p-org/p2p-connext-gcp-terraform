resource "google_compute_instance" "connext-amarok-router-instance" {
  depends_on = [
                 google_compute_firewall.connext-amarok-firewall-basic,
                 google_compute_firewall.connext-amarok-firewall-router,
                 google_compute_firewall.connext-amarok-firewall-web3signer,
                 google_compute_firewall.connext-amarok-firewall-sharezone
               ]

  name         = "connext-amarok-router"
  machine_type = "${var.router_instance.machine_type}"
  zone         = "${var.region}-${var.router_instance.availability_zone_name}"

  tags         = ["router"]

  boot_disk {
    initialize_params {
      image = "${var.router_instance.image_type}"
      type  = "${var.router_instance.disk_type}"
      size  = "${var.router_instance.disk_size}"
    }
  }

  network_interface {
    network    = "${var.network_name}"

  }

  allow_stopping_for_update = true

  metadata = {
    "ssh-keys" = "${var.ssh_keys}"
  }
}

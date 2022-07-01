resource "google_compute_firewall" "connext-amarok-firewall-basic" {
  depends_on = [google_compute_router.connext-amarok-cloudnat-router]

  name    = "${var.network_name}-firewall-basic"
  network = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["22", "9090"]
  }

  source_tags = ["bastion"]
}

resource "google_compute_firewall" "connext-amarok-firewall-web3signer" {
  depends_on = [google_compute_router.connext-amarok-cloudnat-router]

  name    = "${var.network_name}-firewall-web3signer"
  network = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["9000"]
  }

  source_tags = ["router"]
  target_tags = ["web3signer"]
}

resource "google_compute_firewall" "connext-amarok-firewall-bastion" {
  depends_on = [google_compute_router.connext-amarok-cloudnat-router]

  name    = "${var.network_name}-firewall-bastion"
  network = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags   = ["bastion"]
  source_ranges = var.source_ranges
}

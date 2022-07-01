resource "google_compute_firewall" "connext-amarok-firewall-from-bastion" {
  depends_on = [google_compute_router.connext-amarok-cloudnat-router]

  name    = "${var.network_name}-from-bastion"
  network = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_tags = ["bastion"]
}

resource "google_compute_firewall" "connext-amarok-firewall-router-to-web3signer" {
  depends_on = [google_compute_router.connext-amarok-cloudnat-router]

  name    = "${var.network_name}-router-to-web3signer"
  network = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["9000"]
  }

  source_tags = ["router"]
  target_tags = ["web3signer"]
}

resource "google_compute_firewall" "connext-amarok-firewall-from-monitoring" {
  depends_on = [google_compute_router.connext-amarok-cloudnat-router]

  name    = "${var.network_name}-from-monitoring"
  network = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["9090"]
  }

  source_tags = ["monitoring"]
}

resource "google_compute_firewall" "connext-amarok-firewall-bastion-to-monitoring" {
  depends_on = [google_compute_router.connext-amarok-cloudnat-router]

  name    = "${var.network_name}-bastion-to-monitoring"
  network = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["3000", "9999"]
  }

  source_tags = ["bastion"]
  target_tags = ["monitoring"]
}

resource "google_compute_firewall" "connext-amarok-firewall-bastion-from-external" {
  depends_on = [google_compute_router.connext-amarok-cloudnat-router]

  name    = "${var.network_name}-bastion-from-external"
  network = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags   = ["bastion"]
  source_ranges = var.source_ranges
}

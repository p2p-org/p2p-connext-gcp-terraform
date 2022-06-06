resource "google_compute_router" "connext-amarok-cloudnat-router" {
  depends_on         = [
      google_compute_network.connext-amarok-vpc-network
  ]

  name     = "${var.cloudnat_name}-router-${var.region}"
  region   = "${var.region}"
  network  = "${var.network_name}"
}

resource "google_compute_router_nat" "connext-amarok-nat" {
  depends_on         = [
    google_compute_router.connext-amarok-cloudnat-router
  ]

  name                               = "${var.cloudnat_name}-${var.region}"

  region                             = "${var.region}"
  router                             = "${var.cloudnat_name}-router-${var.region}"
  min_ports_per_vm                   = 4000
  nat_ip_allocate_option             = "AUTO_ONLY"

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

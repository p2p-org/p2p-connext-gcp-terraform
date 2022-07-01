resource "google_compute_subnetwork" "connext-amarok-subnetwork" {
  count         = var.subnetwork == "" ? 0 : 1
  name          = "${var.router_name}-subnetwork"
  ip_cidr_range = var.subnetwork
  region        = var.region
  network       = google_compute_network.connext-amarok-vpc-network.id
}

resource "google_compute_network" "connext-amarok-vpc-network" {
  name                    = var.network_name
  auto_create_subnetworks = var.subnetwork == "" ? true : false
}

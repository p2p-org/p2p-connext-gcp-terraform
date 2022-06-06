resource "google_compute_network" "connext-amarok-vpc-network" {
  name                    = "${var.network_name}"
}

resource "google_compute_disk" "connext-amarok-redis-extended-disk" {
  name               = "connext-amarok-redis-disk-1"
  type               = "${var.redis_instance.extended_disk_type}"
  zone               = "${var.region}-${var.redis_instance.availability_zone_name}"
  size               = "${var.redis_instance.extended_disk_size}"
}

resource "google_compute_attached_disk" "connext-amarok-redis-attached-disk" {
  depends_on = [
                 google_compute_disk.connext-amarok-redis-extended-disk,
                 google_compute_instance.connext-amarok-redis-instance
               ]
  device_name        = "connext-amarok-redis-disk-1"
  disk               = google_compute_disk.connext-amarok-redis-extended-disk.id
  instance           = "connext-amarok-redis"
  zone               = "${var.region}-${var.redis_instance.availability_zone_name}"
}

resource "google_compute_instance" "connext-amarok-redis-instance" {
  depends_on = [
                 google_compute_firewall.connext-amarok-firewall-basic,
                 google_compute_firewall.connext-amarok-firewall-router,
                 google_compute_firewall.connext-amarok-firewall-web3signer,
                 google_compute_firewall.connext-amarok-firewall-sharezone,
               ]

  name         = "connext-amarok-redis"
  machine_type = "${var.redis_instance.machine_type}"
  zone         = "${var.region}-${var.redis_instance.availability_zone_name}"

  tags         = ["redis"]

  boot_disk {
    initialize_params {
      image = "${var.redis_instance.image_type}"
      type  = "${var.redis_instance.disk_type}"
      size  = "${var.redis_instance.disk_size}"
    }
  }

  network_interface {
    network    = "${var.network_name}"
  }

  allow_stopping_for_update = true

  metadata = {
    "ssh-keys" = "${var.ssh_keys}"
  }

  metadata_startup_script = "mkdir /redis-data"

  lifecycle {
    ignore_changes = [attached_disk]
  }
}

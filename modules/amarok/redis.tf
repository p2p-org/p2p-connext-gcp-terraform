resource "google_redis_instance" "cache" {
  name                    = var.redis.name
  display_name            = var.redis.name
  tier                    = var.redis.tier
  memory_size_gb          = var.redis.memory_size_gb
  redis_version           = var.redis.redis_version
  location_id             = "${var.region}-${var.redis.primary_az}"
  alternative_location_id = "${var.region}-${var.redis.secondary_az}"

  authorized_network = data.google_compute_network.redis-network.id
}

data "google_compute_network" "redis-network" {
  name = var.network_name
}

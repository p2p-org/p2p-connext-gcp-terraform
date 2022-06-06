project_name = "connext-testnet-amarok"
region = "europe-west3"
network_name = "amarok"
cloudnat_name = "amarok"
source_ranges = ["0.0.0.0/0"]

router_instance = {
    availability_zone_name = "a"
    machine_type           = "c2-standard-4"
    disk_size              = "20"
    disk_type              = "pd-ssd"
    image_type             = "ubuntu-os-cloud/ubuntu-2004-lts"
}

redis_instance = {
    availability_zone_name = "a"
    machine_type           = "c2-standard-4"
    disk_size              = "20"
    disk_type              = "pd-ssd"
    image_type             = "ubuntu-os-cloud/ubuntu-2004-lts"
    extended_disk_size     = "50"
    extended_disk_type     = "pd-ssd"
}

sharezone_instance = {
    availability_zone_name = "a"
    machine_type           = "c2-standard-4"
    disk_size              = "20"
    disk_type              = "pd-ssd"
    image_type             = "ubuntu-os-cloud/ubuntu-2004-lts"
}

web3signer_instance = {
    availability_zone_name = "a"
    machine_type           = "c2-standard-4"
    disk_size              = "30"
    disk_type              = "pd-ssd"
    image_type             = "ubuntu-os-cloud/ubuntu-2004-lts"
}

# Architecture

![plot](docs/pics/arch.jpg)

All instances except `bastion` will be in the private network. You can use `bastion` instance like bastion host.

Don't use `ForwardAgent=yes` for accessing bastion host instead use it as [jump-box](http://www.linux-magazine.com/Online/Features/Jump-Box-Security) `-J` flag for ssh.

You can see all firewall rules [here](modules/amarok/firewall.tf)

---

# Basic info

Using this repo you can create infrastructure for the [connext router](https://connextscan.io) in the [GCP](https://cloud.google.com/gcp)

Currently only for `amarok testnet`

This is a simple terraform configs, for full description of each entity you can check [this](./modules/amarok/README.md)

---

# Basic setup

- Create a `GCP` project.

- Get `Service Account` key in `json` format. You can read about `Service Accounts` [here](https://cloud.google.com/iam/docs/creating-managing-service-account-keys). The best way to store `Service Account` key is to use [encfs](https://github.com/vgough/encfs) or [LUKS](https://www.redhat.com/sysadmin/disk-encryption-luks) encrypted volume.

- Export your `Service Account` key like this:

  `export GOOGLE_APPLICATION_CREDENTIALS=/super-encrypted-volume/project-name-some-hash.json`

- Create `bucket` with name like `connext-amarok-testnet-state-bucket`. This name must be globally unique. You can use [this](https://cloud.google.com/storage/docs/creating-buckets) guide for creating buckets. **Check that bucket is private**

- Update `backend.tf` with your bucket name

- Copy [terraform-secrets.auto.tfvars.example](./terraform-secrets.auto.tfvars.example) to `terraform-secrets.auto.tfvars`, [main.tf.example](./main.tf.example) to `main.tf` and [ssh-keys.tf.example](./ssh-keys.tf.example) to `ssh-keys.tf`

  `cp terraform-secrets.auto.tfvars.example terraform-secrets.auto.tfvars ; cp main.tf.example main.tf ; cp ssh-keys.tf.example ssh-keys.tf`

- Now you need to change values in `terraform-secrets.auto.tfvars` depending on your setup:

  **Requried**

  `project_name`  - should contain yours project name in `GCP`. More info [can be found here](https://cloud.google.com/resource-manager/docs/creating-managing-projects)

  `region`        - region for your project. More info [can be found here](https://cloud.google.com/compute/docs/regions-zones)

  **Optional**

  `network_name`  - name for the network where all instances will be. More info [can be found here](https://cloud.google.com/vpc/docs/vpc)

  `subnetwork`    - CIDR range for subnetwork. Useful if you have multiple routers. If omitted GCP would use global network subnetwork based on region

  `static_ip`     - assign static IP to bastion host. First it [must be reserved here](https://console.cloud.google.com/networking/addresses/list). If not specified, GCP would assign ephemeral external IP address with the same price

  `cloudnat_name` - name for `cloud-nat`. More info [can be found here](https://cloud.google.com/nat/docs/overview)

  `source_ranges` - whitelisted ips which can access `bastion` instances

  `use_gcp_memstore` - use GCP Memorystore for Redis or not. Disabled by default. If enabled, uncomment output section in `outputs.tf`

  `use_monitoring_instance` - create additional monitoring instance. Disabled by default. If enabled, uncomment output section in `outputs.tf`

  `availability_zone_name` - use only zone prefixes, like `a`, `b` or `c` More info [can be found here](https://cloud.google.com/compute/docs/regions-zones)

  `machine_type`           - machine type, you can test different setups to decide which one is better in terms of price and performance. More info [can be found here](https://cloud.google.com/compute/docs/machine-types)

  `disk_size`              - root disk size

  `disk_type`              - root disk type, you can also test different setups to decide which one is better in terms of price and performance

  `image_type`             - boot image. More info [can be found here](https://cloud.google.com/compute/docs/images)

  **Optional (GCP Memorystore Redis)**

  Redis can be hosted locally or using GCP Memorystore. GCP Memorystore Redis is disabled by default. To enable it set `use_gcp_memstore` to true

  `name`                   - Redis cluster name

  `tier`                   - HA/non-HA setup. Possible values are `STANDARD_HA` and `BASIC`

  `primary_az`             - AZ for primary Redis node

  `secondary_az`           - AZ for secondary Redis node

  `redis_version`          - Redis engine version e.g. `REDIS_6_X`

  `memory_size_gb`         - Redis memory size in GB. Can be whole number only.

- Add your SSH keys to`ssh-keys.tf` . These SSH keys will be used for accessing instances via ssh.

  ```
  variable "ssh_keys" {
    default = <<EOT
  user_name:ssh-ed25519 user_public_key info_about_key
  user_name_2:ssh-ed25519 user_public_key info_about_key
  EOT
  }
  ```

- Enable GCP hosted Redis usage [here](https://console.developers.google.com/apis/api/redis.googleapis.com/overview)

- Init terraform

  `terraform init`

- Apply terraform

  `terraform apply`

- All ip address for instances will be in the terraform output

- For Destroying infra you can use

  `terraform destroy`

# Monitoring

  You can use either [GCP Cloud Monitoring](https://cloud.google.com/monitoring/monitor-compute-engine-virtual-machine) or configure your own monitoring system e.g. using Grafana/Prometheus using separate monitoring instance.

  *Monitoring using Grafana/Prometheus*

  First you need to ensure `use_monitoring_instance` is set to `true`, it's `false` by default. Then reapply terraform changes.

  Once monitoring instance is up, install Grafana/Prometheus to it. In firewall rules ports 3000/tcp and 9999/tcp are open for Grafana/Prometheus from bastion instance. All instances have port 9090/tcp open and accessible from monitoring instance. Use SSH port-forwarding from bastion to access Grafana/Prometheus GUI. The following command would create a secured tunnel from localhost:3000 to monitoring_instance:3000, so Grafana can be accessed as `http://localhost:3000`:

  `ssh bastion_instance -L 3000:monitoring_instance:3000`


## GCP prices

[Here](https://cloudpricingcalculator.appspot.com) you can get price for you `GCP` infra.

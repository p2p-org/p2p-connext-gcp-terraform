# Architecture

![plot](docs/pics/arch.jpg)

All instances except `share-zone` will be in the private network. You can use `share-zone` instance like bastion host. Don't use `ForwardAgent=yes` for accessing bastion host instead use it as [jump-box](http://www.linux-magazine.com/Online/Features/Jump-Box-Security) `-J` flag for ssh.

You can see all firewall rules [here](modules/amarok/firewall.tf)

---

# Basic info

Using this repo you can create infractructe for the [connext router](https://connextscan.io) in the [GCP](https://cloud.google.com/gcp)

Currenlty only for `amarok testnet`

This is a simple terraform configs, for full description of each entity you can check [this](./modules/amarok/README.md)

---

# Basic setup

1. Create a `GCP` project.

2. Get `Service Account` key in `json` format. You can read about `Service Accounts` [here](https://cloud.google.com/iam/docs/creating-managing-service-account-keys). The best way to store `Service Account` key is to use [encfs](https://github.com/vgough/encfs) or [LUKS](https://www.redhat.com/sysadmin/disk-encryption-luks) encrypted volume.

3. Export your `Service Account` key like this:

  `export GOOGLE_APPLICATION_CREDENTIALS=/super-encrypted-volume/project-name-some-hash.json`

4. Create `bucket` with name `state-backet`. You can use [this](https://cloud.google.com/storage/docs/creating-buckets) guide for creating buckets. **Don't forget to make bucket private**

5. Now you need to change values in [amarok.tfvars](./amarok.tfvars) depending on your setup:

  **Requried**

  `project_name`  - should contain yours project name in `GCP`. More info [here](https://cloud.google.com/resource-manager/docs/creating-managing-projects)

  `region`        - region for your project. More info [here](https://cloud.google.com/compute/docs/regions-zones)

  **Optional**

  `network_name`  - name for the network where all instances will be. More info [here](https://cloud.google.com/vpc/docs/vpc)

  `cloudnat_name` - name for `cloud-nat`. More info [here](https://cloud.google.com/nat/docs/overview)

  `source_ranges` - whitelisted ips which can access `share-zone` instances.

  `availability_zone_name` - use only region prefixes, like `a`, `b` or `c` More info [here](https://cloud.google.com/compute/docs/regions-zones)

  `machine_type`           - machine type, you can test different setups to decide which one is better in terms of price and perfomance. More info [here](https://cloud.google.com/compute/docs/machine-types)

  `disk_size`              - root disk size.

  `disk_type`              - root disk type, you can also test different setups to decide which one is better in terms of price and perfomance.

  `image_type`             - boot image. More info [here](https://cloud.google.com/compute/docs/images)

  **Optional(Redis only)**

  `extended_disk_size`     - size of extended disk for `redis` instance. **Don't forget to mannualy mount this disk!**

  `extended_disk_type`     - type of extended disk for `redis` instance

6. Add your `ssh-keys` [here](./ssh-keys.tf). This ssh-keys will be used for accessing instances via ssh.

  ```
  variable "ssh_keys" {
    default = <<EOT
  user_name:ssh-ed25519 user_public_key info_about_key
  user_name_2:ssh-ed25519 user_public_key info_about_key
  EOT
  }
  ```

7. Init terraform

  `terraform init`

8. Apply terraform

  `terraform apply -var-file=amarok.tfvars`

9. All ip address for instances will be in the terraform output

10. For Destroying infra you can use

  `terraform destroy -var-file=amarok.tfvars`

## GCP prices

[Here](https://cloudpricingcalculator.appspot.com) you can get price for you `GCP` infra.


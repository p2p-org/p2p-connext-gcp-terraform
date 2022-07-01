output "main-bastion-instance-info" {
  value = module.amarok-r1.bastion-instance-info
}

output "main-web3signer-instance-info" {
  value = module.amarok-r1.web3signer-instance-info
}

# Uncomment this if you want to use GCP Memorystore Redis
# output "main-redis-info" {
#   value = module.amarok-r1.redis-info
# }

output "main-router-instance-info" {
  value = module.amarok-r1.router-instance-info
}

# Uncomment this if you want to use custom secondary router
# output "custom-bastion-instance-info" {
#   value = module.amarok-r1.bastion-instance-info
# }
#
# output "custom-web3signer-instance-info" {
#   value = module.amarok-r1.web3signer-instance-info
# }
#
# output "custom-redis-info" {
#   value = module.amarok-r1.redis-info
# }
#
# output "custom-router-instance-info" {
#   value = module.amarok-r1.router-instance-info
# }

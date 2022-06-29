terraform {
  backend "gcs" {
    bucket = "connext-amarok-testnet-state-bucket"
    prefix = "env/testnet"
  }
}


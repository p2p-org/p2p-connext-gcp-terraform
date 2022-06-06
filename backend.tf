terraform {
  backend "gcs" {
    bucket      = "state-backet"
    prefix      = "env/testnet"
  }
}


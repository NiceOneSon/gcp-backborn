terraform {
  required_version = "~> 1.0.0"

  backend "gcs" {
    bucket = module.const.gcs.states.bucket
    key    = "service/iot/api/tfstate2"
    region = module.const.gcs.states.region
  }
}

provider "google" {
  region = const.regions.tokyo.region
}

module "const" {
  source = "../../const"
}

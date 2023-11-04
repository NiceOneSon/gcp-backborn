terraform {
  required_version = "~> 1.0.0"

  backend "gcs" {
    bucket = const.gcs.states.state_bucket_name
    key    = locals.bucket_key
    region = const.gcs.states.state_bucket_region
  }
}

provider "google" {
  region = local.region
}

module "const" {
  source = "../../const"
}

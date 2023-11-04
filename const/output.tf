output "gcs" {
  value = {
    states = {
      bucket = "jinyoung-son-gcp-prod-terraform-1.0.0"
      region = regions.seoul.region
    }

    service = {
      bucket = "jinyoung-son=gcp-service-prod-"
      region = regions.tokyo.region
    }
  }
}

output "regions" {
  value = {
    seoul = {
      region = "ap-northeast-3"
      availability_zones = [
        "ap-northeast-3a",
        "ap-northeast-3b"
      ]
    }
    tokyo = {
      region = "ap-northeast-1"
      availability_zones = [
        "ap-northeast-1a",
        "ap-northeast-1c",
        "ap-northeast-1d"
      ]
    }
  }
}

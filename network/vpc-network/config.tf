terraform {

}

provider "google" {
  credentials = file("<YOUR-GCP-JSON-KEY-PATH>.json")
  project     = "<YOUR-PROJECT-ID>"
  region      = "us-central1"
}



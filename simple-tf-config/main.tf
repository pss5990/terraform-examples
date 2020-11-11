terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}


provider "google" {
  version = "3.5.0"

  credentials = file("../../keys/loans-project-editor-sa.json")

  project = "loans-278211"
  region  = "europe-west2"
  zone    = "europe-west2-a"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  version     = "3.5.0"
  credentials = file("../../keys/loans-project-editor-sa.json")
  project     = var.project_id
  region      = var.project_default_region
  zone        = var.project_default_zone
}

locals {
  vm_network_tags = ["abc", "xyz"]
  vm_labels = {
    "creator" = join("-", ["jot", "singh", "123"])
    "work"    = "practice"
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnetwork_us" {
  name          = var.vpc_subnetwork_us["name"]
  region        = var.vpc_subnetwork_us["region"]
  ip_cidr_range = var.vpc_subnetwork_us["cidr_range"]
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "vpc_subnetwork_eu" {
  name          = var.vpc_subnetwork_eu["name"]
  region        = var.vpc_subnetwork_eu["region"]
  ip_cidr_range = var.vpc_subnetwork_eu["cidr_range"]
  network       = google_compute_network.vpc_network.id
}

data "google_compute_image" "debian_image" {
  family  = "debian-9"
  project = "debian-cloud"
}

resource "google_compute_instance" "instance_with_ip" {
  count        = 2
  name         = "vm-${count.index}"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = data.google_compute_image.debian_image.self_link
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.vpc_subnetwork_us.name
  }
  tags   = local.vm_network_tags
  labels = local.vm_labels
}

resource "google_compute_instance" "conditional_size_instance_micro" {
  count        = var.isDevEnv == true ? 1 : 0
  name         = "vm-conditional-micro"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = data.google_compute_image.debian_image.self_link
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.vpc_subnetwork_us.name
  }
}

resource "google_compute_instance" "conditional_size_instance_medium" {
  count        = var.isDevEnv == false ? 1 : 0
  name         = "vm-conditional-medium"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = data.google_compute_image.debian_image.self_link
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.vpc_subnetwork_us.name
  }
}



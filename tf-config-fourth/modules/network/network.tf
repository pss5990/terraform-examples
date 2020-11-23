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

output "vpc_subnetwork_us_name"{
  value = google_compute_subnetwork.vpc_subnetwork_us.name
}

output "vpc_subnetwork_eu_name"{
  value = google_compute_subnetwork.vpc_subnetwork_eu.name
}
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

resource "google_compute_instance" "vm-loop" {
  count        = 2
  name         = "tf-vm-${count.index}"
  machine_type = "f1-micro"
  zone         = "us-central1-a"


  // TODO: Add an example of dynamic block

  boot_disk {
    initialize_params {
      image = data.google_compute_image.debian_image.self_link
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.vpc_subnetwork_us.name
    access_config {
    }
  }

  provisioner "local-exec" {
    command = "echo '..............Local exec provisioner 1.ServerIP address is ->${self.network_interface.0.network_ip}..............'"
  }

  provisioner "local-exec" {
    on_failure = continue
    command    = "echo '..............Local exec provisioner 2..............'"
  }

  provisioner "local-exec" {
    when       = destroy
    on_failure = continue
    command    = "echo '..............Destroyed resource..............'"
  }

/* TODO add a remote exec provisioner to install nginx on the newly created machines. ALthough should be done using 
metadata scripts for compute engine or using Packer to create cusotm machine images. 
*/

/*
  provisioner "remote-exec" {
    inline = [

    ]
  }
*/
}

output "new_vm_details" {
  value = google_compute_instance.vm-loop[*].network_interface.0.access_config.0.nat_ip
}

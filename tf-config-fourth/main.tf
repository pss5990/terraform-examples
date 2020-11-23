module "network" {
  source = "./modules/network"
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

  boot_disk {
    initialize_params {
      image = data.google_compute_image.debian_image.self_link
    }
  }

  network_interface {
    subnetwork = module.network.vpc_subnetwork_us_name
    access_config {
    }
  }
}

output "new_vm_details" {
  value = google_compute_instance.vm-loop[*].network_interface.0.access_config.0.nat_ip
}
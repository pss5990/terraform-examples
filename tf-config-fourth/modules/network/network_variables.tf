variable "vpc_network_name" {
  default = "terraform_network"
}

variable vpc_subnetwork_us {
  type = map
  default = {
    name       = "subnet-1"
    region     = "us-central1"
    cidr_range = "10.128.0.0/20"
  }
}

variable vpc_subnetwork_eu {
  type = map
  default = {
    name       = "subnet-2"
    region     = "europe-west1"
    cidr_range = "10.132.0.0/20"
  }
}

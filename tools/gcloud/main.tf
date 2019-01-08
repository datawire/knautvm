provider "google" {
  region  = "${var.region}"
  project = "${var.project}"
}

locals {
  machine_name = "knautvm-${var.machine_name_suffix}"
}

data "google_compute_zones" "available" {
  region = "${var.region}"
}

data "google_compute_default_service_account" "default" {}

data "google_compute_image" "ubuntu" {
  project = "ubuntu-os-cloud"
  family = "minimal"
}

resource "google_compute_network" "this" {
  name = "${local.machine_name}"
  auto_create_subnetworks = true
}

resource "google_compute_firewall" "ingress" {
  name = "${local.machine_name}"
  network = "${google_compute_network.this.name}"
  direction = "INGRESS"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = [
      "22",         # SSH
      "6443",       # Kubernetes API server
      "30000-32767" # Kubernetes NodePorts
    ]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "egress" {
  name = "${local.machine_name}"
  network = "${google_compute_network.this.name}"
  direction = "INGRESS"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = ["22", "6443", "30000-32767"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "this" {
  name = "${local.machine_name}"
  machine_type = "${var.machine_type}"
  min_cpu_platform = "Intel Skylake"
  zone = "${data.google_compute_zones.available.names[0]}"

  scheduling {
    automatic_restart = false
    on_host_maintenance = "TERMINATE"
    preemptible = "${var.preemptible}"
  }

  boot_disk {
    initialize_params {
      image = "${data.google_compute_image.ubuntu.self_link}"
    }
  }

  scratch_disk {}

  metadata {
    "ssh-keys" = "${var.ssh_user}:${file(var.ssh_public_key_file)}"
  }

  network_interface {
    network = "${google_compute_network.this.self_link}"
    access_config {}
  }
}

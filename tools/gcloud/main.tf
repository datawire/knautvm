provider "google" {
  region  = "${var.region}"
}

data "google_project" "current" {}

data "google_compute_default_service_account" "default" {}

resource "google_compute_network" "this" {
  name = "net-${var.machine_name}"
  auto_create_subnetworks = true
}

resource "google_compute_instance" "this" {
  name = "${var.machine_name}"
  machine_type = "${var.machine_type}"

  scheduling {
    automatic_restart = false
    on_host_maintenance = "TERMINATE"
    preemptible = "${var.preemptible}"
  }

  boot_disk {
    initialize_params {
      image = "${var.machine_image}"
    }
  }

  scratch_disk {}

  network_interface {
    network = "${google_compute_network.this.self_link}"
    access_config {}
  }
}
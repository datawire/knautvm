output "machine_id" {
  value = "${google_compute_instance.this.instance_id}"
}

output "machine_public_ip" {
  value = "${google_compute_instance.this.network_interface.0.access_config.0.nat_ip}"
}

output "zone" {
  value = "${google_compute_instance.this.zone}"
}

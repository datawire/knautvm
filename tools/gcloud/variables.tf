variable "region" {
  description = "Cloud region where the machine is located"
  default = "us-central1"
}

variable "project" {
  default = "datawireio"
}

variable "machine_type" {
  description = "ID of the machine's hardware type"
  default     = "n1-standard-2"
}

variable "machine_image" {
  description = "ID of the machine's boot disk image"
  default = "ubuntu-os-cloud/ubuntu-minimal-1804-lts"
}

variable "machine_name_suffix" {
  description = "Suffix appended after 'knautvm-' which becomes the machine name."
}

variable "preemptible" {
  description = "Configure whether the machine is preemptible or not"
  default = true
}

variable "ssh_user" {
  description = "Name of the user that can SSH"
  default = "dev"
}

variable "ssh_public_key_file" {
  description = "Path to the SSH public key"
}

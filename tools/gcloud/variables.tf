variable "region" {
  description = "Cloud region where the machine is located"
  default = "us-central1"
}

variable "machine_name" {
  description = "Name of the machine"
}

variable "machine_type" {
  description = "ID of the machine's hardware type"
}

variable "machine_image" {
  description = "ID of the machine's boot disk image"
}

variable "preemptible" {
  description = "Controls whether the machine is preemptible or not"
  default = true
}
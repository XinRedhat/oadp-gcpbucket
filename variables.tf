variable "bucket" {
    type = string
    description = "GCP storage bucket name"
}

variable "region" {
    type = string
    description = "GCP region where the resources will be created"
    default = "us-west1"
}

variable "project" {
  type = string
  description = "The ID of the project in which the resource belongs."
}


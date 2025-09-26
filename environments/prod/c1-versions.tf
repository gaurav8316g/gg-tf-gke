# Terraform Settings Block
terraform {
  required_version = ">= 1.13"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "7.4.0"
    }
  }
  backend "gcs" {
    bucket = "gg-terraform-2025"
    prefix = "prod/gke-cluster"    
  }
}

# Terraform Provider Block
provider "google" {
  project = var.gcp_project
  region = var.gcp_region
}
terraform {
  cloud {
    organization = "example-org-66a6a0"

    workspaces {
      name = "Suresh-cli"
    }
  }
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}

variable "key_name" {
  default = "terraformtest"
}
variable "aws_access_key" {}
variable "aws_secret_key" {}
#variable "private_key_path" {}
variable "region" {}
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.example.public_key_openssh
}

output "private_key" {
  value     = tls_private_key.example.private_key_pem
  sensitive = true
}


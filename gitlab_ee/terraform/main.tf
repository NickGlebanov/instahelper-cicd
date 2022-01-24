terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.7.0"
    }
  }
}

variable "cloudflare_api_token" {
  type = string
}

variable "email" {
  type = string
}

variable "cloudflare_zone_id" {
  type = string
}

variable "cicd_server_ip" {
  type = string
}

provider "cloudflare" {
  email     = var.email
  api_token = var.cloudflare_api_token
}

resource "cloudflare_record" "ci" {
  name    = "ci"
  value   = var.cicd_server_ip
  type    = "A"
  proxied = true
  zone_id = var.cloudflare_zone_id
}
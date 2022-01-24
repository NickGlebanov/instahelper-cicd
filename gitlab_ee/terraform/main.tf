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

variable "domain" {
  type = string
}

variable "cloudflare_zone_id" {
  type = string
}
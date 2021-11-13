terraform {
  required_version = ">= 0.15"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">= 2.16.0"
    }
  }
}

provider "digitalocean" {

}

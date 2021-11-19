
module "mongodb_db" {
  source  = "mohsenSy/db/digitalocean"
  version = "0.2.1"

  name       = "mongodb_db"
  engine     = "mongodb"
  size       = "db-s-1vcpu-1gb"
  region     = "fra1"
  node_count = 1
  db_version = "4"

  users = ["mouhsen", "sami"]
}

output "host" {
  value = module.mongodb_db.host
}

output "passwords" {
  sensitive = true
  value     = module.mongodb_db.passwords
}

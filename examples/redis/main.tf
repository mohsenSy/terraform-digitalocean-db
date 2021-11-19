
module "redis_db" {
  source  = "mohsenSy/db/digitalocean"
  version = "0.2.1"

  name       = "redis_db"
  engine     = "redis"
  size       = "db-s-1vcpu-1gb"
  region     = "fra1"
  node_count = 1
  db_version = "6"

  users = ["mouhsen", "sami"]
}

output "host" {
  value = module.redis_db.host
}

output "passwords" {
  sensitive = true
  value     = module.redis_db.passwords
}


module "redis_db" {
  source  = "mohsenSy/db/digitalocean"
  version = "0.3.3"

  name       = "redis-db"
  engine     = "redis"
  size       = "db-s-1vcpu-1gb"
  region     = "fra1"
  node_count = 1
  db_version = "6"

}

output "host" {
  value = module.redis_db.host
}

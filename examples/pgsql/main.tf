
module "pg_db" {
  source  = "mohsenSy/db/digitalocean"
  version = "0.3.3"

  name       = "pg-db"
  engine     = "pg"
  size       = "db-s-1vcpu-1gb"
  region     = "fra1"
  node_count = 1
  db_version = "11"

  users     = ["mouhsen", "sami"]
  databases = ["users"]

  pools = [{
    name    = "pool1"
    size    = 20
    db_name = "defaultdb"
    user    = "doadmin"
    mode    = "transaction"
  }]
}

output "host" {
  value = module.pg_db.host
}

output "passwords" {
  sensitive = true
  value     = module.pg_db.passwords
}

output "pool_password" {
  sensitive = true
  value     = module.pg_db.pools[0].password
}

output "database" {
  value = module.pg_db.database
}

output "user" {
  value = module.pg_db.user
}

output "password" {
  sensitive = true
  value     = module.pg_db.password
}

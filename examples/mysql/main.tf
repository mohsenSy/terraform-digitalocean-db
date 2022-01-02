
module "sql_db" {
  source  = "mohsenSy/db/digitalocean"
  version = "0.3.1"

  name       = "sql-db"
  engine     = "mysql"
  size       = "db-s-1vcpu-1gb"
  region     = "fra1"
  node_count = 1
  db_version = "8"

  users     = ["mouhsen", "sami"]
  databases = ["users"]
}

output "host" {
  value = module.sql_db.host
}

output "passwords" {
  sensitive = true
  value     = module.sql_db.passwords
}

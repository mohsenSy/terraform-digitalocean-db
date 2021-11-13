
module "sql_db" {
  source = "github.com/mohsensy/terraform-digitalocean-db"

  name       = "sql_db"
  engine     = "mysql"
  size       = "db-s-1vcpu-1gb"
  region     = "fra1"
  node_count = 1
  db_version = "8"

  users = ["mouhsen", "sami"]
}

output "host" {
  value = module.sql_db.host
}

output "passwords" {
  sensitive = true
  value     = module.sql_db.passwords
}

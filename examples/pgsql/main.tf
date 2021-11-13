
module "pg_db" {
  source = "github.com/mohsensy/terraform-digitalocean-db"

  name       = "pg_db"
  engine     = "pg"
  size       = "db-s-1vcpu-1gb"
  region     = "fra1"
  node_count = 1
  db_version = "11"

  users = ["mouhsen", "sami"]
}

output "host" {
  value = module.pg_db.host
}

output "passwords" {
  sensitive = true
  value     = module.pg_db.passwords
}

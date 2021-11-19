# Terraform Digital Ocean Database

This terraform module can be used to manage different database services in Digital Ocean

Here is an example for its usage

```
module "pg_db" {
  source = "mohsenSy/db/digitalocean"
  version = "0.2.1"

  name       = "pg-db"
  engine     = "pg"
  size       = "db-s-1vcpu-1gb"
  region     = "fra1"
  node_count = 1
  db_version = "11"

  users = ["mouhsen", "sami"]

  pools = [{
    name = "pool1"
    size = 20
    db_name = "defaultdb"
    user = "doadmin"
    mode = "transaction"
  }]

  databases = ["db1"]
}
```

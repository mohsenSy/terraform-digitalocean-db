locals {
  config_default = yamldecode(file("./default.yaml"))
  config         = yamldecode(file("./data.yaml"))

  db_names = [for c in local.config.do_clusters : c.name]

  dbs    = [for d in local.config.do_clusters : merge(local.config_default, d)]
  do_dbs = zipmap(local.db_names, local.dbs)
}

module "dodbs" {
  source  = "mohsenSy/db/digitalocean"
  version = "0.3.1"

  for_each = local.do_dbs

  name       = each.value.name
  engine     = each.value.engine
  db_version = each.value.db_version
  node_count = each.value.node_count
  region     = each.value.region
  size       = each.value.size

  eviction_policy      = each.value.eviction_policy
  maintenance_window   = each.value.maintenance_window
  pools                = each.value.pools
  private_network_uuid = each.value.private_network_uuid
  replicas             = each.value.replicas
  users                = each.value.users
  sql_mode             = each.value.sql_mode
  tags                 = each.value.tags
  databases            = each.value.databases

}

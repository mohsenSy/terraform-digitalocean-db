locals {
    host = <<EOF
%{if var.engine == "mysql"}${digitalocean_database_cluster.do_sql[0].host}%{else}%{if var.engine == "redis"}${digitalocean_database_cluster.do_redis[0].host}%{else}%{if var.engine == "pg"}${digitalocean_database_cluster.do_pg[0].host}%{else}%{if var.engine == "mongodb"}${digitalocean_database_cluster.do_mongodb[0].host}%{endif}%{endif}%{endif}%{endif}
EOF

    private_host = <<EOF
%{if var.engine == "mysql"}${digitalocean_database_cluster.do_sql[0].private_host}%{else}%{if var.engine == "redis"}${digitalocean_database_cluster.do_redis[0].private_host}%{else}%{if var.engine == "pg"}${digitalocean_database_cluster.do_pg[0].private_host}%{else}%{if var.engine == "mongodb"}${digitalocean_database_cluster.do_mongodb[0].private_host}%{endif}%{endif}%{endif}%{endif}
EOF

    uri = <<EOF
%{if var.engine == "mysql"}${digitalocean_database_cluster.do_sql[0].uri}%{else}%{if var.engine == "redis"}${digitalocean_database_cluster.do_redis[0].uri}%{else}%{if var.engine == "pg"}${digitalocean_database_cluster.do_pg[0].uri}%{else}%{if var.engine == "mongodb"}${digitalocean_database_cluster.do_mongodb[0].uri}%{endif}%{endif}%{endif}%{endif}
EOF

    private_uri = <<EOF
%{if var.engine == "mysql"}${digitalocean_database_cluster.do_sql[0].private_uri}%{else}%{if var.engine == "redis"}${digitalocean_database_cluster.do_redis[0].private_uri}%{else}%{if var.engine == "pg"}${digitalocean_database_cluster.do_pg[0].private_uri}%{else}%{if var.engine == "mongodb"}${digitalocean_database_cluster.do_mongodb[0].private_uri}%{endif}%{endif}%{endif}%{endif}
EOF

    port = <<EOF
%{if var.engine == "mysql"}${digitalocean_database_cluster.do_sql[0].port}%{else}%{if var.engine == "redis"}${digitalocean_database_cluster.do_redis[0].port}%{else}%{if var.engine == "pg"}${digitalocean_database_cluster.do_pg[0].port}%{else}%{if var.engine == "mongodb"}${digitalocean_database_cluster.do_mongodb[0].port}%{endif}%{endif}%{endif}%{endif}
EOF

    id = <<EOF
%{if var.engine == "mysql"}${digitalocean_database_cluster.do_sql[0].id}%{else}%{if var.engine == "redis"}${digitalocean_database_cluster.do_redis[0].id}%{else}%{if var.engine == "pg"}${digitalocean_database_cluster.do_pg[0].id}%{else}%{if var.engine == "mongodb"}${digitalocean_database_cluster.do_mongodb[0].id}%{endif}%{endif}%{endif}%{endif}
EOF

    database = <<EOF
%{if var.engine == "mysql"}${digitalocean_database_cluster.do_sql[0].database}%{else}%{if var.engine == "redis"}${digitalocean_database_cluster.do_redis[0].database}%{else}%{if var.engine == "pg"}${digitalocean_database_cluster.do_pg[0].database}%{else}%{if var.engine == "mongodb"}${digitalocean_database_cluster.do_mongodb[0].database}%{endif}%{endif}%{endif}%{endif}
EOF

    user = <<EOF
%{if var.engine == "mysql"}${digitalocean_database_cluster.do_sql[0].user}%{else}%{if var.engine == "redis"}${digitalocean_database_cluster.do_redis[0].user}%{else}%{if var.engine == "pg"}${digitalocean_database_cluster.do_pg[0].user}%{else}%{if var.engine == "mongodb"}${digitalocean_database_cluster.do_mongodb[0].user}%{endif}%{endif}%{endif}%{endif}
EOF

    password = <<EOF
%{if var.engine == "mysql"}${digitalocean_database_cluster.do_sql[0].password}%{else}%{if var.engine == "redis"}${digitalocean_database_cluster.do_redis[0].password}%{else}%{if var.engine == "pg"}${digitalocean_database_cluster.do_pg[0].password}%{else}%{if var.engine == "mongodb"}${digitalocean_database_cluster.do_mongodb[0].password}%{endif}%{endif}%{endif}%{endif}
EOF


passwords = zipmap(var.users, concat(digitalocean_database_user.redis_users[*].password, digitalocean_database_user.mongodb_users[*].password, digitalocean_database_user.pg_users[*].password, digitalocean_database_user.sql_users[*].password))

}
resource "digitalocean_database_cluster" "do_sql" {

    count = var.engine == "mysql" ? 1 : 0

  name = var.name
  engine = var.engine
  size = var.size
  region = var.region
  node_count = var.node_count
  version = var.db_version
  tags = var.tags

  sql_mode = var.sql_mode
  maintenance_window {
      day = var.maintenance_window.day
      hour = var.maintenance_window.hour
  }
}

resource "digitalocean_database_cluster" "do_redis" {

    count = var.engine == "redis" ? 1 : 0

  name = var.name
  engine = var.engine
  size = var.size
  region = var.region
  node_count = var.node_count
  version = var.db_version

  eviction_policy = var.eviction_policy
  maintenance_window {
      day = var.maintenance_window.day
      hour = var.maintenance_window.hour
  }
}

resource "digitalocean_database_cluster" "do_pg" {

    count = var.engine == "pg" ? 1 : 0

  name = var.name
  engine = var.engine
  size = var.size
  region = var.region
  node_count = var.node_count
  version = var.db_version

  maintenance_window {
      day = var.maintenance_window.day
      hour = var.maintenance_window.hour
  }
}

resource "digitalocean_database_cluster" "do_mongodb" {

    count = var.engine == "mongodb" ? 1 : 0

  name = var.name
  engine = var.engine
  size = var.size
  region = var.region
  node_count = var.node_count
  version = var.db_version

  maintenance_window {
      day = var.maintenance_window.day
      hour = var.maintenance_window.hour
  }
}

resource "digitalocean_database_firewall" "sql_firewall" {
    count = var.engine == "mysql" && length(var.firewall_rules) > 0 ? 1 : 0
    cluster_id = digitalocean_database_cluster.do_sql[0].id

    dynamic "rule" {
        for_each = var.firewall_rules
        content {
            type = rule.value.type
            value = rule.value.value
        }
    }

}

resource "digitalocean_database_firewall" "redis_firewall" {
    count = var.engine == "redis" && length(var.firewall_rules) > 0 ? 1 : 0
    cluster_id = digitalocean_database_cluster.do_redis[0].id

    dynamic "rule" {
        for_each = var.firewall_rules
        content {
            type = rule.value.type
            value = rule.value.value
        }
    }

}

resource "digitalocean_database_firewall" "pg_firewall" {
    count = var.engine == "pg" && length(var.firewall_rules) > 0 ? 1 : 0
    cluster_id = digitalocean_database_cluster.do_pg[0].id

    dynamic "rule" {
        for_each = var.firewall_rules
        content {
            type = rule.value.type
            value = rule.value.value
        }
    }

}

resource "digitalocean_database_firewall" "mongodb_firewall" {
    count = var.engine == "mongodb" && length(var.firewall_rules) > 0 ? 1 : 0
    cluster_id = digitalocean_database_cluster.do_mongodb[0].id

    dynamic "rule" {
        for_each = var.firewall_rules
        content {
            type = rule.value.type
            value = rule.value.value
        }
    }
}

resource "digitalocean_database_user" "sql_users" {
    count = var.engine == "mysql" ? length(var.users) : 0

    cluster_id = digitalocean_database_cluster.do_sql[0].id

    name = var.users[count.index]
}

resource "digitalocean_database_user" "redis_users" {
    count = var.engine == "redis" ? length(var.users) : 0

    cluster_id = digitalocean_database_cluster.do_redis[0].id
    name = var.users[count.index]
}

resource "digitalocean_database_user" "pg_users" {
    count = var.engine == "pg" ? length(var.users) : 0

    cluster_id = digitalocean_database_cluster.do_pg[0].id
    name = var.users[count.index]
}

resource "digitalocean_database_user" "mongodb_users" {
    count = var.engine == "mongodb" ? length(var.users) : 0

    cluster_id = digitalocean_database_cluster.do_mongodb[0].id
    name = var.users[count.index]
}

resource "digitalocean_database_replica" "pg_replicas" {

    count = var.engine == "pg" ? length(var.replicas) : 0

    cluster_id = digitalocean_database_cluster.do_pg[0].id

    name = var.replicas[count.index].name
    size = lookup(var.replicas[count.index], "size", var.size)
    region = lookup(var.replicas[count.index], "region", var.region)
    tags = lookup(var.replicas[count.index], "tags", [])
    private_network_uuid = lookup(var.replicas[count.index], "private_network_uuid", "")
}

resource "digitalocean_database_connection_pool" "pg_pools" {
    count = var.engine == "pg" ? length(var.pools) : 0

    cluster_id = digitalocean_database_cluster.do_pg[0].id

    name = var.pools[count.index].name
    mode = var.pools[count.index].mode
    size = var.pools[count.index].size
    db_name = var.pools[count.index].db_name
    user = var.pools[count.index].user

}

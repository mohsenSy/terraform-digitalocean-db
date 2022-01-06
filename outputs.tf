output "host" {
  description = "The public hostname for the database cluster"
  value       = chomp(local.host)
}

output "uri" {
  description = "The public URI used to connect to the cluster"
  value       = chomp(local.uri)
}

output "private_host" {
  description = "The private hostname for the database cluster"
  value       = chomp(local.private_host)
}

output "private_uri" {
  description = "The private URI used to connect to the cluster"
  value       = chomp(local.private_uri)
}

output "port" {
  description = "The port used to connect to the cluster"
  value       = chomp(local.port)
}

output "id" {
  description = "The cluster's ID"
  value       = chomp(local.id)
}

output "database" {
  description = "the cluster's default database"
  value       = chomp(local.database)
}

output "user" {
  description = "The cluster's default user"
  value       = chomp(local.user)
}

output "password" {
  description = "The cluster's default user password"
  sensitive   = true
  value       = chomp(local.password)
}

output "passwords" {
  description = "The generated passords for the created users as a key/value object"
  sensitive   = true
  value       = local.passwords
}

output "replicas" {
  description = "A list of created replia objects"
  value       = digitalocean_database_replica.pg_replicas
}

output "pools" {
  description = "A list of created connetcion pool objects"
  value       = digitalocean_database_connection_pool.pg_pools
}

output "additional_databases" {
  description = "A list of additional databases created in the database cluster"
  value       = concat(digitalocean_database_db.mongodb_dbs[*].name, digitalocean_database_db.pg_dbs[*].name, digitalocean_database_db.sql_dbs[*].name)
}

output "private_network_uuid" {
  description = "The ID of the VPC where the database cluster will be located"
  value       = concat(digitalocean_database_cluster.do_redis[*].private_network_uuid, digitalocean_database_cluster.do_mongodb[*].private_network_uuid, digitalocean_database_cluster.do_pg[*].private_network_uuid, digitalocean_database_cluster.do_sql[*].private_network_uuid)
}
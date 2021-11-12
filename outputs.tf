output "host" {
  value = local.host
}

output "uri" {
  value = local.uri
}

output "private_host" {
  value = local.private_host
}

output "private_uri" {
  value = local.private_uri
}

output "port" {
  value = local.port
}

output "id" {
  value = local.id
}

output "database" {
  value = local.database
}

output "user" {
  value = local.user
}

output "password" {
  value = local.password
}

output "passwords" {
  sensitive = true
  value = local.passwords
}

output "replicas" {
  value = digitalocean_database_replica.pg_replicas
}

output "pools" {
  value = digitalocean_database_connection_pool.pg_pools
}

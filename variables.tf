variable "name" {
  description = "The name of the database cluster"
}

variable "engine" {
  description = "The type of database cluster"
}

variable "size" {
  description = "The database cluster size"
}

variable "region" {
  description = "The region of the database cluster"
}

variable "node_count" {
  description = "Number of nodes in the database cluster"
}

variable "db_version" {
  description = "Engine version used by the cluster"
}


variable "tags" {
  description = "The tags to be applied to the cluster"
  default     = []
}

variable "private_network_uuid" {
  description = "The UUID of the network to be connected to the cluster"
  default     = null
}

variable "eviction_policy" {
  description = "A string specifying the eviction policy for a Redis cluster"
  default     = "allkeys_lru"
}

variable "sql_mode" {
  description = " A comma separated string specifying the SQL modes for a MySQL cluster"
  default     = "ANSI,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION,NO_ZERO_DATE,NO_ZERO_IN_DATE,STRICT_ALL_TABLES"
}

variable "maintenance_window" {
  description = "Defines when the automatic maintenance should be performed for the database cluster."
  type = object({
    day  = string
    hour = string
  })
  default = {
    day  = "tuesday"
    hour = "01:00:00"
  }
}

variable "firewall_rules" {
  description = "The firewall rules applied for the cluster"
  default     = []
}

variable "users" {
  description = "A list of database users to create"
  default     = []
}

variable "replicas" {
  description = "Database read replicas"
  default     = []
}

variable "pools" {
  description = "Database connection pools"
  default     = []
}

# Create database clusters from a config file

This example shows how we can use simple yaml configuration files to define the database clusters that we want to create
the locals section reads the yaml files and forms an object whose keys are the names of these clusters
and its values are the configurations for each cluster, we don't need to specify all configs in the configuration
file because each cluster is merged with a default config file that contains values for all default keys.

This is an example config file:

```
do_clusters:
  - engine: mongodb
    name: mongo-db
    size: db-s-1vcpu-1gb
    region: fra1
    node_count: 1
    db_version: 4
    users:
      - mouhsen
      - sami
      - nodar
    tags:
      - backend
      - germany
```

This config file defines a single database cluster of the mongodb engine, it has 3 users and two tags, here we find values for
all the required attributes.

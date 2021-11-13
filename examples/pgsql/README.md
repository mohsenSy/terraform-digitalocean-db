# postgress cluster

This small example shows how to create a postgress database cluster in Digital Ocean, we are creating two users
and a connection pool and we defined three outputs, the first is called `host` whch holds the hostname for the cluster an
the other is called `passwords` which is a tuple of passwords assigned to the two users we are creating and the third
is called `pools` and contains the database password for the pool's user.

You can easily apply this configurtaion with these commands:

```
terraform init
terraform apply
```

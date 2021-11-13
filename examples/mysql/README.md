# MySQL cluster

This small example shows how to create a mysql database cluster in Digital Ocean, we are creating two users
and we defined two outputs, the first is called `host` whch holds the hostname for the cluster and
the other is called `passwords` which is a tuple of passwords assigned to the two users we are creating.

You can easily apply this configurtaion with these commands:

```
terraform init
terraform apply
```

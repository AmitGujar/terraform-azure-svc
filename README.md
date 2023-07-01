# Terraform Template

This is a starter template for your terraform projects which uses Azure as a provider.

You can add your resources in modules and make changes accordingly.

This template also contains azure blob for the backend. You need to configure that manually.

### Initialize terraform

```
terraform init -upgrade
```

### Make a plan

```
terraform plan -out main.tfplan
```

### Apply changes

```
terraform apply.
```

### Execute connect.ps1 file to get access of jumpbox vm.


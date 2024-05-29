#!/bin/bash
terraform init
terraform plan -out main.tfplan -var-file=secret.tfvars
terraform apply main.tfplan

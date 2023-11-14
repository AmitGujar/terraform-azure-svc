#!/bin/bash
cd $HOME/Desktop/terraform-boilerplate || exit

vm_connect() {

    publicip=$(terraform output -raw public_ip_address)

    hostname=$(echo "$publicip" | tr -d '"')

    ssh -o StrictHostKeyChecking=no amitgujar@$hostname

}
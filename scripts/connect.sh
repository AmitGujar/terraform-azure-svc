#!/bin/bash
cd $HOME/Desktop/terraform-boilerplate || exit

vm_connect() {

    terraform output -raw tls_private_key >>id_rsa

    sudo chmod 600 id_rsa

    publicip=$(terraform output -raw public_ip_address)

    hostname=$(echo "$publicip" | tr -d '"')

    ssh -o StrictHostKeyChecking=no -i id_rsa amitgujar@$hostname

}

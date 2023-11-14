#!/bin/bash
path=$HOME/Desktop/terraform-boilerplate/scripts

source $path/progress_bar.sh || exit 1
source $path/alert.sh
source $path/connect.sh

cd $HOME/Desktop/terraform-boilerplate || exit

terraform_init() {
    echo "Running terraform init..."
    {
        terraform init --upgrade
    } >/dev/null
}

terraform_plan() {
    echo "Running terraform plan...."
    {
        terraform plan -out main.tfplan
    } >/dev/null &
    progress_bar_movement 1
    echo "✅ Terraform plan completed"
}

terraform_apply() {
    echo "Applying your configuration...."
    {
        terraform apply main.tfplan
    } >/dev/null &

    progress_bar_movement 5

    wait $! #waiting for background process to complete
    exit_status=$? #capturing the exit code of above terraform apply process

    if [ $exit_status -eq 0 ]; then
        echo "✅ Terraform apply complete."
        send_alert "VM is Up & Running 🎉"
        vm_connect
    else
        echo "❌ Error in terraform apply"
        return $exit_status
    fi
}

terraform_init
terraform_plan
terraform_apply

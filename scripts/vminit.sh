#!/bin/bash
path=$HOME/Desktop/terraform-boilerplate/scripts

source $path/progress_bar.sh || exit 1
source $path/alert.sh
source $path/connect.sh

cd $HOME/Desktop/terraform-boilerplate || exit

read -p "What you want to do? (create/destroy) = " action

if [ -z "$action" ]; then
    echo "Please enter a something"
    exit 1
elif [ "$action" != "d" ]; then
    read -p "Enter the resource group name = " resource_group_name

fi

terraform_init() {
    echo "Running terraform init..."
    {
        terraform init --upgrade
    } >/dev/null
}

terraform_plan() {
    echo "Running terraform plan...."
    {
        terraform plan -out main.tfplan -var="resource_name=$resource_group_name"
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

    wait $!        #waiting for background process to complete
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

user_choice() {
    local resource_group
    resource_group=$(terraform output -raw resource_group)
    case $action in
    c)
        terraform_init
        terraform_plan
        terraform_apply
        ;;
    d)
        terraform destroy -auto-approve -var="resource_name=$resource_group"
        ;;
    *)
        echo "Enter values in c/d only"
        ;;
    esac
}
user_choice

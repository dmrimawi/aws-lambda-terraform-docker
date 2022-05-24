#! /bin/bash

export working_dir="/tmp/ice_cream_workdir"

echo 'Making working dir ${working_dir}..'
mkdir ${working_dir}
mkdir ${working_dir}/app
mkdir ${working_dir}/.ssh
echo 'Copying files..'
cp ./app/* ${working_dir}/app/
cp ./.ssh/* ${working_dir}/.ssh
chmod 600 ${working_dir}/.ssh/id_*
echo 'Change current dir to ${working_dir}/app}'
cd ${working_dir}/app
echo "Initiating the resources"
terraform init
echo "Applying plan"
terraform apply -auto-approve

echo "Waiting until the training finish"
sleep 180

echo "Distroying the resources"
terraform destroy -auto-approve
echo "Done.."
exit 0

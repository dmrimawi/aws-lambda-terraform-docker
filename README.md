# aws-lambda-terraform-docker
This repository contains the container installed in the AWS Lambda function.

The docker container is based on AWS lambda, installed with it Terraform along with Python requests.

The container will work as a backend service to launch the Terraform code.

The terraform includes three resources:

__EC2 instance__: This is the machine to run the python code to train the model.

__Security group__: To allow SSH connection.

__Key pairs__: To allow connecting to the machine using SSH RSA keys.

This repository has the Docker file, Terraform code, and the scripts to launch the training in the EC2 machine.

To run this code correctly, make sure to add a new directory name .aws, that includes the private and public keys names as id_rsa, and id_rsa.pub.

Then in the main.tf code make sure to add the access and secret keys of your AWS account.

For more information about the project please refer to [ice cream web app](https://github.com/dmrimawi/ice_cream_web_app) repository.

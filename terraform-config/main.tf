terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  region  = "us-east-1"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "app_server" {
  ami = "ami-09d56f8956ab235b3"
  instance_type = "t2.micro"
  key_name = "aws_ice_cream_key_ml"
  vpc_security_group_ids = [aws_security_group.main.id]

  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/tmp/ice_cream_workdir/.ssh/id_rsa")
      timeout     = "5m"
   }
  tags = {
    Name = "IceCreamMLServer"
  }
  user_data = "${file("config_ec2.sh")}"
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress                = [
    {
        cidr_blocks      = [ "0.0.0.0/0", ]
        description      = ""
        from_port        = 22
        ipv6_cidr_blocks = []
        prefix_list_ids  = []
        protocol         = "tcp"
        security_groups  = []
        self             = false
        to_port          = 22
    }
  ]
}


resource "aws_key_pair" "deployer" {
  key_name   = "aws_ice_cream_key_ml"
  public_key = file("/tmp/ice_cream_workdir/.ssh/id_rsa.pub")
}

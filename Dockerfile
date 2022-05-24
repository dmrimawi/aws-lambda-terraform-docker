FROM public.ecr.aws/lambda/python:3.9
# Before running this code make sure to do the following:
# 1. put yout private key (id_rsa) and public key (id_rsa.pub) in the .aws folder.
# 2. update the terraform script (terraform-config/main.tf) with the access and secret
#    keys for aws account.

RUN yum -y update
RUN yum -y install wget unzip
RUN yum -y install \
                gcc \
                build-base \
                bash \
                libpng-dev \ 
                openblas-dev \
                freetype-dev \
                gfortran \
                musl-dev \
                libstdc++ \
                libtool \
                autoconf \
                automake \
                libexecinfo-dev \
                make \
                cmake \
                libcurl \
                git \
                python3 \
                py3-pip \
                sudo \
                passwd
RUN wget https://releases.hashicorp.com/terraform/1.2.0-rc1/terraform_1.2.0-rc1_linux_amd64.zip
RUN unzip terraform_1.2.0-rc1_linux_amd64.zip -d /usr/local/bin/
RUN rm -f terraform_1.2.0-rc1_linux_amd64.zip

RUN pip3 install --upgrade pip
RUN pip3 install awscli
RUN rm -rf /var/cache/apk/*


RUN mkdir -p ./app
COPY terraform-config/* ./app
RUN chmod +x ./app/create_platform.sh
RUN chmod +x ./app/config_ec2.sh

RUN mkdir -p ./.ssh
COPY .aws/i* ./.ssh/
RUN chmod 777 ./.ssh/*

COPY function.py ./
COPY requirements.txt ./
RUN pip3 install -r ./requirements.txt
RUN echo 'sbx_user1051  ALL=(ALL) NOPASSWD:ALL' |  tee /etc/sudoers.d/sbx_user1051
RUN chmod u+s /usr/bin/sudo



CMD ["function.lambda_handler"]


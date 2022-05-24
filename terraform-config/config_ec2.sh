#! /bin/bash

export log_file="/tmp/output_log.log"
export HOME=~

# Assign the following values with your private keys and public keys
# to configure the AWS to be able to clone your repository
# and to push commits to the repository
export ID_RSA_PRIVATE_KEY=""
export ID_RSA_PUBLIC_KEY=""

echo "Step1: Define the environmental variable" >> ${log_file} 2>&1

export learner_repo_lnk="git@github.com:dmrimawi/machine-learner.git"
export script_name="ice_creame_learner.py"
export machine_learning_script_path="machine-learner/python-script-learner"
export git_email="rimawi.eduardo@gmail.com"
export git_user="rimawi-eduardo"
export git_repo_vendor="github.com"

echo "Step2: Prepare the environment" >> ${log_file} 2>&1
echo "Step2.1: Install linux tools" >> ${log_file} 2>&1
sudo apt-get update >> ${log_file} 2>&1
sudo apt-get install -y git python3 python3-pip >> ${log_file} 2>&1
echo "Step2.2: prepare private key" >> ${log_file} 2>&1
mkdir -p ~/.ssh
echo ">>> Creating the keys <<<" >> ${log_file} 2>&1
touch ~/.ssh/id_rsa >> ${log_file} 2>&1
touch ~/.ssh/id_rsa.pub >> ${log_file} 2>&1
ls -ali ~/.ssh/ >> ${log_file} 2>&1
echo "${ID_RSA_PRIVATE_KEY}" >> ~/.ssh/id_rsa
cat ~/.ssh/id_rsa >> ${log_file} 2>&1
echo "${ID_RSA_PUBLIC_KEY}" >> ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/id_rsa* >> ${log_file} 2>&1
eval $(ssh-agent -s) >> ${log_file} 2>&1
ssh-add ~/.ssh/id_rsa >> ${log_file} 2>&1
echo "Step2.3: Clone the learner repo" >> ${log_file} 2>&1
cd ~
git config --global user.email ${git_email} >> ${log_file} 2>&1
git config --global user.name ${git_user} >> ${log_file} 2>&1
ssh-keyscan ${git_repo_vendor} >> ~/.ssh/known_hosts
git clone ${learner_repo_lnk} >> ${log_file} 2>&1
cd ${machine_learning_script_path}
echo "Step2.4: Install python packages" >> ${log_file} 2>&1
pip3 install --upgrade pip >> ${log_file} 2>&1
pip3 install -r requirements.txt >> ${log_file} 2>&1

echo "Step3: Running the learner now" >> ${log_file} 2>&1
python3 ${script_name} >> ${log_file} 2>&1

git status >> ${log_file} 2>&1
machine_info=$(uname -a)
git commit -a -m "Updating the learner model - EC2 machine" -m "${machine_info}" >> ${log_file} 2>&1
git push origin master >> ${log_file} 2>&1
cd ~

exit 0

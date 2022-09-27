#! /bin/bash
sudo apt-get update -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt-cache policy docker-ce
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
sudo addgroup docker
sudo usermod -aG docker $USER
sudo chmod 666 /var/run/docker.sock
newgrp docker
sudo systemctl restart docker.service




  
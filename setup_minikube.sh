sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl

# Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt install docker-ce
sudo usermod -aG docker $USER
newgrp docker

# Install Minikube
sudo snap install kubectl --classic
sudo apt-get install wget
wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 -O minikube
chmod 755 minikube
sudo mv minikube /usr/local/bin/
minikube version

minikube start
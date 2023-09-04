# !/bin/bash

sudo dnf install curl 
sudo dnf install -y java-11-openjdk
sudo curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo sed -i --follow-symlinks 's/gpgcheck=1/gpgcheck=0/g' /etc/yum.repos.d/jenkins.repo
sudo dnf install -y jenkins
sudo systemctl start jenkins && systemctl enable jenkins
sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
sudo firewall-cmd --reload
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
sudo dnf install -y git
sudo git config --global user.name "Nikhil Verma"
sudo git config --global user.email n.nikhilverma89@gmail.com
sudo sed -i 's/^PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd



# docker

```
#02 
mkdir Vagrant && cd Vagrant
vagrant box add trusty64 https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box
mkdir Docker && cd Docker
vagrant init trusty64
vim Vagrantfile # change IP address to "192.168.55.44"
vagrant up
vagrant ssh

#03
sudo apt-get update
sudo apt-get install docker.io
sudo ln -sf /usr/bin/docker.io /usr/local/bin/docker

#04

#05
sudo docker search centos | more
sudo docker pull centos
sudo docker images
sudo docker inspect
sudo docker rmi <IMAGE ID>

#06
sudo docker run centos echo "hello world"
sudo docker ps -a -n 5
sudo docker rm <CONTAINER ID>

#07
sudo docker run -d centos free -s 3
sudo docker logs <CONTAINER ID>
sudo docker attach --sig-proxy=false <CONTAINER ID>
sudo docker kill <CONTAINER ID>
sudo docker start <CONTAINER ID>
sudo docker run -i -t centos /bin/bash
touch hello.txt
ls
exit
sudo docker commit <CONTAINER ID> ohbarye/hello # create image

#08
vim Dockerfile # write FROM, MAINTAINER, RUN, CMD
sudo docker build -t ohbarye/echo .

#09
vim Dockerfile # write process from install httpd through run
sudo docker build -t ohbarye/httpd .
sudo docker run -p 8080:80 -d ohbarye/httpd

#10
# sign up https://hub.docker.com/
sudo docker login # with credential
sudo docker push ohbarye/httpd
```

# summary

This docker image provides remote desktop environment of vncserver through xrdp.

- This docker image includes minimum packages to try this kind of environment.
If you like this, you can add more packages to fit your needs

- As same as windows's rdp, it needs the rdp port 3389/tcp opened to access the desktop if you don't change the port number. 
Of course you can change it to other number to avoid unintended access from the internet. Moreover if you will use vpn or ssh port forward, you can close the rdp port.

## build

You can simply pull docker image as below

	docker pull mnod/docker-tightvnc:latest

Alternatively, you can build your own image as below.
Before you execute this, you need to install git command and docker environment in your environment.

    git clone https://docker-tightvnc.git docker-tightvnc
    cd docker-tightvnc
    docker build -t docker-tightvnc:latest .


## run

If you have a home directory for user docker(1000:1000) where the container stores .vnc/passwd file

    docker run --rm -d -p <localport>:3389 -v /local/path/home/docker:/home/docker docker-tightvnc:latest

`localport` is something like 3389.
You cannot run multiple containers which use the same port number. If you want to do so, you have to change `localport` for each containters.
3389/tcp is one of famous ports for atackers. If you will not use vpn nor ssh port forward and open the container to world wide, at least you should consider to use other number.

or if you don't have a home directory,

    docker run --rm -d -p <localport>:3389 docker-tightvnc:latest

If there is .vnc/passwd file in the home directory you spicified, it is used for vnc password.
If it does not exist, the container generate a new password and put it into .vnc/passwd file.

To show the new generated password

    docker ps | awk '$2~/docker-tightvnc:latest/{print $1}' | xargs docker logs | head -n 1

## connect

In linux, 

    xfreerdp /v:<address>:<localport> /p:password

This connect to background vnc display :0.

In windows, 

    mstsc /v:<address>:<localport>

After new window opens, Select session from `Xvnc0` and `Xvnc1`, then input password 
Session `Xvnc0` is for background vnc display :0, and Xvnc1 is for :1.

## stop

    docker ps | awk '$2~/docker-tightvnc:latest/{print $1}' | xargs docker stop


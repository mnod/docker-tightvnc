#! /bin/bash

PASS=`pwgen -s 12 1`
echo ${PASS}

vncdir=~docker/.vnc
vncpassfile=${vncdir}/passwd
mkdir ${vncdir}
chmod 700 ${vncdir}
echo ${PASS} | vncpasswd -f > ${vncpassfile}
chmod 600 ${vncpassfile}
chown -R docker:docker ${vncdir}

su - docker -c "vncserver -geometry 1024x740 -depth 16 :0"
xrdp --nodaemon

#! /bin/bash

PASS=`pwgen -s 12 1`
echo ${PASS}
echo docker:${PASS} | chpasswd

mkdir ~docker/.vnc
chmod 700 ~docker/.vnc
echo ${PASS} | vncpasswd -f > ~docker/.vnc/passwd
chmod 600 ~docker/.vnc/passwd
chown -R docker:docker ~docker/.vnc

if [ $# -eq 1 ]; then
  sshdir=~docker/.ssh
  keyfile=$sshdir/authorized_keys
  mkdir $sshdir ; chmod 755 $sshdir
  touch $keyfile ; chmod 600 $keyfile
  echo $1 >> $sshdir/authorized_keys
  chown -R docker:docker $sshdir
fi

su - docker -c "vncserver -localhost -geometry 1366x720 -depth 8 :1"
/usr/sbin/sshd -D

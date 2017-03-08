#! /bin/bash -x

PASS=`pwgen -s 12 1`
echo ${PASS}
echo docker:${PASS} | chpasswd

vncdir=~docker/.vnc
vncpassfile=${vncdir}/passwd
mkdir ${vncdir}
chmod 700 ${vncdir}
echo ${PASS} | vncpasswd -f > ${vncpassfile}
chmod 600 ${vncpassfile}
chown -R docker:docker ${vncdir}

if [ $# -eq 1 ]; then
  sshdir=~docker/.ssh
  keyfile=$sshdir/authorized_keys
  mkdir $sshdir ; chmod 755 $sshdir
  touch $keyfile ; chmod 600 $keyfile
  echo $1 >> $sshdir/authorized_keys
  chown -R docker:docker $sshdir
fi

su - docker -c "LANG=ja_JP.UTF-8 vncserver -localhost -geometry 1366x720 -depth 8 :1"
/usr/sbin/sshd -D

#! /bin/bash

vncdir=~docker/.vnc
vncpassfile=${vncdir}/passwd

if [ ! -d ${vncdir} ]; then
  echo "# making ${vncdir}..."
  mkdir ${vncdir}
  chmod 700 ${vncdir}
  chown -R docker:docker ${vncdir}
fi
if [ ! -f ${vncpassfile} ]; then
  echo "# making ${vncpassfile}..."

  PASS=`pwgen -s 8 1`
  echo ${PASS}
  echo ${PASS} | vncpasswd -f > ${vncpassfile}
  chmod 600 ${vncpassfile}
  chown -R docker:docker ${vncdir}
fi

echo "# starting vncserver processes..."
su - docker -c "vncserver -geometry 1024x740 -depth 16 :0"
su - docker -c "vncserver -geometry 1600x900 -depth 16 :1"
 
echo "# starting xrdp daemon..."
xrdp --nodaemon

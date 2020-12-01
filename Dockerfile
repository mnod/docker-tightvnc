From ubuntu:20.04

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install --no-install-recommends -y \
    git \
    vim-tiny \
    tmux \
    pwgen \
    openssh-client \
    openbox \
    tint2 \
    xfonts-base \
    tightvncserver \
    firefox \
    xrdp \
    pcmanfm \
    lxterminal \
    meld \
    scite \
    dbus-x11 \
    ibus-anthy \
    ibus-gtk \
    ibus-gtk3 \
    fonts-ipaexfont \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

ADD xrdp.ini /etc/xrdp/xrdp.ini
ADD run.sh /run.sh
RUN chmod +x /run.sh
RUN useradd -s /bin/bash -m docker

EXPOSE 3389
CMD ["/run.sh"]

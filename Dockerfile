FROM ubuntu:22.04

COPY entrypoint.sh /

RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update; \
    apt-get install -y vim tzdata ca-certificates curl wget git unzip iputils-ping \
    openssh-server sudo cron net-tools iproute2 systemd --no-install-recommends; \
    curl -fsSL https://deb.nodesource.com/setup_22.x | bash -; \
    apt-get install -y nginx nodejs python3-pip supervisor --no-install-recommends; \
    python3 -m pip install --upgrade trzsz; \
    rm -rf /var/lib/apt/lists/*; \
    mkdir /var/run/sshd; \
    echo "alias ll='ls -la'" >> /etc/bash.bashrc; \
    echo "alias reboot='sudo kill -SIGTERM 1'" >> /etc/bash.bashrc; \
    ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime; \
    echo "Asia/Shanghai" > /etc/timezone; \
    echo "set fileencodings=utf-8,gbk,utf-16le,cp1252,iso-8859-15,ucs-bom" >> /etc/vim/vimrc; \
    echo "set termencoding=utf-8" >> /etc/vim/vimrc; \
    echo "set encoding=utf-8" >> /etc/vim/vimrc; \
    curl -Lo /usr/bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.x86_64; \
    chmod +x /usr/bin/ttyd; \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["supervisord","-c","/etc/supervisord.conf"]

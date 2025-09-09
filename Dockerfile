ARG UBUNTU_VERSION=22.04

FROM ubuntu:${UBUNTU_VERSION}

ARG UBUNTU_VERSION

LABEL org.opencontainers.image.source=https://github.com/linjixing/ubuntu

LABEL org.opencontainers.image.ref.name=linjixing/ubuntu

LABEL org.opencontainers.image.version=${UBUNTU_VERSION}

ENV PATH=/home/bin:$PATH

RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update; \
    apt-get install -y openssh-server ca-certificates git curl wget unzip net-tools dnsutils iputils-ping telnet traceroute tzdata vim nano sudo cron supervisor nginx certbot python3-certbot-dns-cloudflare python3-pip --no-install-recommends; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*; \
    mkdir /var/run/sshd; \
    getent passwd ubuntu > /dev/null && userdel -rf ubuntu; \
    ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime; \
    echo 'Asia/Shanghai' > /etc/timezone; \
    echo 'set fileencodings=utf-8,gbk,utf-16le,cp1252,iso-8859-15,ucs-bom' >> /etc/vim/vimrc; \
    echo 'set termencoding=utf-8' >> /etc/vim/vimrc; \
    echo 'set encoding=utf-8' >> /etc/vim/vimrc

CMD ["/bin/bash"]

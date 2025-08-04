FROM ubuntu:22.04

LABEL org.opencontainers.image.source https://github.com/linjixing/ubuntu

ENV TZ=Asia/Shanghai

COPY entrypoint.sh /entrypoint.sh

RUN export DEBIAN_FRONTEND=noninteractive; \
    apt update; \
    apt install -y software-properties-common tzdata curl wget unzip vim sudo; \
    add-apt-repository -y ppa:ondrej/php; \
    add-apt-repository -y ppa:longsleep/golang-backports; \
    apt update; \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime; \
    echo $TZ > /etc/timezone; \
    echo "set fileencodings=utf-8,gbk,utf-16le,cp1252,iso-8859-15,ucs-bom" >> /etc/vim/vimrc; \
    echo "set termencoding=utf-8" >> /etc/vim/vimrc; \
    echo "set encoding=utf-8" >> /etc/vim/vimrc; \
    curl -fsSL https://deb.nodesource.com/setup_22.x | bash - ; \
    apt install -y openssh-server cron telnet net-tools iputils-ping iproute2 php8.4 php8.4-cli php8.4-fpm php8.4-common php8.4-mysql php8.4-xml php8.4-curl php8.4-gd php8.4-imagick php8.4-mbstring php8.4-zip php8.4-bcmath php8.4-intl php8.4-soap php8.4-redis php8.4-memcached php8.4-opcache php8.4-xdebug nginx golang-go python3 python3-pip nodejs supervisor git --no-install-recommends; \
    apt-get clean; \
    mkdir /var/run/sshd; \
    chmod +x /entrypoint.sh

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/sshd", "-D"]

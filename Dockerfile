FROM ubuntu:22.04

ENV TZ=Asia/Shanghai

COPY entrypoint.sh /entrypoint.sh

RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update; \
    apt-get install -y tzdata openssh-server sudo cron curl wget unzip vim telnet net-tools iputils-ping iproute2 ca-certificates supervisor nginx python3 git --no-install-recommends; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*; \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime; \
    echo $TZ > /etc/timezone; \
    mkdir /var/run/sshd; \
    chmod +x /entrypoint.sh

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/sshd", "-D"]

#!/usr/bin/env sh

useradd -s /bin/bash -d /home/$USER -G sudo $USER
echo "$USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/init

if [ ! -d "/home/$USER" ]; then
    mkdir -p /home/$USER/bin
    mkdir -p /home/$USER/logs
    mkdir -p /home/$USER/conf/supervisor
    mkdir -p /home/$USER/.ssh
    chmod 700 /home/$USER/.ssh
    echo $RSA > /home/$USER/.ssh/authorized_keys
    chmod 600 /home/$USER/.ssh/authorized_keys
    chown $USER:$USER -R /home/$USER
fi

cat > /etc/supervisord.conf << EOF
[supervisord]
nodaemon=true
pidfile=/var/run/supervisord.pid
logfile=/dev/null

[include]
files=/home/$USER/conf/supervisor/*.conf

[unix_http_server]
file=/var/run/supervisor.sock

[rpcinterface:supervisor]
supervisor.rpcinterface_factory=supervisor.rpcinterface:make_main_rpcinterface

[supervisorctl]
serverurl=unix:///var/run/supervisor.sock

[program:sshd]
command=/usr/sbin/sshd -D
autostart=true
autorestart=true

[program:ttyd]
environment=HOME="/home/$USER",USER="$USER",LOGNAME="$USER"
command=/usr/bin/ttyd -t enableTrzsz=true -c $USER:password -W bash
directory=/home/$USER
autostart=true
autorestart=true
user=$USER
EOF

exec "$@"

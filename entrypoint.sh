#!/usr/bin/env sh

useradd -s /bin/bash -d /home/$USER -G sudo $USER
echo "$USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/init

if [ ! -d "/home/$USER" ]; then
    mkdir -p /home/$USER/bin
    mkdir -p /tmp
    mkdir -p /home/$USER/conf/supervisor
    mkdir -p /home/$USER/sh
    echo "#!/usr/bin/env sh" > /home/$USER/sh/init.sh
    chmod +x /home/$USER/sh/init.sh
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
logfile=/tmp/supervisord.log
stdout_logfile=/tmp/supervisord.log
stderr_logfile=/tmp/supervisord.log

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
logfile=/tmp/sshd.log
stdout_logfile=/tmp/sshd.log
stderr_logfile=/tmp/sshd.log
autostart=true
autorestart=true

[program:cron]
command=/usr/sbin/cron -f
logfile=/tmp/cron.log
stdout_logfile=/tmp/cron.log
stderr_logfile=/tmp/cron.log
autostart=true
autorestart=true

[program:init]
command=/home/$USER/sh/init.sh
logfile=/tmp/init.log
stdout_logfile=/tmp/init.log
stderr_logfile=/tmp/init.log
autostart=true
autorestart=false
startretries=0
startsecs=0
user=$USER

[program:ttyd]
environment=HOME="/home/$USER",USER="$USER",LOGNAME="$USER"
command=/usr/bin/ttyd -t enableTrzsz=true -c $USER:password -W bash
directory=/home/$USER
logfile=/tmp/ttyd.log
stdout_logfile=/tmp/ttyd.log
stderr_logfile=/tmp/ttyd.log
autostart=true
autorestart=true
user=$USER
EOF

exec "$@"

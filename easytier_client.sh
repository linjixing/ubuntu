#!/usr/bin/env sh

curl -LO https://github.com/EasyTier/EasyTier/releases/download/v2.2.4/easytier-linux-x86_64-v2.2.4.zip
unzip -o easytier-linux-x86_64-v2.2.4.zip
mv easytier-linux-x86_64/easytier-core /home/$USER/bin
rm -rf easytier-linux-x86_64*

cat > /home/$USER/conf/easytier.toml << EOF
hostname = "$DOMAIN"
ipv4 = "$IPV4"
dhcp = false
rpc_portal = "0.0.0.0:15888"

[network_identity]
network_name = "easytier"
network_secret = ""

[[peer]]
uri = "wss://easytier.coler.qzz.io/"

[flags]
no_tun = true
EOF

cat > /home/$USER/conf/supervisor/easytier.conf << EOF
[program:easytier]
command=/home/$USER/bin/easytier-core -c /home/$USER/conf/easytier.toml
autostart=true
autorestart=true
user=$USER
EOF

exec "$@"

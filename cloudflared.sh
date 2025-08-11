#!/usr/bin/env sh

curl -Lo /home/$USER/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/download/2025.7.0/cloudflared-linux-amd64
chmod +x /home/$USER/bin/cloudflared

cat > /home/$USER/conf/supervisor/cloudflared.conf << EOF
[program:cloudflared]
command=/home/$USER/bin/cloudflared tunnel --no-autoupdate run --token $TOKEN
autostart=true
autorestart=true
user=$USER
EOF

exec "$@"

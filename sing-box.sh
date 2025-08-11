#!/usr/bin/env sh

curl -LO https://github.com/SagerNet/sing-box/releases/download/v1.11.15/sing-box-1.11.15-linux-amd64.tar.gz
tar -zxf sing-box-1.11.15-linux-amd64.tar.gz
mv sing-box-1.11.15-linux-amd64/sing-box /home/$USER/bin
rm -rf sing-box-*

cat > /home/$USER/conf/sing-box.json << EOF
{
    "log":
    {
        "disabled": true
    },
    "inbounds": [
    {
        "type": "vmess",
        "listen": "::",
        "listen_port": 2323,
        "sniff": true,
        "sniff_override_destination": true,
        "transport":
        {
            "type": "ws",
            "path": "/",
            "max_early_data": 2048,
            "early_data_header_name": "Sec-WebSocket-Protocol"
        },
        "users": [
        {
            "uuid": "$UUID",
            "alterId": 0
        }]
    }],
    "outbounds": [
    {
        "type": "direct"
    }]
}
EOF

cat > /home/$USER/logs/vmess.txt << EOF
vmess://$(echo "{ \"v\": \"2\", \"ps\": \"$DOMAIN\", \"add\": \"104.16.0.0\", \"port\": \"443\", \"id\": \"$UUID\", \"aid\": \"0\", \"scy\": \"auto\", \"net\": \"ws\", \"type\": \"none\", \"host\": \"$DOMAIN\", \"path\": \"/ws?ed=2048\", \"tls\": \"tls\", \"sni\": \"$DOMAIN\", \"alpn\": \"\", \"fp\": \"\"}" | base64 -w0)
EOF

cat > /home/$USER/conf/supervisor/sing-box.conf << EOF
[program:sing-box]
command=/home/$USER/bin/sing-box run -c /home/$USER/conf/sing-box.json
autostart=true
autorestart=true
EOF

exec "$@"

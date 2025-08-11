#!/usr/bin/env sh

curl -LO https://github.com/XTLS/Xray-core/releases/download/v25.7.26/Xray-linux-64.zip
unzip -o Xray-linux-64.zip -d /home/$USER/bin
rm -rf Xray-linux-64.zip

cat > /home/$USER/conf/xray.json << EOF
{
    "log":
    {
        "loglevel": "none",
        "access": "/dev/null",
        "error": "/dev/null"
    },
    "dns":
    {
        "servers": ["https+local://1.1.1.1/dns-query", "localhost"]
    },
    "routing":
    {
        "domainStrategy": "IPIfNonMatch",
        "rules": [
        {
            "type": "field",
            "ip": ["geoip:cn", "geoip:private"],
            "outboundTag": "block"
        },
        {
            "type": "field",
            "domain": ["geosite:category-ads-all"],
            "outboundTag": "block"
        }]
    },
    "inbounds": [
    {
        "port": 2323,
        "protocol": "vmess",
        "settings":
        {
            "clients": [
            {
                "id": "$UUID"
            }]
        },
        "streamSettings":
        {
            "network": "ws",
            "security": "none",
            "wsSettings":
            {
                "path": "/ws?ed=2048"
            }
        }
    }],
    "outbounds": [
    {
        "protocol": "freedom",
        "tag": "direct"
    },
    {
        "protocol": "blackhole",
        "tag": "block"
    }]
}
EOF

cat > /home/$USER/logs/vmess.txt << EOF
vmess://$(echo "{ \"v\": \"2\", \"ps\": \"$DOMAIN\", \"add\": \"104.16.0.0\", \"port\": \"443\", \"id\": \"$UUID\", \"aid\": \"0\", \"scy\": \"auto\", \"net\": \"ws\", \"type\": \"none\", \"host\": \"$DOMAIN\", \"path\": \"/ws?ed=2048\", \"tls\": \"tls\", \"sni\": \"$DOMAIN\", \"alpn\": \"\", \"fp\": \"\"}" | base64 -w0)
EOF

cat > /home/$USER/conf/supervisor/xray.conf << EOF
[program:xray]
command=/home/$USER/bin/xray -c /home/$USER/conf/xray.json
autostart=true
autorestart=true
EOF

exec "$@"

#!/bin/bash

echo "Configuration du port 443 pour Docker rootless..."

if ! grep -q "net.ipv4.ip_unprivileged_port_start=443" /etc/sysctl.conf 2>/dev/null; then
    echo "net.ipv4.ip_unprivileged_port_start=443" >> /etc/sysctl.conf
    sysctl -p
    echo "✅ Configuration du port 443 terminée"
else
    echo "✅ Port 443 déjà configuré"
fi
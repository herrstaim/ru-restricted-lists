#!/bin/sh
# Обновление списков на OpenWrt 23.05+ (fw4/nftables, dnsmasq-full).
# Использование: openwrt-update.sh [список]   по умолчанию: all
BASE="https://raw.githubusercontent.com/USER/REPO/release"   # <-- замените USER/REPO
LIST="${1:-all}"
TMP=/tmp/rr-update
mkdir -p "$TMP" /tmp/dnsmasq.d

wget -qO "$TMP/nftset.conf" "$BASE/dnsmasq/$LIST-nftset.conf" || { logger -t rr "не скачан список доменов"; exit 1; }
wget -qO "$TMP/v4.txt" "$BASE/ip/$LIST-v4.txt" || { logger -t rr "не скачан список IP"; exit 1; }

# Домены -> dnsmasq: при резолве IP попадают в набор vpn_domains
if [ -s "$TMP/nftset.conf" ] && ! cmp -s "$TMP/nftset.conf" /tmp/dnsmasq.d/ru-restricted.conf; then
  cp "$TMP/nftset.conf" /tmp/dnsmasq.d/ru-restricted.conf
  /etc/init.d/dnsmasq restart
fi

# Подсети (Telegram, Meta/WhatsApp и др.) -> набор vpn_ip
if [ -s "$TMP/v4.txt" ]; then
  awk 'BEGIN{printf "add element inet fw4 vpn_ip { "} NR>1{printf ", "} {printf "%s", $0} END{print " }"}' \
    "$TMP/v4.txt" > "$TMP/v4.nft"
  nft flush set inet fw4 vpn_ip && nft -f "$TMP/v4.nft"
fi
logger -t rr "списки $LIST обновлены"

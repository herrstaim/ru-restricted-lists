/ip firewall address-list remove [find list=vpn_ip comment="rr-telegram"]
/ip firewall address-list
add list=vpn_ip address=5.28.192.0/18 comment="rr-telegram"
add list=vpn_ip address=91.105.192.0/23 comment="rr-telegram"
add list=vpn_ip address=91.108.4.0/22 comment="rr-telegram"
add list=vpn_ip address=91.108.8.0/21 comment="rr-telegram"
add list=vpn_ip address=91.108.16.0/21 comment="rr-telegram"
add list=vpn_ip address=91.108.56.0/22 comment="rr-telegram"
add list=vpn_ip address=95.161.64.0/20 comment="rr-telegram"
add list=vpn_ip address=149.154.160.0/20 comment="rr-telegram"
add list=vpn_ip address=185.76.151.0/24 comment="rr-telegram"
add list=vpn_ip address=194.221.0.0/16 comment="rr-telegram"
/ipv6 firewall address-list remove [find list=vpn_ip comment="rr-telegram"]
/ipv6 firewall address-list
add list=vpn_ip address=2001:67c:4e8::/48 comment="rr-telegram"
add list=vpn_ip address=2001:b28:f23c::/47 comment="rr-telegram"
add list=vpn_ip address=2001:b28:f23f::/48 comment="rr-telegram"
add list=vpn_ip address=2a0a:f280::/32 comment="rr-telegram"

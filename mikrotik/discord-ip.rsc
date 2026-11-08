/ip firewall address-list remove [find list=vpn_ip comment="rr-discord"]
/ip firewall address-list
add list=vpn_ip address=5.200.14.128/25 comment="rr-discord"
add list=vpn_ip address=34.0.0.0/14 comment="rr-discord"
add list=vpn_ip address=35.192.0.0/11 comment="rr-discord"
add list=vpn_ip address=66.22.192.0/18 comment="rr-discord"
add list=vpn_ip address=104.16.0.0/12 comment="rr-discord"
add list=vpn_ip address=138.128.136.0/21 comment="rr-discord"
add list=vpn_ip address=162.158.0.0/15 comment="rr-discord"
add list=vpn_ip address=172.64.0.0/13 comment="rr-discord"

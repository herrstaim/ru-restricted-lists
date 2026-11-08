/ip firewall address-list remove [find list=vpn_ip comment="rr-twitter"]
/ip firewall address-list
add list=vpn_ip address=64.63.0.0/18 comment="rr-twitter"
add list=vpn_ip address=103.252.112.0/22 comment="rr-twitter"
add list=vpn_ip address=104.244.42.0/24 comment="rr-twitter"
add list=vpn_ip address=104.244.44.0/22 comment="rr-twitter"
add list=vpn_ip address=188.64.224.0/21 comment="rr-twitter"
add list=vpn_ip address=192.133.76.0/22 comment="rr-twitter"
add list=vpn_ip address=199.16.156.0/22 comment="rr-twitter"
add list=vpn_ip address=199.59.148.0/22 comment="rr-twitter"
add list=vpn_ip address=199.96.56.0/23 comment="rr-twitter"
add list=vpn_ip address=202.160.128.0/22 comment="rr-twitter"

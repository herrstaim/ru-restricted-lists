/ip firewall address-list remove [find list=vpn_ip comment="rr-anthropic"]
/ip firewall address-list
add list=vpn_ip address=160.79.104.0/21 comment="rr-anthropic"

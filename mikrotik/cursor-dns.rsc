/ip dns static remove [find comment="rr-cursor"]
/ip dns static
add name=cursor.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-cursor"
add name=cursor.sh type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-cursor"
add name=cursorvm.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-cursor"

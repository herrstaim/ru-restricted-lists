/ip dns static remove [find comment="rr-canva"]
/ip dns static
add name=canva.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-canva"

/ip dns static remove [find comment="rr-medium"]
/ip dns static
add name=medium.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-medium"

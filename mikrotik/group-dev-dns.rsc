/ip dns static remove [find comment="rr-group-dev"]
/ip dns static
add name=docker.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-group-dev"
add name=docker.io type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-group-dev"

/ip dns static remove [find comment="rr-runway"]
/ip dns static
add name=runwayml.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-runway"

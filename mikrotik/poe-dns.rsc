/ip dns static remove [find comment="rr-poe"]
/ip dns static
add name=poe.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-poe"

/ip dns static remove [find comment="rr-udio"]
/ip dns static
add name=udio.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-udio"

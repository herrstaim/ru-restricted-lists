/ip dns static remove [find comment="rr-suno"]
/ip dns static
add name=suno.ai type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-suno"
add name=suno.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-suno"

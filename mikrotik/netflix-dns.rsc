/ip dns static remove [find comment="rr-netflix"]
/ip dns static
add name=netflix.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-netflix"
add name=nflximg.net type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-netflix"
add name=nflxvideo.net type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-netflix"

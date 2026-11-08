/ip dns static remove [find comment="rr-soundcloud"]
/ip dns static
add name=sndcdn.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-soundcloud"
add name=soundcloud.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-soundcloud"

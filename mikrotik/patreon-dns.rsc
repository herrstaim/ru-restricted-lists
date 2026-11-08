/ip dns static remove [find comment="rr-patreon"]
/ip dns static
add name=patreon.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-patreon"
add name=patreonusercontent.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-patreon"

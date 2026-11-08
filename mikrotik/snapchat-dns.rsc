/ip dns static remove [find comment="rr-snapchat"]
/ip dns static
add name=sc-cdn.net type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-snapchat"
add name=snap-dev.net type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-snapchat"
add name=snapchat.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-snapchat"
add name=snapkit.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-snapchat"

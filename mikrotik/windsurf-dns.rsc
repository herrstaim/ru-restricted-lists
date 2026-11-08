/ip dns static remove [find comment="rr-windsurf"]
/ip dns static
add name=codeium.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-windsurf"
add name=windsurf.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-windsurf"

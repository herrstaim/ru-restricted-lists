/ip dns static remove [find comment="rr-linkedin"]
/ip dns static
add name=licdn.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-linkedin"
add name=linkedin.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-linkedin"
add name=lnkd.in type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-linkedin"

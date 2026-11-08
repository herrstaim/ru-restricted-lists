/ip dns static remove [find comment="rr-envato"]
/ip dns static
add name=envato.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-envato"
add name=envatousercontent.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-envato"

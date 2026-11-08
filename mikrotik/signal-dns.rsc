/ip dns static remove [find comment="rr-signal"]
/ip dns static
add name=signal.art type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-signal"
add name=signal.me type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-signal"
add name=signal.org type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-signal"
add name=whispersystems.org type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-signal"

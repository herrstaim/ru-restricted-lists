/ip dns static remove [find comment="rr-dailymotion"]
/ip dns static
add name=dailymotion.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-dailymotion"
add name=dmcdn.net type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-dailymotion"

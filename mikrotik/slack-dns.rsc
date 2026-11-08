/ip dns static remove [find comment="rr-slack"]
/ip dns static
add name=slack.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-slack"

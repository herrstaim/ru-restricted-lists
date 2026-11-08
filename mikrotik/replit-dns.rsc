/ip dns static remove [find comment="rr-replit"]
/ip dns static
add name=replit.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-replit"

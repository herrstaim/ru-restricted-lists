/ip dns static remove [find comment="rr-metacritic"]
/ip dns static
add name=metacritic.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-metacritic"

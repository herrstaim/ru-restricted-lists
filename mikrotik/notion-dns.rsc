/ip dns static remove [find comment="rr-notion"]
/ip dns static
add name=notion-static.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-notion"
add name=notion.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-notion"
add name=notion.so type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-notion"

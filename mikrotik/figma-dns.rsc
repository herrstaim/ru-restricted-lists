/ip dns static remove [find comment="rr-figma"]
/ip dns static
add name=figma.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-figma"

/ip dns static remove [find comment="rr-viber"]
/ip dns static
add name=viber.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-viber"

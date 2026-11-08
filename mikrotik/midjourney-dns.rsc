/ip dns static remove [find comment="rr-midjourney"]
/ip dns static
add name=midjourney.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-midjourney"

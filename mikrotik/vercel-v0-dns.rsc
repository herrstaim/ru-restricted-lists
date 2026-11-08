/ip dns static remove [find comment="rr-vercel-v0"]
/ip dns static
add name=v0.app type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-vercel-v0"
add name=v0.dev type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-vercel-v0"

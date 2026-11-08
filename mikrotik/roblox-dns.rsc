/ip dns static remove [find comment="rr-roblox"]
/ip dns static
add name=rbx.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-roblox"
add name=rbxcdn.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-roblox"
add name=rbxinfra.net type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-roblox"
add name=roblox.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-roblox"
add name=robloxdev.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-roblox"
add name=robloxlabs.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-roblox"

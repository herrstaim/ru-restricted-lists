/ip dns static remove [find comment="rr-xai"]
/ip dns static
add name=grok.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-xai"
add name=grok.x.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-xai"
add name=grokbot.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-xai"
add name=grokipedia.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-xai"
add name=x.ai type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-xai"

/ip dns static remove [find comment="rr-character-ai"]
/ip dns static
add name=character.ai type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-character-ai"

/ip dns static remove [find comment="rr-elevenlabs"]
/ip dns static
add name=elevenlabs.io type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-elevenlabs"

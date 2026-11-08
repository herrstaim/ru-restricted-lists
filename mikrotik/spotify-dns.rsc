/ip dns static remove [find comment="rr-spotify"]
/ip dns static
add name=scdn.co type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-spotify"
add name=spotify.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-spotify"
add name=spotifycdn.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-spotify"

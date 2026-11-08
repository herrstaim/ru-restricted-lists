/ip dns static remove [find comment="rr-google-meet"]
/ip dns static
add name=hangouts.googleapis.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-google-meet"
add name=meet.google.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-google-meet"
add name=meet.googleapis.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-google-meet"
add name=meetings.clients6.google.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-google-meet"
add name=meetings.googleapis.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-google-meet"

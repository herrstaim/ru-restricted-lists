/ip dns static remove [find comment="rr-onepassword"]
/ip dns static
add name=1password.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-onepassword"

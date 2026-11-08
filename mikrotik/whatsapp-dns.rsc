/ip dns static remove [find comment="rr-whatsapp"]
/ip dns static
add name=wa.me type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-whatsapp"
add name=whatsapp.cc type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-whatsapp"
add name=whatsapp.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-whatsapp"
add name=whatsapp.info type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-whatsapp"
add name=whatsapp.net type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-whatsapp"
add name=whatsapp.org type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-whatsapp"
add name=whatsapp.tv type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-whatsapp"
add name=whatsappbrand.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-whatsapp"
add name=wl.co type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-whatsapp"

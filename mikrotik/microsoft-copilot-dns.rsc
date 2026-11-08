/ip dns static remove [find comment="rr-microsoft-copilot"]
/ip dns static
add name=copilot.cloud.microsoft type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-microsoft-copilot"
add name=copilot.microsoft.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-microsoft-copilot"
add name=edgeservices.bing.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-microsoft-copilot"
add name=sydney.bing.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-microsoft-copilot"

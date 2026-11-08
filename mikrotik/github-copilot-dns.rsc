/ip dns static remove [find comment="rr-github-copilot"]
/ip dns static
add name=copilot-proxy.githubusercontent.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-github-copilot"
add name=githubcopilot.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-github-copilot"
add name=origin-tracker.githubusercontent.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-github-copilot"

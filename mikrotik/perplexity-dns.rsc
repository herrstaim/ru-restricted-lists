/ip dns static remove [find comment="rr-perplexity"]
/ip dns static
add name=perplexity.ai type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-perplexity"
add name=pplx.ai type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-perplexity"

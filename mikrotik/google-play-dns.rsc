/ip dns static remove [find comment="rr-google-play"]
/ip dns static
add name=android.clients.google.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-google-play"
add name=beacons.gvt2.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-google-play"
add name=connectivitycheck.gstatic.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-google-play"
add name=googleplay.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-google-play"
add name=gvt1.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-google-play"
add name=lh3.googleusercontent.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-google-play"
add name=play-fe.googleapis.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-google-play"
add name=play-games.googleusercontent.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-google-play"
add name=play-lh.googleusercontent.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-google-play"
add name=play.google.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-google-play"
add name=play.googleapis.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-google-play"
add name=prod-lt-playstoregatewayadapter-pa.googleapis.com type=FWD forward-to=1.1.1.1 match-subdomain=yes address-list=vpn_domains comment="rr-google-play"

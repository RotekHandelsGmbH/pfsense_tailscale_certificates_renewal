#/bin/sh
# make sure lineendings are only LF, not CRLF

# Settings - fill in as needed
tailscale_domain="<tail?????.ts.net>"
tailscale_hostname_fqdn="<hostname>.$tailscale_domain"

# defaults
certificatename="$tailscale_hostname_fqdn"
pathdir_certificates="/root/.tailscale-certificates/$tailscale_domain"
filename_fullchain_cert="$tailscale_hostname_fqdn"_fullchain_cert.pem
filename_private_key="$tailscale_hostname_fqdn"_private_key.key
path_fullchain_pem="$pathdir_certificates/$filename_fullchain_cert"
path_privatekey_pem="$pathdir_certificates/$filename_private_key"
logfile="/var/log/letsencrypt_tailscale.log"

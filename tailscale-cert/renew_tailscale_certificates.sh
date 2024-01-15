#/bin/sh
# make sure lineendings are only LF, not CRLF

# the certificate needs to be manually created, and will be updated via this script : 
# System / Certificates / Certificates / +ADD
#  - Method "Import an existing Certificate"
#  - descriptive name: as shown below
#  - certificate data :  the first portion of the fullchain.pem, stored in path $path_fullchain_pem
#  - private key data : the pricate key, stored in path $path_privatekey_pem
# the newly created certificate can then be used under System/Advanced/"SSL/TLS Certificate"
# the web gui has to be restarted to make the new certificate active.

# to run this script via cron every 2 months, 
# install package "Cron" and create an appropriate setting under Services/Cron


# Source Settings
. ./config.sh

# import functions
. ./lib/lib_webgui.sh
. ./lib/lib_log.sh
. ./lib/lib_tailscale.sh
. ./lib/lib_import_certificate.sh

# log
log_header "renew"

# show certificate location, to create the manual entry in /System/Certificates/Certificates
log_file_locations

# fetch tailscale fullchain certificate and private key
fetch_tailscale_certificates_and_key "$pathdir_certificates" "$filename_fullchain_cert" "$filename_private_key" "$tailscale_hostname_fqdn" 2>&1 | tee -a "$logfile"

# import the certificates into pfsence config
# /usr/local/pkg/acme/acme_command.sh importcert $certificatename $tailscale_domain $path_privatekey_pem $path_fullchain_pem $path_fullchain_pem $path_fullchain_pem 2>&1 | tee -a "$logfile"
# echo ""  | tee -a "$logfile"
import_certificate_to_pfsense_config $certificatename $tailscale_domain $path_privatekey_pem $path_fullchain_pem $path_fullchain_pem $path_fullchain_pem 2>&1 | tee -a "$logfile"

# restart webservice to use the new certificates
restart_webgui 2>&1 | tee -a "$logfile"

#log
log_footer "renewed"
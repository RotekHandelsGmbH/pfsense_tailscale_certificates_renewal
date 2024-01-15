#!/bin/sh

log_header() {
	# parameter1: method; "install" or "renew"
	local method=$1
	echo "---------------------------------------------------------------------------------" | tee -a "$logfile"
	date | tee -a "$logfile"
	echo "$method tailscale TLS certificates for host $tailscale_hostname_fqdn" | tee -a "$logfile"
	echo "certificates will be stored at: $pathdir_certificates" | tee -a "$logfile"
	echo "---------------------------------------------------------------------------------" | tee -a "$logfile"
}


log_file_locations() {
	# show certificate location, to create the manual entry in /System/Certificates/Certificates
	echo "certificates information:" | tee -a "$logfile"
	echo " - descriptive name      : $certificatename" | tee -a "$logfile"
	echo " - private key stored in : $path_privatekey_pem" | tee -a "$logfile"
	echo " - fullchain stored in   : $path_fullchain_pem" | tee -a "$logfile"
	echo "---------------------------------------------------------------------------------" | tee -a "$logfile"
}

log_footer() {
	# parameter1: method; "installed" or "renewed"
	local method=$1
	echo "certificates $method successfully." | tee -a "$logfile"
	echo "logfile see: $logfile"
	echo "---------------------------------------------------------------------------------" | tee -a "$logfile"
}

#!/bin/sh

log_header() {
	# parameter1: method; "install" or "renew"
	# shellcheck disable=SC2039
	local method="$1"
	# shellcheck disable=SC2154
	echo "---------------------------------------------------------------------------------" | tee -a "$logfile"
	date | tee -a "$logfile"
	# shellcheck disable=SC2154
	echo "$method tailscale TLS certificates for host $tailscale_hostname_fqdn" | tee -a "$logfile"
	# shellcheck disable=SC2154
	echo "certificates will be stored at: $pathdir_certificates" | tee -a "$logfile"
	echo "---------------------------------------------------------------------------------" | tee -a "$logfile"
}


log_file_locations() {
	# show certificate location, to create the manual entry in /System/Certificates/Certificates
	echo "certificates information:" | tee -a "$logfile"
	# shellcheck disable=SC2154
	echo " - descriptive name      : $certificatename" | tee -a "$logfile"
	# shellcheck disable=SC2154
	echo " - private key stored in : $path_privatekey_pem" | tee -a "$logfile"
	# shellcheck disable=SC2154
	echo " - fullchain stored in   : $path_fullchain_pem" | tee -a "$logfile"
	echo "---------------------------------------------------------------------------------" | tee -a "$logfile"
}

log_footer() {
	# parameter1: method; "installed" or "renewed"
	# shellcheck disable=SC2039
	local method="$1"
	echo "certificates $method successfully." | tee -a "$logfile"
	echo "logfile see: $logfile"
	echo "---------------------------------------------------------------------------------" | tee -a "$logfile"
}

#!/bin/sh

# import the certificates into pfsence config
import_certificate_to_pfsense_config() {
	# parameter1: certificatename; the descriptive certificate name used under /system/Certificates/Certificates
	# parameter2: tailscale_domain; the tailscale domain without the host like "tail?????.ts.net"
	# parameter3: path_privatekey; the full path to the private key
	# parameter4: path_cert; the full path to the certificate - You can also use the fullchain certificate here
	# parameter5: path_ca_cert; the full path to the ca certificate - You can also use the fullchain certificate here
	# parameter6: path_fullchain_cert; the full path to the fullchain certificate
	# shellcheck disable=SC2039
	local certificatename="$1"
	# shellcheck disable=SC2039
	local domain="$2"
	# shellcheck disable=SC2039
	local path_privatekey="$3"
	# shellcheck disable=SC2039
	local path_cert="$4"
	# shellcheck disable=SC2039
	local path_ca_cert="$5"
	# shellcheck disable=SC2039
	local path_fullchain_cert="$6"
	/usr/local/pkg/acme/acme_command.sh importcert "$certificatename" "$domain" "$path_privatekey" "$path_cert" "$path_ca_cert" "$path_fullchain_cert"
	echo ""
}


# import_certificate_to_pfsense_config "$certificatename" "$tailscale_domain" "$path_privatekey_pem" "$path_fullchain_pem" "$path_fullchain_pem" "$path_fullchain_pem" 2>&1 | tee -a "$logfile"
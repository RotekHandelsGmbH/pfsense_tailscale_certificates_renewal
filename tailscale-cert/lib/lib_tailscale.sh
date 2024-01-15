#!/bin/sh

fetch_tailscale_certificates_and_key() {
	# parameter1: pathdir_certificates; the path where the certificates should be stored, like /root/.tailscale-certificates/<tailscale_domain>
	# parameter2: filename_fullchain_cert; the filename of the fullchain certificate, like <tailscale_domain>_fullchain_cert.pem
	# parameter3: filename_privatekey; the filename of the private key, like <tailscale_domain>_private_key.key
	# parameter4: the full tailscale hostname, like <hostname>.tail<?????>.ts.net

	local pathdir_certificates=$1
	local filename_fullchain_cert=$2
	local filename_privatekey=$3
	local tailscale_hostname_fqdn=$4
	
	local path_fullchain_pem="$pathdir_certificates/$filename_fullchain_cert"
	local path_privatekey_pem="$pathdir_certificates/$filename_privatekey"
	
	mkdir -p "$pathdir_certificates"
	tailscale cert --cert-file "$path_fullchain_pem" --key-file "$path_privatekey_pem" "$tailscale_hostname_fqdn"
}

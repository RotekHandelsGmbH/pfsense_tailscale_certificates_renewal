#/bin/sh
# make sure lineendings are only LF, not CRLF

# restart webconfigurator after adding a new certificate
# function
restart_webconfigurator() { 
    /etc/rc.restart_webgui
}

# restart webgui to use the freshly imported certificates
# function
restart_webgui() { 
    /usr/local/sbin/pfSsh.php playback svc restart webgui
}

pfsense_tailscale_certificates_renewal
======================================

Shell scripts designed to install certificates that were not generated using pfSense's ``acme`` module.

While there are proposed solutions that involve directly editing the ``/conf/config.xml`` file with scripts, it is important to note that modifying the config.xml
file directly is a delicate operation and should be approached with caution.

If you choose to install such scripts, be sure to create a backup of the ``/conf/config.xml`` file before making any changes.

Here, we install certificates from Tailscale, but you can customize these scripts for your
specific application to import any other certificate. This process utilizes the ``acme-command.sh``
from the acme package, eliminating the need for direct manipulation of the ``config.xml`` file.

compatibility:
    - tested with pfSense 2.7.2 Release

skills You need to implement these scripts :
    - basic knowledge of the shell
    - some access via ``ssh`` to transfer files and issue commands
    - access to the firewalls web interface

prerequisites:
    - install and configure package ``tailscale`` on pfsense (if You want to use tailscale vpn)
    - if You dont use ``tailscale``, some method to copy your certificates to the firewall

preparation:
    - install package ``cron`` on pfsense
    - install package ``acme`` on pfsense

notes:
    - please note that ``pfsense`` needs ``<LF>`` line endings in ``sh`` scripts, ``<CR><LF>`` will not work.

step-by-step guide:
    - fill out the correct values in our `config.sh`
    - copy the files for instance to ``/usr/local/pkg/tailscale-cert``.
      We suggest to use ``bitvise`` ssh client and ``sftp``
    - enter the shell on pfsense, and get root by ``su``
    - set permissions : ``chmod -R 0755 /usr/local/pkg/tailscale-cert``
    - fetch certificates : ``/usr/local/pkg/tailscale-cert/renew_tailscale_certificates.sh``

    - the ``lets encrypt``  root and intermediate certificate should be now visible in the web gui:

    .. image:: images/01_pfsense_certificate_authorities.png
       :alt: pfsense certificate authorities
       :width: 800
       :align: center

    - create the entry for the certificate.
      the ``Descriptive name`` needs to match the setting in ``config.sh``
    - the ``Certificate data`` is the certificate which can be extracted from the first block of the ``fullchain.pem``
    - the ``Private key data`` is the private key

    .. image:: images/02_pfsense_certificate_create.png
       :alt: pfsense certificate create
       :width: 800
       :align: center

    - select Your certificate for the webConfigurator:

    .. image:: images/03_pfsense_certificate_webconfig.png
       :alt: pfsense certificate webConfigurator
       :width: 800
       :align: center

    - restart the webConfigurator, either by the pfSense console, or by calling
    ``/usr/local/pkg/tailscale-cert/renew_tailscale_certificates.sh``
    again.

    - create a cron setting (see last line). You can even run it daily or weekly,
      since tailscale simply will deliver the same certificates if no renewal is due :

    .. image:: images/04_pfsense_certificate_cron.png
       :alt: pfsense certificate cron job
       :width: 800
       :align: center


further information and inspirations :
    - https://forum.netgate.com/topic/132560/update-ssl-certificate-from-command-line
    - https://github.com/zxsecurity/pfsense-import-certificate/blob/master/pfsense-import-certificate.php
    - https://forums.lawrencesystems.com/t/upload-ssl-certificate-to-pfsense-via-ssh-and-restart-webconfigurator/6608/11




-------

Changelog

v.1.0.0     release

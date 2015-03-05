##
## Manage DNS and resolv.conf
##
class dnsmasq {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail('FAIL: This module (dnsmasq) is only for Debian based distributions! Aborting...')
    }

    include dnsmasq::install, dnsmasq::config, dnsmasq::service

}

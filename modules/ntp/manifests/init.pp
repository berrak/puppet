##
## Manage default NTP client and set up local NTP client/server
##
class ntp {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail('FAIL: This module (ntp) is only for Debian based distributions! Aborting...')
    }

    include ntp::install, ntp::config, ntp::service

}

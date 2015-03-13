#
# Manage rsyslog
#
class rsyslog {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail('FAIL: This module (rsyslog) is only for Debian based distributions! Aborting...')
    }

    include rsyslog::install, rsyslog::config, rsyslog::service

}
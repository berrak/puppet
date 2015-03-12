#
# Manage logrotate
#
class logrotate {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail('FAIL: This module (logrotate) is only for Debian based distributions! Aborting...')
    }

    include logrotate::install, logrotate::config

}
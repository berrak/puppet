##
## Manage logwatch
##
class logwatch {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail('FAIL: This module (logwatch) is only for Debian based distributions! Aborting...')
    }

    include logwatch::install, logwatch::config

}
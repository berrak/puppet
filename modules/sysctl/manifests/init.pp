##
## Hardening network. 
##
class sysctl {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail('FAIL: This module (sysctl) is only for Debian based distributions! Aborting...')
    }

    include sysctl::config

}
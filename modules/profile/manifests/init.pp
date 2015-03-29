##
## Technology Profiles
##
class profile {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail('FAIL: This module (profile) is only for Debian based distributions! Aborting...')
    }

    include profile::puppetize

}
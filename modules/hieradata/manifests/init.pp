##
## Manage Hiera configuration only!
##
class hieradata {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail('FAIL: This module (hieradata) is only for Debian based distributions! Aborting...')
    }

    include hieradata::config
}

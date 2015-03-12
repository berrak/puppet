##
## Manage user with sudo capability.
##
class sudo {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail('FAIL: This module (sudo) is only for Debian based distributions! Aborting...')
    }

    include sudo::install

}
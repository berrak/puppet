##
## Manage IDE's
##
class development_editors {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail('FAIL: This module (development_editors) is only for Debian based distributions! Aborting...')
    }

    include development_editors::install

}

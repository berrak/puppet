##
## Manage Hiera data
##
class hieradata {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail("FAIL: This module (hieradata) is only for Debian based distributions! Aborting...")
    }

    include hieradata::config, hieradata::params
}

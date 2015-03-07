##
## Manage local hosts file
##
class hosts {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail('FAIL: This module (hosts) is only for Debian based distributions! Aborting...')
    }

    include hosts::config

}

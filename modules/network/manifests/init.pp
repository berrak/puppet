#
# Manage networking
#
class network {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail('FAIL: This module (hosts) is only for Debian based distributions! Aborting...')
    }

    include network::install, network::config, network::service

}
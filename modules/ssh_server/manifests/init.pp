##
## Manage openssh server
##
class ssh_server {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail('FAIL: This module (ssh_server) is only for Debian based distributions! Aborting...')
    }

    include ssh_server::install, ssh_server::config, ssh_server::service

}
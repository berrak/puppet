##
## Manage NFSv4 clients
##
class nfs4_client {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail('FAIL: This module (nfs4_client) is only for Debian based distributions! Aborting...')
    }

    include nfs4_client::install, nfs4_client::config, nfs4_client::service

}

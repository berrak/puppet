##
## Manage Puppet server
##
class puppet_server {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail("FAIL: This module (puppet_server) is only for Debian based distributions! Aborting...")
    }

    include puppet_server::install, puppet_server::config, puppet_server::service, puppet_server::params
}

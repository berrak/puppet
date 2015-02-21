##
## Manage Puppet clients
##
class puppet_agent {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail("FAIL: This module (puppet_agent) is only for Debian based distributions! Aborting...")
    }
    
    include puppet_agent::install, puppet_agent::config, puppet_agent::service, puppet_agent::params
 
}

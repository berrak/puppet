##
## Bootstrap puppet
##
class puppet_bootstrap {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail('FAIL: This module (puppet_bootstrap) is only for Debian based distributions! Aborting...')
    }

    include puppet_bootstrap::install, puppet_bootstrap::params

}

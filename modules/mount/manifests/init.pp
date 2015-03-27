##
## Manage fstab and NFSv4 clients
##
class mount {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail('FAIL: This module (mount) is only for Debian based distributions! Aborting...')
    }

    include mount::install, mount::config, mount::service

}

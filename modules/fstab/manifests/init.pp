##
## Manage local fstab file
##
class hosts {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail('FAIL: This module (fstab) is only for Debian based distributions! Aborting...')
    }

    include fstab::config

}

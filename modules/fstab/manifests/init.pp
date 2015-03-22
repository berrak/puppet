##
## Manage local fstab file
##
class fstab {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail('FAIL: This module (fstab) is only for Debian based distributions! Aborting...')
    }

    include fstab::config

}

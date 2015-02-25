##
## Remove list of Debian packages
##
class debs::remove ( $deb_remove_list ) {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail('FAIL: This module (debs-remove) is only for Debian based distributions! Aborting...')
    }

    include apt_config

    # deb_remove_list is an array of Debian package names
    package { $deb_remove_list :
        ensure        => purged,
        allow_virtual => true,
    }

}
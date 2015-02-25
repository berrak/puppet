##
## Install list of Debian packages
##
class debs::install ( $deb_install_list ) {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail('FAIL: This module (debs-install) is only for Debian based distributions! Aborting...')
    }

    include apt_config

    # deb_install_list is an array of Debian package names
    package { $deb_install_list :
        ensure        => present,
        allow_virtual => true,
    }

}
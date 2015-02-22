##
## Customize root's .bashrc
##
class root_bashrc {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail("FAIL: This module (root_bashrc) is only for Debian based distributions! Aborting...")
    }

    include root_bashrc::config

}

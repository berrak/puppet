##
## Manage git
##
class git_client {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail("FAIL: This module (git_client) is only for Debian based distributions! Aborting...")
    }

    include git_client::install

}

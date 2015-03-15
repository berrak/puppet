##
## Manage postfix. Option for mail via ISP smtp relay host.
##
class postfix {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail('FAIL: This module (postfix) is only for Debian based distributions! Aborting...')
    }

    include postfix::install, postfix::config, postfix::service

}
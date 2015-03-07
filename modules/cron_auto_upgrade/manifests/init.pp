#
# Automatic Debian security updates
#
class cron_auto_upgrade {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail('FAIL: This module (dnsmasq) is only for Debian based distributions! Aborting...')
    }

    include cron_auto_upgrade::config

}

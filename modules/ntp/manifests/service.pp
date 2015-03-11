##
## Manage default NTP client and set up local NTP client/server
##
class ntp::service {

    service { 'ntp':
        ensure  => running,
        enable  => true,
        require => Class['ntp::config'],
    }

}

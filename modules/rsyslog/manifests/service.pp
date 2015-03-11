#
# Manage rsyslog
#
class rsyslog::service {

    service { 'rsyslog':
        ensure  => running,
        enable  => true,
        require => Class['rsyslog::config'],
    }

}
#
# Manage rsyslog
#
class rsyslog::config {

    file { '/etc/rsyslog.conf':
        source  => 'puppet:///modules/rsyslog/rsyslog.conf',
        owner   => 'root',
        group   => 'root',
        require => Class['rsyslog::install'],
        notify  => Class['rsyslog::service'],
    }

    file { '/etc/logrotate.d/rsyslog':
        source  => 'puppet:///modules/rsyslog/rsyslog',
        owner   => 'root',
        group   => 'root',
        require => Class['rsyslog::install'],
    }

    # Sript to test 'facilities.priorities' at command line
    file { '/root/bin/rsyslog.test':
        source  => 'puppet:///modules/rsyslog/rsyslog.test',
        owner   => 'root',
        group   => 'root',
        mode    => '0700',
        require => Class['rsyslog::install'],
    }

}
##
## Manage logwatch
##
class logwatch::config {

    file { '/etc/logwatch/conf/logwatch.conf':
        source  => 'puppet:///modules/logwatch/logwatch.conf',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        require => Class['logwatch::install'],
    }

    file { '/etc/cron.daily/00logwatch':
        source  => 'puppet:///modules/logwatch/00logwatch',
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        require => Class['logwatch::install'],
    }

}

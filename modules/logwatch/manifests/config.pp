##
## Manage logwatch
##
class logwatch::config {

    # HIERA lookup
    $logwatch_mailto = hiera( 'logwatch::config::logwatch_mailto' )

    file { '/etc/logwatch/conf/logwatch.conf':
        content =>  template( 'logwatch/logwatch.conf.erb' ),
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

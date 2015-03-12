#
# Manage logrotate
#
class logrotate::config {

    $mydomain = $::domain

    file { '/etc/logrotate.conf':
        content => template('logrotate/logrotate.conf.erb'),
        owner   => 'root',
        group   => 'root',
        require => Class['hp_logrotate::install'],
    }

}
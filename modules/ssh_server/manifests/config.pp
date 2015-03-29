##
## Manage openssh server
##
class ssh_server::config {

    $myhostname = $::hostname
    $mydomain   = $::domain

    file { '/etc/ssh/sshd_config' :
        source  => 'puppet:///modules/ssh_server/sshd_config',
        owner   => 'root',
        group   => 'root',
        require => Class['ssh_server::install'],
        notify  => Class['ssh_server::service'],
    }

    # Custom ssh login banner (i.e. warning for unauthorized access)
    file { '/etc/issue.net' :
        content => template( 'ssh_server/issue.net.erb' ),
        owner   => 'root',
        group   => 'root',
        require => Class['ssh_server::install'],
    }

}
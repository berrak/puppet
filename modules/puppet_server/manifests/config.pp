##
## Manage Puppet server
##
class puppet_server::config ( $server_fqdn, $server_ip ) {


    ## Install puppet-server configuration
    if $::ipaddress == $server_ip {

        ## This host is the puppet server!
        $puppet_server_ipaddress = $server_ip
        $puppet_server_fqdn = $server_fqdn

        notify { "Puppet server IPs ${puppet_server_ipaddress} known to puppet_server": loglevel => notice }
        notify { "Puppet server FQDN ${puppet_server_fqdn} known to puppet_server": loglevel => notice }

        $myhostname = $::hostname
        $mydomain   = $::domain

        file { '/etc/puppet/puppet.conf' :
            ensure  => present,
            content => template( 'puppet_server/puppet.conf.erb' ),
            owner   => 'root',
            group   => 'root',
            require => Class['puppet_server::install'],
            notify  => Class['puppet_server::service'],
        }

        file { '/etc/puppet/auth.conf' :
            ensure  => present,
            source  => 'puppet:///modules/puppet_server/auth.conf',
            owner   => 'root',
            group   => 'root',
            require => Class['puppet_server::install'],
            notify  => Class['puppet_server::service'],
        }

        file { '/etc/puppet/fileserver.conf' :
            ensure  => present,
            source  => 'puppet:///modules/puppet_server/fileserver.conf',
            owner   => 'root',
            group   => 'root',
            require => Class['puppet_server::install'],
            notify  => Class['puppet_server::service'],
        }

    }
}

##
## Manage Puppet server
##
class puppet_server::config {

    ## Must be included to use params!
    include puppet_server::params
    $puppet_server_ipaddress_local      = $::puppet_server::params::puppet_server_ipaddress_local
    $puppet_server_ipaddress_public_176 = $::puppet_server::params::puppet_server_ipaddress_public_176
    
    ## Install puppet-server configuration
    if (( $::ipaddress == $puppet_server_ipaddress_local ) or ( $::ipaddress == $puppet_server_ipaddress_public_176 )) {

        if ( $::ipaddress == $puppet_server_ipaddress_local ) {
            $puppet_server_fqdn = 'puppet.home.tld'
        }

        if ( $::ipaddress == $puppet_server_ipaddress_public_176 ) {
            $puppet_server_fqdn = 'puppet.triatagroup.com'
        }

        ## This host is the puppet server!
        $puppet_server_ipaddress = $::ipaddress

        notify { "Puppet server IPs ${puppet_server_ipaddress} known to puppet_server": loglevel => alert }
        notify { "Puppet server FQDN ${puppet_server_fqdn} known to puppet_server": loglevel => alert }

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

##
## Manage Puppet clients
##
class puppet_agent::config {

    ## Always created
    file { '/etc/puppet/files' :
        ensure  => directory,
        owner   => 'root',
        group   => 'root',
        require => Class['puppet_agent::install'],
    }

    ## Must be included to use params!
    include puppet_server::params
    $puppet_server_ipaddress_local      = $::puppet_server::params::puppet_server_ipaddress_local
    $puppet_server_ipaddress_public_176 = $::puppet_server::params::puppet_server_ipaddress_public_176

    ## Install agent configuration, unless this is the puppet-server
    if (( $::ipaddress == $puppet_server_ipaddress_local ) or ( $::ipaddress == $puppet_server_ipaddress_public_176 )) {
        notify { "Skipping agent configuration file since this is Puppet server": loglevel => notice }
    }
    else {

        ## is host in private network or in 176-public network
        if $::ipaddress =~ /^192\./ {
            $puppet_server_fqdn         = 'puppet.home.tld'
            $puppet_server_ipaddress    = '192.168.0.222'
        }
        elsif $::ipaddress =~ /^176\./ {
            $puppet_server_fqdn         = 'puppet.triatagroup.com'
            $puppet_server_ipaddress    = '176.10.168.227'
        }
        else {
            fail("FAIL: Host IPv4 ($::ipaddress) is not on any managed network!")
        }

        notify { "Puppet server IPs ${puppet_server_ipaddress} known to puppet_agent": loglevel => notice }
        notify { "Puppet server FQDN ${puppet_server_fqdn} known to puppet_agent": loglevel => notice }

        $myhostname = $::hostname
        $mydomain = $::domain

        file { '/etc/puppet/puppet.conf' :
            ensure  => present,
            content =>  template( 'puppet_agent/puppet.conf.erb' ),
            owner   => 'root',
            group   => 'root',
            require => Class['puppet_agent::install'],
            notify  => Class['puppet_agent::service'],
        }
    }
}

##
## Manage Puppet clients
##
class puppet_agent::config ( $server_fqdn, $server_ip ) {

    include puppet_agent

    ## Always created
    file { '/etc/puppet/files' :
        ensure  => directory,
        owner   => 'root',
        group   => 'root',
        require => Class['puppet_agent::install'],
    }

    ## Install agent configuration file, unless this is the puppet-server
    if $::ipaddress == $server_ip {
        notify { 'Skipping agent configuration file since this is Puppet server̈́': loglevel => notice }
    }
    else {

        $puppet_server_fqdn         = $server_fqdn
        $puppet_server_ipaddress    = $server_ip

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

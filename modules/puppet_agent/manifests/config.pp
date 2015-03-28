##
## Manage Puppet clients
##
class puppet_agent::config {


    # HIERA lookup
    $puppet_server_fqdn      = hiera('puppet_agent::config::puppet_server_fqdn_for_agent' )
    $puppet_server_ipaddress = hiera('puppet_agent::config::puppet_server_ip_for_agent' )

    ## Install agent configuration file, unless this is the puppet-server
    if $::ipaddress == $puppet_server_ipaddress {
        notify { 'Skipping agent configuration file since this is Puppet server̈́': loglevel => info }
    }
    else {

        notify { "Puppet server IPs ${puppet_server_ipaddress} known to puppet_agent": loglevel => info }
        notify { "Puppet server FQDN ${puppet_server_fqdn} known to puppet_agent": loglevel => info }

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

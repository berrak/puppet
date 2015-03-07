##
## Manage local hosts file (Puppet agent)
##
define hosts::agent ( $puppet_server_ip, $network_domain ) {

    $puppetserver_ip       = $puppet_server_ip
    $mypuppetserver_domain = $network_domain

    ## Only manage agent hosts file, unless this is the Puppet server
    if ! ( $::ipaddress == $puppet_server_ip ) {

        $myhostname = $::hostname

        ## HIERA lookup
        $host_ip               = hiera('host::config::host_ip')
        $myhost_domain         = hiera('host::config::myhost_domain')

        $gateway_ip            = hiera('host::config::gateway_ip')
        $mygateway_domain      = hiera('host::config::mygateway_domain')
        $gateway_hostname      = hiera('host::config::gateway_hostname')
    
        $smtp_ip               = hiera('host::config::smtp_ip')
        $mysmtp_domain         = hiera('host::config::mysmtp_domain')
        $smtp_hostname         = hiera('host::config::smtp_hostname')
    
        ## Add all other ip/hosts in this domain
        $in_domain_servers     = hiera("host::config::${::domain}::in_domain_servers")

        file { '/etc/hosts' :
            content => template( 'hosts/agent.hosts.erb' ),
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
        }
    } else {
        notify { "Puppet agent (${name}) hosts file is already configured as Puppet server - skipping...": loglevel => info }
    }

}

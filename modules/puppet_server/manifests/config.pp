##
## Manage Puppet server
##
class puppet_server::config {

	## Install puppet-server configuration
	if ( $::ipaddress in $::puppet_server::params::puppet_server_ipaddress_list ) {

        case $::ipaddress {
        '192.168.0.222' : { $puppet_server_fqdn = 'dell.home.tld' }
        '176.10.168.227': { $puppet_server_fqdn = 'dl380g7.triatagroup.com' }
        default         : { fail("FAIL: Puppet server ip-address missmatch with puppet_server params-file!") }
        }
        
        ## This host is the puppet server!
        $puppet_server_ipaddress = $::ipaddress

        $myhostname = $::hostname
        $mydomain = $::domain
           
        file { '/etc/puppet/puppet.conf' :
            ensure => present,
           content =>  template( 'puppet_server/puppet.conf.erb' ),    
             owner => 'root',
             group => 'root',
           require => Class['puppet_server::install'],
            notify => Class['puppet_server::service'],
        }
            
        file { '/etc/puppet/auth.conf' :
            ensure => present,
            source => 'puppet:///modules/puppet_server/auth.conf',
             owner => 'root',
             group => 'root',
           require => Class['puppet_server::install'],
            notify => Class['puppet_server::service'],
        }

        file { '/etc/puppet/fileserver.conf' :
            ensure => present,
            source => 'puppet:///modules/puppet_server/fileserver.conf',
             owner => 'root',
             group => 'root',
           require => Class['puppet_server::install'],
            notify => Class['puppet_server::service'],
        }
                
    }
}

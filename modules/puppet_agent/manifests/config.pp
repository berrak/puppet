##
## Manage Puppet clients
##
class puppet_agent::config {

	## Always created
    file { '/etc/puppet/files' :
        ensure => directory,
         owner => 'root',
         group => 'root',
       require => Class['puppet_agent::install'],
    }
	
	$puppet_server_ipaddress_list = $::puppet_agent::params::puppet_server_ipaddress_list
	notify { "Server IPs ${puppet_server_ipaddress_list} known to puppet_agent":
		loglevel => info,
	}
	
	## Install agent configuration, unless this is the puppet-server
	if ! ( $::ipaddress in $puppet_server_ipaddress_list ) {
	
		## is host in private network or in 176-public network
		if $::ipaddress =~ /^192\./ {
			$puppet_server_fqdn = 'puppet.home.tld'
			$puppet_server_ipaddress = '192.168.0.222'
		}
		elsif $::ipaddress =~ /^176\./ {
			$puppet_server_fqdn = 'puppet.triatagroup.com'
			$puppet_server_ipaddress = '176.10.168.227'
		}
		else {
			fail("FAIL: Host IPv4 ($::ipaddress) is not on any managed network!")
		}
			
		$myhostname = $::hostname	
		$mydomain = $::domain
		
		file { '/etc/puppet/puppet.conf' :
			ensure => present,
		   content =>  template( 'puppet_agent/puppet.conf.erb' ),    
			 owner => 'root',
			 group => 'root',
		   require => Class['puppet_agent::install'],
			notify => Class['puppet_agent::service'],
		}
	}
}
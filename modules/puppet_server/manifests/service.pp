##
## Manage Puppet server
##
class puppet_server::service {

	service { 'puppetmaster':
		 enable => true,
		 ensure => running,
		require => Class['puppet_server::install'],
	}
}

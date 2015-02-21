##
## Manage Puppet server
##
class puppet_server::install {
  
	package { 'puppetmaster':
			   ensure => latest,
		allow_virtual => true,
	}

}

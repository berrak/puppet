##
## Manage Hiera data
##
class hieradata::config {

    $puppet_server_ipaddress_list = $::hieradata::params::puppet_server_ipaddress_list
    notice "Server IPs ($puppet_server_ipaddress_list) known to hieradata"

    ## Install hieradata for puppet-server
	if ( $::ipaddress in $puppet_server_ipaddress_list ) {
    
        include puppet_server
    
        ## Install hiera configuration
        file { "/etc/puppet/hiera.yaml" :
             ensure => present,
             source => "puppet:///modules/hieradata/hiera.yaml",
              owner => 'root',
              group => 'root',
            require => Class["puppet_server::install"],
             notify => Class["puppet_server::service"],
        }
        
        file {'/etc/hiera.yaml':
            ensure => link,
            target => '/etc/puppet/hiera.yaml',
            require => File['/etc/puppet/hiera.yaml'],
        }
        
        file { '/etc/puppet/hieradata':
            ensure => directory,
        }
            
        file { '/etc/puppet/hieradata/node':
             ensure => directory,
            require => File['/etc/puppet/hieradata'],
        }
    
    }

}

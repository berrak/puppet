##
## Manage Hiera data
##
class hieradata::config {

    ## Must be included to use params!
    include puppet_server::params
    $puppet_server_ipaddress_local      = $::puppet_server::params::puppet_server_ipaddress_local
    $puppet_server_ipaddress_public_176 = $::puppet_server::params::puppet_server_ipaddress_public_176

    ## Install hieradata for puppet-server
    if (( $::ipaddress == $puppet_server_ipaddress_local ) or ( $::ipaddress == $puppet_server_ipaddress_public_176 )) {

        include puppet_server

        ## Install hiera configuration
        file { "/etc/puppet/hiera.yaml" :
            ensure  => present,
            source  => "puppet:///modules/hieradata/hiera.yaml",
            owner   => 'root',
            group   => 'root',
            require => Class["puppet_server::install"],
            notify  => Class["puppet_server::service"],
        }

        file {'/etc/hiera.yaml':
            ensure  => link,
            target  => '/etc/puppet/hiera.yaml',
            require => File['/etc/puppet/hiera.yaml'],
        }

        file { '/etc/puppet/hieradata':
            ensure => directory,
        }

        file { '/etc/puppet/hieradata/node':
            ensure  => directory,
            require => File['/etc/puppet/hieradata'],
        }

    }

}

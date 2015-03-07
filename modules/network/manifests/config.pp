#
# Manage network
#
class network::config {

    ## HIERA lookup
    $host_interface = hiera( 'network::config::interface' )
    $host_enslaved_interface = hiera( 'network::config::enslaved_interface', '' )
    
    $host_address   = hiera( 'network::config::ip' )
    $host_netmask   = hiera( 'network::config::netmask' )
    $host_network   = hiera( 'network::config::network' )
    $host_gateway   = hiera( 'network::config::gateway' )
    $host_broadcast = hiera( 'network::config::broadcast' )

    if ( $host_enslaved_interface == '' ) {

        file { '/etc/network/interfaces':
            content => template( 'network/interfaces.erb' ),
            owner   => 'root',
            group   => 'root',
            notify  => Class['network::service'],
            require => Class['network::install'],
        }
    } else {

        file { '/etc/network/interfaces':
            content => template( 'network/bridge.interfaces.erb' ),
            owner   => 'root',
            group   => 'root',
            notify  => Class['network::service'],
            require => Class['network::install'],
        }
    }

}

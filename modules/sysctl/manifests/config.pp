##
## Hardening network.
##
class sysctl::config {

    # HIERA lookups
    $kernel_domain_name = hiera( 'sysctl::config::kernel_domain_name' )
    $ipv4_forwarding    = hiera( 'sysctl::config::ipv4_forwarding' )
    $ipv6_forwarding    = hiera( 'sysctl::config::ipv6_forwarding' )

    file { '/etc/sysctl.conf':
        content =>  template( 'sysctl/sysctl.conf.erb' ),
        owner   => 'root',
        group   => 'root',
        notify  => Exec['UPDATING_KERNEL_SYSCTL_CONFIGURATION'],
    }

    exec { 'UPDATING_KERNEL_SYSCTL_CONFIGURATION' :
        command     => '/sbin/sysctl -p',
        refreshonly => true,
    }

}

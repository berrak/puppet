##
## Manage DNS and resolv.conf
##
class dnsmasq::config {

    ## HIERA lookup
    $mydns1            = hiera( 'dnsmasq::config::mydns1' )
    $mydns2            = hiera( 'dnsmasq::config::mydns2' )
    $primary_interface = hiera( 'dnsmasq::config::primary_interface' )

    $hostip = $::ipaddress

    file { '/etc/resolv.conf' :
        content => template( 'dnsmasq/resolv.conf.erb' ),
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
    }

    file { '/etc/dnsmasq.conf' :
        content =>  template( 'dnsmasq/dnsmasq.conf.erb' ),
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        notify  => Class['dnsmasq::service'],
    }

}

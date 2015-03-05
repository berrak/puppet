##
## Manage DNS and resolv.conf
##
class dnsmasq::service {

    service { 'dnsmasq' :
        ensure  => running,
        enable  => true,
        require => Class['dnsmasq::install'],
    }

}
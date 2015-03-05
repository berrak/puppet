##
## Manage DNS and resolv.conf
##
class dnsmasq::install {

    package { "dnsmasq" :
        ensure        => present,
        allow_virtual => true,
    }

}

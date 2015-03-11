##
## Manage default NTP client and set up local NTP client/server
##
class ntp::install {

    package { 'ntp' :
        ensure        => present,
        allow_virtual => true,
    }

}

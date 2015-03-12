##
## Manage user with sudo capability.
##
class sudo::install {

    package { 'sudo' :
        ensure        => present,
        allow_virtual => true,
    }

}
#
# Manage network
#
class network::install {

    # configure network bridge
    package { "bridge-utils" :
        ensure        => installed,
        allow_virtual => true,
    }

    # remove bloating
    package { "network-manager" :
        ensure        => purged,
        allow_virtual => true,
    }

}
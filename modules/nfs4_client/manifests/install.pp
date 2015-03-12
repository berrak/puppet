##
## Manage NFSv4 clients
##
class nfs4_client::install {

    package { 'nfs-common' :
        ensure        => installed,
        allow_virtual => true,
    }

}

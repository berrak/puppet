##
## Manage NFSv4 clients
##
class nfs4_client::service {

    service { 'nfs-common':
        ensure  => running,
        enable  => true,
        require => Class['nfs4_client::config'],
    }

}

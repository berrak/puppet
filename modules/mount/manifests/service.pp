##
## Manage fstab and NFSv4 clients
##
class mount::service {

    include stdlib

    # HIERA lookup - any local NFS4 client install?
    $is_nfs_consumer = hiera('mount::service::is_nfs_consumer')

    if ( str2bool($is_nfs_consumer) ) {

        service { 'nfs-common':
            ensure  => running,
            enable  => true,
            require => Class['mount::config'],
        }
    }

}

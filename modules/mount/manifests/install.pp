##
## Manage fstab and NFSv4 clients
##
class mount::install {

    include stdlib

    # HIERA lookup - any local NFS4 client install?
    $is_nfs_consumer = hiera('mount::install::is_nfs_consumer')

    if ( str2bool($is_nfs_consumer) ) {

        package { 'nfs-common' :
            ensure        => installed,
            allow_virtual => true,
        }
    }

}

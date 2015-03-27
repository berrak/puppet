##
## Manage fstab and NFSv4 clients
##
class mount::install {

    # HIERA lookup - any local NFS4 client install?
    $in_host_nfs_fstab_entries = hiera("mount::config::${::hostname}::in_host_nfs_fstab_entries", '')

    if ! (  $in_host_nfs_fstab_entries == '' ) {

        package { 'nfs-common' :
            ensure        => installed,
            allow_virtual => true,
        }
    }

}

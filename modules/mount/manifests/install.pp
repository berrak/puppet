##
## Manage fstab and NFSv4 clients
##
class mount::install {

    # HIERA lookup - any local NFS4 client install?
    $has_nfs_entries_for_install = hiera("mount::config::${::hostname}::in_host_nfs_fstab_entries", '')

    if ! (  $has_nfs_entries_for_install == '' ) {

        package { 'nfs-common' :
            ensure        => installed,
            allow_virtual => true,
        }
    }

}

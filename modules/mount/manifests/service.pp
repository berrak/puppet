##
## Manage fstab and NFSv4 clients
##
class mount::service {

    # HIERA lookup - any local NFS4 client install?
    $in_host_nfs_fstab_entries = hiera("mount::config::${::hostname}::in_host_nfs_fstab_entries", '')

    if ! (  $in_host_nfs_fstab_entries == '' ) {

        service { 'nfs-common':
            ensure  => running,
            enable  => true,
            require => Class['mount::config'],
        }
    }

}

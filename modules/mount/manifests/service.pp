##
## Manage fstab and NFSv4 clients
##
class mount::service {

    # HIERA lookup - any local NFS4 client install?
    $has_nfs_entries_for_service = hiera("mount::config::${::hostname}::in_host_nfs_fstab_entries", '')

    if ! (  $has_nfs_entries_for_service == '' ) {

        service { 'nfs-common':
            ensure  => running,
            enable  => true,
            require => Class['mount::config'],
        }
    }

}

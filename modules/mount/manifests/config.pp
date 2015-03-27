##
## Manage fstab and NFSv4 clients
##
class mount::config {

    $myhostname = $::hostname

    ## HIERA lookup
    $is_managed_fstab_file     = hiera('mount::config::is_managed_fstab_file')

    ## Add each user NFSv4-share to fstab - default to empty string
    $in_host_nfs_fstab_entries = hiera("mount::config::${::hostname}::in_host_nfs_fstab_entries", '')

    if ( str2bool($is_managed_fstab_file) ) {

        file { '/etc/fstab' :
            content => template( "fstab/${myhostname}.fstab.erb" ),
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
        }

    }

    # HIERA lookup - any local NFS4 client install?
    $in_host_nfs_fstab_entries = hiera("mount::config::${::hostname}::in_host_nfs_fstab_entries", '')

    if ! (  $in_host_nfs_fstab_entries == '' ) {

        file { '/etc/default/nfs-common':
            source => 'puppet:///modules/mount/nfs-common',
            owner  => 'root',
            group  => 'root',
            notify => Class['mount::service'],
        }

        $mydomain = $::domain
    
        # UID/GID mapping daemon

        file { '/etc/idmapd.conf':
            content =>  template( 'mount/idmapd.conf.erb' ),
            owner   => 'root',
            group   => 'root',
            notify  => Class['mount::service'],
        }
    }

}

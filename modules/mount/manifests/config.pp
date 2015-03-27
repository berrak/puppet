##
## Manage fstab and NFSv4 clients
##
class mount::config {

    include stdlib

    $myhostname = $::hostname

    ## HIERA lookup
    $is_managed_fstab_file = hiera('mount::config::is_managed_fstab_file')

    ## Add each user NFSv4-share to fstab - default to empty string
    $in_host_nfs_fstab_entries = hiera("mount::config::${::hostname}::in_host_nfs_fstab_entries", '')

    if ( str2bool($is_managed_fstab_file) ) {

        file { '/etc/fstab' :
            content => template( "mount/${myhostname}.fstab.erb" ),
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
        }

    }


    $is_nfs_consumer = hiera('mount::config::is_nfs_consumer')

    if ( str2bool($is_nfs_consumer) ) {

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

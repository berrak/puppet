##
## Manage local fstab file
##
class fstab::config {

    $myhostname = $::hostname

    ## HIERA lookup
    $is_managed_fstab_file     = hiera('fstab::config::is_managed_fstab_file')

    ## Add each user NFSv4-share to fstab - default to empty string
    $in_host_nfs_fstab_entries = hiera("fstab::config::${::hostname}::in_host_nfs_fstab_entries", '')

    if ( str2bool($is_managed_fstab_file) ) {

        file { '/etc/fstab' :
            content => template( "fstab/${myhostname}.fstab.erb" ),
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
        }
    
    }

}

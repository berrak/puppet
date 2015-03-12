##
## Manage NFSv4 client
##
class nfs4_client::config {

    file { '/etc/default/nfs-common':
        source => 'puppet:///modules/nfs4_client/nfs-common',
        owner  => 'root',
        group  => 'root',
        notify => Class['nfs4_client::service'],
    }

    $mydomain = $::domain

    # UID/GID mapping daemon

    file { '/etc/idmapd.conf':
        content =>  template( 'nfs4_client/idmapd.conf.erb' ),
        owner   => 'root',
        group   => 'root',
        notify  => Class['nfs4_client::service'],
    }

}

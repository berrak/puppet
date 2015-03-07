#
# Manage network
#
class network::service {

    service { 'networking':
        ensure  => running,
        enable  => true,
        require => Class['network::install'],
    }

}
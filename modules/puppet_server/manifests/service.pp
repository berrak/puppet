##
## Manage Puppet server
##
class puppet_server::service {

    service { 'puppetmaster':
        ensure  => running,
        enable  => true,
        require => Class['puppet_server::install'],
    }
}

##
## Manage openssh server
##
class ssh_server::service {

    service { 'ssh' :
        ensure  => running,
        enable  => true,
        require => Class['ssh_server::config'],
    }

}
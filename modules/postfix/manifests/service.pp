##
## Manage local postfix. In/outgoing mail via ISP smtp host. 
##
class postfix::service {

    service { 'postfix' :
        ensure  => running,
        enable  => true,
        require => Class['postfix::config'],
    }

}